#!/usr/bin/env ruby

class DotfilesInstaller
  def install
    install_submodules
    create_symlinks
    copy_gitconfig
    create_local_configurations
    install_vim_plugins
    install_gems
    switch_to_zsh
  end

  def install_submodules
    puts "Installing submodules"
    %x[cd #{original_folder} && git submodule update --init]
  end

  def switch_to_zsh
    unless ENV["SHELL"] =~ /zsh/
      puts "using zsh"
      %x[chsh -s `which zsh`]
    end
  end

  def create_symlinks
    puts "Creating symlinks"
    symlinked_files.each do |file|
      destination_file = destination_path(file)
      if File.exist? destination_file
        %x[rm -rf #{destination_file}]
      end
      %x[ln -s #{absolute_path(file)} #{destination_file}]
      puts "Symlinked #{file}"
    end
  end

  def copy_gitconfig
    unless File.exist?(destination_path('.gitconfig'))
      %x[cp #{absolute_path('.gitconfig')} #{destination_folder}]
      puts "Copied gitconfig file"
    end
  end

  def create_local_configurations
    create_local_zshrc

    %w[.vimrc.local .aliases].each do |file|
      unless File.exist?(destination_path(file))
        %x[touch #{destination_path(file)}]
        puts "Created #{file}"
      end
    end
  end

  def install_vim_plugins
    puts "Installing vim plugins"
    %x[vim +Pack +qall]
  end

  def install_gems
    puts "Installing gems"
    %x[gem install #{development_gems.join(' ')}]
  end

  def create_local_zshrc
    unless File.exist?(destination_path('.zshrc.local'))
      # Make a different prompt, so I know it's a different machine.
      %x[echo "PROMPT='%n@%m:%~> '" > #{destination_path('.zshrc.local')}]
      puts "Created .zshrc.local"
    end 
  end

private
  def destination_folder
    ENV['HOME']
  end

  def destination_path(file)
    File.join destination_folder, file
  end

  def original_folder
    File.expand_path '..', __FILE__
  end

  def symlinked_files
    %w[bin .inputrc .irbrc .pryrc .tmux.conf .vim .vimrc .Xmodmap .xmonad .zsh .zshenv .zshrc .git_template]
  end

  def absolute_path(file)
    File.join original_folder, file
  end

  def development_gems
    %w[gem-ctags pry hookup rbenv-rehash launchy better_errors binding_of_caller]
  end
end

DotfilesInstaller.new.install
