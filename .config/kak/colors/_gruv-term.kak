evaluate-commands %sh{
    gray="rgb:%{{theme_dark_4}}"
    red="rgb:%{{b16_01_red}}"
    green="rgb:%{{b16_02_green}}"
    yellow="rgb:%{{b16_03_yellow}}"
    blue="rgb:%{{b16_04_blue}}"
    purple="rgb:%{{b16_05_purple}}"
    aqua="rgb:%{{b16_06_aqua}}"
    orange="rgb:%{{b16_11_yellow}}"

    bg="rgb:%{{theme_dark_0}}"
    bg1="rgb:%{{theme_dark_1}}"
    bg2="rgb:%{{theme_dark_2}}"
    bg3="rgb:%{{theme_dark_3}}"
    bg4="rgb:%{{theme_dark_4}}"

    fg="rgb:%{{theme_light_0}}"
    fg0="rgb:%{{theme_light_1}}"
    fg2="rgb:%{{theme_light_2}}"
    fg3="rgb:%{{theme_light_3}}"
    fg4="rgb:%{{theme_light_4}}"

    echo "
        # Code highlighting
        face global value         ${purple}
        face global type          ${yellow}
        face global variable      ${blue}
        face global module        ${green}
        face global function      ${blue}
        face global string        ${green}
        face global keyword       ${red}
        face global operator      ${aqua}
        face global attribute     ${orange}
        face global comment       ${bg4}+i
        face global documentation comment

        face global meta          ${aqua}
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
