# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="gitster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git autojump brew)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Old SCM Breeze path removed (was /Users/sm/)
alias ls="ls -Gvh --color=auto"

[[ -s "$HOME/.rvm/scripts/rvm"  ]] && . "$HOME/.rvm/scripts/rvm"
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export PATH="$PATH:$HOME/Library/Android/sdk/tools"
export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"

export NVM_DIR="/Users/shashankmehta/.nvm"
# Lazy-load NVM to avoid ~300ms shell startup penalty
nvm() {
  unset -f nvm node npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  nvm "$@"
}
node() { unset -f nvm node npm npx; [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"; node "$@"; }
npm() { unset -f nvm node npm npx; [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"; npm "$@"; }
npx() { unset -f nvm node npm npx; [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"; npx "$@"; }

export ANDROID_HOME=$HOME/Library/Android/sdk


# source $HOME/.aliases.zsh

# all of our zsh files
typeset -U config_files
config_files=($HOME/.zsh/**/*)

# load the path files
for file in ${(M)config_files:#*/path.zsh}
do
  source $file
done

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/shashankmehta/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

# Added by Windsurf
export PATH="/Users/shashankmehta/.codeium/windsurf/bin:$PATH"

export PATH="$PATH:/Users/shashankmehta/.local/bin"
# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/shashankmehta/.lmstudio/bin"
# End of LM Studio CLI section

# pnpm
export PNPM_HOME="/Users/shashankmehta/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# bun completions
[ -s "/Users/shashankmehta/.bun/_bun" ] && source "/Users/shashankmehta/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Homebrew Ruby
export PATH="/opt/homebrew/opt/ruby/bin:/opt/homebrew/lib/ruby/gems/4.0.0/bin:$PATH"

# try - experiment directories
export TRY_PATH="$HOME/dev/trydir"
eval "$(ruby /opt/homebrew/lib/ruby/gems/4.0.0/gems/try-cli-1.7.1/try.rb init)"

# Disable SCM Breeze in Claude Code sessions (conflicts with shell snapshots)
if [[ -z "$CLAUDECODE" ]]; then
  [ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && source "$HOME/.scm_breeze/scm_breeze.sh"
fi
