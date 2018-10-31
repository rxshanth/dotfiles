#!/usr/bin/env bash
##################################################
# 
#
# @author Laurent Krishnathas
# @version 0.1
##################################################

#missing in new mac
export DISPLAY=:0


# Used in functions
export PROJECT_DIR="$HOME/code/src"
export GITHUB_DIR="$PROJECT_DIR/github.com"
export GITLAB_DIR="$PROJECT_DIR/gitlab"

export DOTFILES_DIR="$GITHUB_DIR/dotfiles.git"

export SHELL_SCRIPT_BASEDIR="$DOTFILES_DIR/bash"
export TMUXINATOR_CONFIG=".tmuxinator" #making project specfic and local
export ohmyzsh_file="$SHELL_SCRIPT_BASEDIR/oh-my-zsh.bash"

export HOWTO_DIR="$GITLAB_DIR/howto.git"
export ZSH="$GITHUB_DIR/oh-my-zsh.git" #Needed for oh-my-zsh

# Java
export JDK6=/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home
export JDK7=/Library/Java/JavaVirtualMachines/jdk1.7.0_80.jdk/Contents/Home
export JDK8=/Library/Java/JavaVirtualMachines/jdk1.8.0_162.jdk/Contents/Home
export JDK11=/Library/Java/JavaVirtualMachines/jdk-11.jdk/Contents/Home

export JAVA_HOME=$JDK11

# Python
export WORKON_HOME=$HOME/.virtualenvs

# Golang removed as not used for a while, go run script.go is working
# export GOROOT="$HOME/Projects/github/go.git"
# export GOROOT_BOOTSTRAP="$HOME/Applications/go1.4.2.darwin-amd64-osx10.8/"
# export GOPATH="$HOME/Projects/goworkspace"

export PACKER_HOME="$HOME/Applications/packer"


export NPM_PACKAGES="${HOME}/.npm-packages" #npm was not using this env so hardcoded everywhere to make it user local and project local
# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"



export PATH=$NPM_PACKAGES/node_modules/.bin:$PATH:~/bin:$GOROOT/bin:$GOPATH/bin:$MVN_HOME/bin:$ACTIVATOR_HOME:$PACKER_HOME:$HOME/Library/Python/2.7/bin:$HOME/Library/Python/3.7/bin

