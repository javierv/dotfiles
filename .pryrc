#!/usr/bin/env ruby

Pry.config.editor = "vim"

def show_sql
  ActiveRecord::Base.logger = Logger.new(STDOUT) if defined?(ActiveRecord)
end

##### INTEGRATION WITH BUNDLER #####

# Allow loading gems not inside Gemfile. Extracted from irbtools README.
if defined?(Gem.post_reset_hooks)
  Gem.post_reset_hooks.reject!{ |hook| hook.source_location.first =~ %r{/bundler/} }
  Gem::Specification.reset
  load 'rubygems/custom_require.rb'
  alias gem require
end

##### INTEGRATION WITH RAILS #####
# Note: Only for Rails 3.2; for Rails 3.1 we need a different way.
# if defined?(Rails) && Rails.env
#   extend Rails::ConsoleMethods
# end

##### EXTRA METHODS #####

class Object
  def interesting_methods
    case self.class
    when Class
      self.public_methods.sort - Object.public_methods
    when Module
      self.public_methods.sort - Module.public_methods
    else
      self.public_methods.sort - Object.new.public_methods
    end
  end
end


##### EXTRA LIBRARIES #####

# Although some of these libraries are automatically loaded when
# starting pry, they aren't automatically loaded when starting
# pry from irb (like I do for rails console).

def require_if_available(gem, &block)
  begin
    require gem
    block.call if block_given?
  rescue LoadError
    warn "Warning: #{gem} is missing; gem install #{gem}"
  end
end

require_if_available("methodfinder")
require_if_available("pry-stack_explorer")
require_if_available("pry-vterm_aliases")
require_if_available("bond")

require_if_available("awesome_print") { AwesomePrint.pry!  }
require_if_available('pry-doc') { Pry.commands.alias_command 'doc', 'show-doc' }

# Reminder not to install coolline because it breaks readline's vi-mode.
# require_if_available("pry-coolline") 
# Reminder I didn't manage to make the exception explorer work.
# require_if_available("pry-exception_explorer")

##### Shortcuts #####

require_if_available('pry-debugger') do
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
  Pry.commands.alias_command 'b', 'break'
end
