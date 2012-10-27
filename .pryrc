#!/usr/bin/env ruby

require 'methodfinder'

Pry.config.editor = "vim"

# requires pry-debugger TODO: add it explicitely.
Pry.commands.alias_command 'c', 'continue'
Pry.commands.alias_command 's', 'step'
Pry.commands.alias_command 'n', 'next'
Pry.commands.alias_command 'f', 'finish'
Pry.commands.alias_command 'b', 'break'

Pry.commands.alias_command 'doc', 'show-doc'

# Load rails environment if in a rails folder
rails = File.join Dir.getwd, 'config', 'environment.rb'

if File.exist?(rails) && ENV['SKIP_RAILS'].nil?
  require rails
  require 'rails/console/app'
  require 'rails/console/helpers'
end
