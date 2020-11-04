# shellcheck shell=bash disable=SC1090,SC1091

# Source login scripts to simulate running in an interactive login shell to
# configure environment variables as if the user had opened a shell. This
# script is intended for Xcode build phase scripts on macOS and does not have
# a shebang so it inherits the current shell.

current_shell=$(ps -cp "$$" -o comm="" | sed s/^-//)

if [[ "$current_shell" == zsh ]]; then
   # Zsh's setup script order is:
   #   /etc/zshenv
   #   ~/.zshenv
   #   /etc/zprofile
   #   ~/.zprofile
   #   /etc/zshrc
   #   ~/.zshrc
   #   /etc/zlogin
   #   ~/.zlogin
   # http://zsh.sourceforge.net/Guide/zshguide02.html

   if [ -f /etc/zshenv ]; then . /etc/zshenv; fi
   if [ -f ~/.zshenv ]; then . ~/.zshenv; fi
   if [ -f /etc/zprofile ]; then . /etc/zprofile; fi
   if [ -f ~/.zprofile ]; then . ~/.zprofile; fi
   if [ -f /etc/zshrc ]; then . /etc/zshrc; fi
   if [ -f ~/.zshrc ]; then . ~/.zshrc; fi
   if [ -f /etc/zlogin ]; then . /etc/zlogin; fi
   if [ -f ~/zlogin ]; then . ~/zlogin; fi
else
   # Bash's setup script order is:
   #   /etc/profile (if it exists)
   #   The first of: ~/.bash_profile, ~/.bash_login, and ~/.profile
   # https://www.gnu.org/software/bash/manual/html_node/Bash-Startup-Files.html

   if [ -f /etc/profile ]; then . /etc/profile; fi

   if [ -f ~/.bash_profile ]; then
      . ~/.bash_profile
   elif [ -f ~/.bash_login ]; then
      . ~/.bash_login
   elif [ -f ~/.profile ]; then
      . ~/.profile
   fi
fi

if [ -f ~/.nix-profile/etc/profile.d/nix.sh ]; then  . ~/.nix-profile/etc/profile.d/nix.sh; fi
