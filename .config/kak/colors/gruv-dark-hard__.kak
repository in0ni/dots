# gruvbox theme

evaluate-commands %sh{
    gray="rgb:%{{gruv_gray}}"
    red="rgb:%{{gruv_dark_red}}"
    green="rgb:%{{gruv_dark_green}}"
    yellow="rgb:%{{gruv_dark_yellow}}"
    blue="rgb:%{{gruv_dark_blue}}"
    purple="rgb:%{{gruv_dark_purple}}"
    aqua="rgb:%{{gruv_dark_aqua}}"
    orange="rgb:%{{gruv_dark_orange}}"

    bg="rgb:%{{gruv_dark_bg_0_h}}"
    bg1="rgb:%{{gruv_dark_bg_1}}"
    bg2="rgb:%{{gruv_dark_bg_2}}"
    bg3="rgb:%{{gruv_dark_bg_3}}"
    bg4="rgb:%{{gruv_dark_bg_4}}"

    fg0="rgb:%{{gruv_light_bg_0}}"
    fg="rgb:%{{gruv_light_bg_0_h}}"
    fg2="rgb:%{{gruv_light_bg_2}}"
    fg3="rgb:%{{gruv_light_bg_3}}"
    fg4="rgb:%{{gruv_light_bg_4}}"

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

        # lsp
        face global SnippetsNextPlaceholders ${fg},${purple}+uF
        face global SnippetsOthersPlaceholders ${fg},${purple}+F

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
