setup(){
  branch=`git rev-parse --abbrev-ref HEAD`
  git push --set-upstream origin $branch
}

prod(){
echo "fW'7rof;=$.-5]5" | pbcopy &&  ssh deployer@repairtechsolutions.com 
}

pw(){
echo "fW'7rof;=$.-5]5" | pbcopy
}

l(){
ls
}

showme() {
nautilus .
}

rt() {
cd ~/Documents/repairtechsolutions.com
}

commands(){
less ~/.bash_alias
}

c(){
clear
}

cls(){
clear && ls
}

e(){
exit
}


#added per suggestion to fix brew install of psql
export PATH=/usr/local/bin:$PATH
#source ~/.git-completion.bash

source ~/.profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
