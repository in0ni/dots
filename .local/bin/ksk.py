#!/usr/bin/python
# TODO: catch errors and display in rofi
#
import os
import sys
import signal
import argparse
from i3ipc import Connection, Event

# TODO: standardize use of run/check_output/Popen
# 		coming form a shell script, so just made it work.
from subprocess import check_output, run, Popen, DEVNULL


def get_session():
    if os.environ.get("KAKOUNE_SESSION") is not None:
        return os.environ["KAKOUNE_SESSION"]
    else:
        return os.path.basename(os.getcwd())


def new_client(name, win_type):
    kitty_cmd = "kitty @ launch"
    win_title = f'--title "{base_window_title}{name}"'
    base_args = "--no-response --type os-window --os-window-class kskide"

    kak_cmd = f'kak -e "ide-set-client {name} {win_type}" -c "{session}"'
    shell_cmd = f"{kitty_cmd} {win_title} {base_args} {kak_cmd}"

    run(shell_cmd, shell=True)
    focused = ipc.get_tree().find_focused()
    focused.command(f"mark {session}::{name}")
    return focused


def new_shell(name, arg_string=None):
    base_args = "--no-response --type os-window --os-window-class kskide"
    win_title = f'--title "{base_window_title}{name}"'
    shell_cmd = f"kitty @ launch {win_title} {base_args}"

    if arg_string is not None:
        shell_cmd += f" {arg_string}"

    run(shell_cmd, shell=True)
    focused = ipc.get_tree().find_focused()
    focused.command(f"mark {session}::{name}")
    return focused


def bind_keys(ipc, event):
    con = event.container
    bind_windows = []

    for window in ipc.get_tree():
        if window.app_id == "kskide":
            bind_windows.append(window)

    # if there are no windows left... just close bitch
    if not len(bind_windows):
        kill(ipc)

    if con.app_id != "kskide":
        unbind_keys(ipc)
    else:
        if len(con.marks):
            # XXX: this is will break if marks are added
            session = con.marks[0].split("::")[0]

            ipc.command(f'bindsym Alt+7 [con_mark="{session}::main"] focus')
            ipc.command(f'bindsym Alt+8 [con_mark="{session}::docs"] focus')
            ipc.command(f'bindsym Alt+9 [con_mark="{session}::tools"] focus')
            ipc.command(f'bindsym Alt+0 [con_mark="{session}::shell"] focus')


def kill(ipc):
    unbind_keys(ipc)
    ipc.main_quit()
    sys.exit(0)


def unbind_keys(ipc):
    ipc.command("unbindsym Alt+7")
    ipc.command("unbindsym Alt+8")
    ipc.command("unbindsym Alt+9")
    ipc.command("unbindsym Alt+0")


def create_layout():
    global win_main, win_docs, win_tools, win_shell

    win_main = new_client("main", "jumpclient")
    win_docs = new_client("docs", "docsclient")

    ipc.command("splitv")

    win_tools = new_client("tools", "toolsclient")

    ipc.command("splith; layout tabbed")

    win_shell = new_shell("shell")

    win_tools.command("focus")
    win_main.command("focus")

    # we don't want to close windows/clients, rather buffers
    # if anything we want to quit the session
    # TODO: add support for closing clients/session and reopening
    run(f'echo "alias global q delete-buffer" | kak -p {session}', shell=True)
    run(f'echo "alias global q! delete-buffer!" | kak -p {session}', shell=True)
    run(f'echo "unalias global wq"  | kak -p {session}', shell=True)
    run(f'echo "unalias global wq!" | kak -p {session}', shell=True)
    run(f'echo "unalias global waq" | kak -p {session}', shell=True)


def rofi_projects():
    global rofi_title, rofi_proj_file

    get_rofi_menu = check_output(
        f'cut -d ";" -f 1 < {rofi_proj_file}', shell=True, encoding="utf-8"
    )
    run_rofi_selection = run(
        f'echo -en "{get_rofi_menu}" | rofi -dmenu -i -p "{rofi_title}"',
        shell=True,
        encoding="utf-8",
        capture_output=True,
    )

    # only continue if selection made
    if run_rofi_selection.stdout:
        session = run_rofi_selection.stdout.strip()
        get_session_path = check_output(
            f'grep "{session}" < {rofi_proj_file} | cut -d ";" -f 2',
            shell=True,
            encoding="utf-8",
        )

        path = get_session_path.strip()
        env_vars = {**os.environ, "KAKOUNE_SESSION": session}

        run(f'kitty -d "{path}" ksk.py &', shell=True, env=env_vars)

    sys.exit(0)


if __name__ == "__main__":
    icon = ""
    session = get_session()
    base_window_title = f"{icon}  {session}::"

    rofi_title = f"{icon}  Kakoune Projects"
    rofi_proj_file = "${XDG_CONFIG_HOME}/kskide.projs"

    win_main = None
    win_docs = None
    win_tools = None
    win_shell = None

    parser = argparse.ArgumentParser(
        description="This script allows you to launch rofi with project list."
    )
    parser.add_argument(
        "-p",
        "--projects",
        action="store_true",
        help="open rofi menu listing projects",
    )
    parser.add_argument(
        "-b",
        "--bindkeys",
        action="store_true",
        help="listen to window focus event and bind keys",
    )
    args = parser.parse_args()

    if args.projects:
        rofi_projects()
    elif args.bindkeys:
        # unbind all keys
        ipc = Connection()
        for sig in [signal.SIGINT, signal.SIGTERM]:
            signal.signal(sig, lambda signal, frame: kill(ipc))

        ipc.on(Event.WINDOW_FOCUS, bind_keys)
        ipc.main()
    else:
        ipc = Connection()
        has_socket = run(f'kak -l | grep -q "{session}"', shell=True)
        keybinder_pid = run(
            'pgrep -f "ksk.py -b"', shell=True, stdout=DEVNULL, stderr=DEVNULL
        )

        if has_socket.returncode == 0:
            # TODO: support to join session (check for open clients/windows)
            print(f'Session "{session}" already exist')
        else:
            if keybinder_pid.returncode != 0:
                # TODO:
                # https://unix.stackexchange.com/questions/506537/nohup-ignoring-input-and-appending-output-to-nohup-out
                Popen(["nohup", "ksk.py", "-b"], stdout=DEVNULL, stderr=DEVNULL)

            Popen(["setsid", "kak", "-d", "-s", session], stdout=DEVNULL)
            create_layout()
