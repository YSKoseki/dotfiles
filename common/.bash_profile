# .bash_profile


# Customizing the prompt: プロンプトで表示する内容
export PS1="\n[\w]\n\$ "


# Customizing ls: ls出力結果の設定
export CLICOLOR=1
export TERM=xterm-256color
#export LSCOLORS=DxGxcxdxCxegedabagacad # May need in Terminal.app, not iTerm.app


# The command to change iTerm2 profiles
if [ "$(uname -m)" = "arm64" ]; then
  echo -ne "\033]1337;SetProfile=ARM\a"
else
  echo -ne "\033]1337;SetProfile=Intel\a"
fi


# Customizing colors for gls (GNU ls): gls (GNU版ls) の色設定
#eval `gdircolors ~/.dircolors-solarized/dircolors.256dark`


# Sourcing .bashrc: .bashrcを読み込む（.bashrcはターミナル起動時に自動で読み込まれないため）
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi


# Homebrew
if [ "$(uname -m)" = "arm64" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  export PATH="/opt/homebrew/bin:$PATH"
else
  eval "$(/usr/local/bin/brew shellenv)"
fi


# Coreutils: GNU lsなど
#if [ "$(uname -m)" = "arm64" ]; then
#  export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
#  export MANPATH="/opt/homebrew/opt/coreutils/libexec/gnuman:$MANPATH"
#else
#  export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
#  export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
#fi


# Conda (Miniforge)
if [ `uname -m` = "arm64" ]; then
  # >>> conda initialize >>>
  # !! Contents within this block are managed by 'conda init' !!
  __conda_setup="$('/opt/homebrew/Caskroom/miniforge/base/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
          . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh"
      else
          export PATH="/opt/homebrew/Caskroom/miniforge/base/bin:$PATH"
      fi
  fi
  unset __conda_setup
  # <<< conda initialize <<<
else
  # >>> conda initialize >>>
  # !! Contents within this block are managed by 'conda init' !!
  __conda_setup="$('/usr/local/Caskroom/miniforge/base/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "/usr/local/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
          . "/usr/local/Caskroom/miniforge/base/etc/profile.d/conda.sh"
      else
          export PATH="/usr/local/Caskroom/miniforge/base/bin:$PATH"
      fi
  fi
  unset __conda_setup
  # <<< conda initialize <<<
fi

