# essentially a copy of colorscheme command, just sets a 'colorscheme' option
# to the current colorscheme
declare-option str colorscheme 'default'
def -params 1 -docstring "colorscheme <name>: enable named colorscheme" \
  -shell-script-candidates %{
  find -L "${kak_runtime}/colors" "${kak_config}/colors" -type f -name '*\.kak' \
    | while read -r filename; do
      basename="${filename##*/}"
      printf %s\\n "${basename%.*}"
    done | sort -u
  } \
  cs %{ evaluate-commands %sh{
    find_colorscheme() {
      find -L "${1}" -type f -name "${2}".kak | head -n 1
    }

    filename=""
    if [ -d "${kak_config}/colors" ]; then
      filename=$(find_colorscheme "${kak_config}/colors" "${1}")
    fi
    if [ -z "${filename}" ]; then
      filename=$(find_colorscheme "${kak_runtime}/colors" "${1}")
    fi
    if [ -n "${filename}" ]; then
      echo "set-option global colorscheme ${1}"
      printf 'source %%{%s}' "${filename}"
    else
      echo "fail 'No such colorscheme'"
    fi
}}

