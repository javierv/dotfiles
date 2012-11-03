#!/usr/bin/env ruby

class DotfilesInstaller
  def install
    install_submodules
    create_symlinks
    copy_gitconfig
    create_local_configurations
    install_vim_plugins
    switch_to_zsh
  end

  def install_submodules
    puts "Installing submodules"
    %x[cd #{original_folder} && git submodule update --init &&
     cd #{original_folder}/.zprezto && git submodule update --init]
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
    %x[cp #{absolute_path('.gitconfig')} #{destination_folder}]
    puts "Copied gitconfig file"
  end

  def create_local_configurations
    %w[.vimrc.local .zshrc.local .aliases].each do |file|
      %x[touch #{destination_path(file)}]
      puts "Created #{file}"
    end
    # Make a different prompt, so I know it's a different machine.
    %x[echo "PROMPT='%n@%m:%~> '" >> .zshrc.local]
  end

  def install_vim_plugins
    puts "Installing vim plugins"
    %x[vim +BundleInstall +qall]
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
    Dir.entries(original_folder) - ignored_files
  end

  def ignored_files
    %w[. .. install.rb README.markdown .git .gitconfig .gitignore .gitmodules]
  end

  def absolute_path(file)
    File.join original_folder, file
  end
end

DotfilesInstaller.new.install
