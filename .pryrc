Pry.config.editor = "vim"

# requires pry-debugger TODO: add it explicitely.
Pry.commands.alias_command 'c', 'continue'
Pry.commands.alias_command 's', 'step'
Pry.commands.alias_command 'n', 'next'
Pry.commands.alias_command 'f', 'finish'
Pry.commands.alias_command 'b', 'break'
