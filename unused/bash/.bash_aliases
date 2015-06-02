#git aliases
alias ga='git add'
alias gp='git push'
alias gpu='git pull --rebase'
alias gl='git log'
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gc='git commit'
alias gca='git commit -a'
alias gb='git branch'
alias gco='git checkout'
alias gf='git fetch'
alias gr='git rebase'
alias gcl='git clone'
alias g='git'

#making git stash faster to use
function gst() {
    if [ -z "$1" ]; then        
        git stash list
    elif [ "$1" == "a" ]; then
        git stash apply stash@{"$2"}
    elif [ "$1" == "c"  ]; then
        git stash 
    elif [ "$1" == "d" ]; then
        git stash drop stash@{"$2"}
    fi
}

#navigation
alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'
alias cdp='cd /home/shashank/projects/'
alias cdpp='cd /home/shashank/projects/personal/'
alias cdps='cd /home/shashank/projects/sdslabs/'

#quick conversion to pdf
alias pdf='libreoffice --headless --invisible --convert-to pdf'

#quick python server
alias static='python -m SimpleHTTPServer'

alias llama='ssh git@git.sdslabs.co.in llama'

#quick cpp compile
function cppc() {
    g++ $1 -o $1.o && ./$1.o
}

#quick ssh to lab servers
function labssh(){
    ssh deploy@192.168.208.$1
}

#symbolic link to /var/www
www() {
    dest="/var/www/$@"
    src=`pwd`
    sudo ln -s $src $dest
}
