Finally making this public. Have not gotten around to a full README yet, but will soon.

An important "feature" to note is `koppa`, other items you can just poke around.

## Ϟ koppa
All files that have the suffix `__` are template files that are parsed by `koppa`.
Template files contain variables to be replaced for the final output file.
It also restarts services so changes happen on the fly (see config).

Basics:
- run `koppa mk all` to generate all configs at once, or `koppa mk hypr`
- a template file must contain `__` suffix before the file extension, or end in `__` if no file extension
- a template file will generate a config file with the _exact same name_, simply `__` is removed
- generated configs are write protected
- if you want a hidden template file, but not the generated file, add a comment with `koppa:unhide` at end of file (see `~/.config/environment.d` for an example)
- `%{variable_name}%` - is the default syntax for variables
- `"!{variable_name}!"` - alternate syntax, aids in not breaking language syntax highlighting in editors
- usage is mainly to keep consistent color pallete (vibra16.3 to be published soon)
- color variables are by default in hex, if you want to output them in rgb simply add `--rgb` to the variable:
  - `%{red}%` = `ff0000`
  - `%{red--rgb}%` = `255, 0, 0`

Related koppa files:

- `~/.local/bin` for script
- `~/.local/share/zsh` for autocomplete
- `~/.config/koppa` for configuration

Lastly, improvements/suggestions welcome for this little script...
