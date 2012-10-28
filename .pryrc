#!/usr/bin/env ruby

Pry.config.editor = "vim"


##### INTEGRATION WITH RAILS AND BUNDLER #####

# Load rails environment if in a rails folder
rails = File.join Dir.getwd, 'config', 'environment.rb'

if File.exist?(rails) && ENV['SKIP_RAILS'].nil?
  require rails
  require 'rails/console/app'
  require 'rails/console/helpers'

  ActiveRecord::Base.logger = Logger.new(STDOUT)

  # Allow loading gems not inside Gemfile. Extracted from irbtools README.
  if defined?(Gem.post_reset_hooks)
    Gem.post_reset_hooks.reject!{ |hook| hook.source_location.first =~ %r{/bundler/} }
    Gem::Specification.reset
    load 'rubygems/custom_require.rb'
    alias gem require
  end
end


##### EXTRA LIBRARIES #####

def require_if_available(gem, &block)
  begin
    require gem
    block.call if block_given?
  rescue LoadError
    warn "Warning: #{gem} is missing; gem install #{gem}"
  end
end

require_if_available("methodfinder")

require_if_available("awesome_print") do
  AwesomePrint.pry!
end

##### Shortcuts #####

# requires pry-debugger TODO: add it explicitely.
Pry.commands.alias_command 'c', 'continue'
Pry.commands.alias_command 's', 'step'
Pry.commands.alias_command 'n', 'next'
Pry.commands.alias_command 'f', 'finish'
Pry.commands.alias_command 'b', 'break'

Pry.commands.alias_command 'doc', 'show-doc'

# TODO: better autocompletion (bond?)
# TODO: use a "sandbox" like Rails console does.
