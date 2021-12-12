# gruvbox theme

evaluate-commands %sh{
    gray="rgb:928374"
    red="rgb:fb4934"
    green="rgb:b8bb26"
    yellow="rgb:fabd2f"
    blue="rgb:83a598"
    purple="rgb:d3869b"
    aqua="rgb:8ec07c"
    orange="rgb:fe8019"

    bg="rgb:282828"
    bg1="rgb:3c3836"
    bg2="rgb:504945"
    bg3="rgb:665c54"
    bg4="rgb:7c6f64"

    fg0="rgb:f9f5d7"
    fg="rgb:ebdbb2"
    fg2="rgb:d5c4a1"
    fg3="rgb:bdae93"
    fg4="rgb:a89984"

    echo "
        # Code highlighting
        face global value         ${purple}
        face global type          ${yellow}
        face global variable      ${blue}
        face global module        ${green}+i
        face global function      ${blue}+i
        face global string        ${green}
        face global keyword       ${red}
        face global operator      ${aqua}
        face global attribute     ${orange}
        face global comment       ${bg4}+i
        face global documentation comment

        face global meta          ${aqua}+i
        face global builtin       ${fg}+b

        # Markdown highlighting
        face global title     ${green}+b
        face global header    ${orange}
        face global mono      ${fg4}
        face global block     ${aqua}
        face global link      ${blue}+u
        face global bullet    ${yellow}
        face global list      ${fg}

        face global Default            ${fg},${bg}
        face global PrimarySelection   ${bg},${orange}+fg
        face global SecondarySelection ${bg2},${orange}+fg
        face global PrimaryCursor      ${bg},${red}+fg
        face global SecondaryCursor    ${bg},${gray}+fg
        face global PrimaryCursorEol   ${bg},${fg4}+fg
        face global SecondaryCursorEol ${bg},${bg2}+fg
        face global LineNumbers        ${bg4}
        face global LineNumberCursor   ${yellow},${bg1}
        face global LineNumbersWrapped ${bg1}
        face global MenuForeground     ${bg},${orange}
        face global MenuBackground     ${fg},${bg2}
        face global MenuInfo           ${fg}
        face global Information        ${bg},${fg2}
        face global Error              ${bg},${red}
        face global StatusLine         ${yellow},${bg1}
        face global StatusLineMode     ${bg},${orange}+b
        face global StatusLineInfo     ${aqua}
        face global StatusLineValue    ${blue}
        face global StatusCursor       ${bg1},${orange}
        face global Prompt             ${purple}
        face global MatchingChar       ${fg},${bg3}+b
        face global BufferPadding      ${bg2},${bg}
        face global Whitespace         ${bg2}+f
    "
}
