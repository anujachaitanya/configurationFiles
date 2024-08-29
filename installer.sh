/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" ## brew install 
brew install alacritty tmux tree openjdk@17 colima docker docker-compose tig autojump go
brew install --cask visual-studio-code emacs 

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git config --global user.name "anujachaitanya"
git config --global user.email "anujachaitanya09@gmail.com"
git clone https://github.com/anujachaitanya/configurationFiles.git 

ln -s ./configurationFiles/vimrc .vimrc    
ln -s ./configurationFiles/zshrc .zshrc
ln -s ./configurationFiles/alacritty.toml .alacritty.toml
# ln -s ./configurationFiles/alacritty.yml .alacritty.yml     ## This is deprecated
ln -s ./configurationFiles/tmux.conf .tmux.conf     
cp ./configurationFiles/emacs/init.el ./.emacs.d/init.el

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git .zsh/powerlevel10k

## lsp-servers for emacs

# Go servers
#  go install golang.org/x/tools/cmd/godoc@latest
#  go install golang.org/x/tools/cmd/goimports@latest
#  go install golang.org/x/tools/gopls@latest

# typescript server
# npm install -g typescript-language-server typescript
source .zshrc

## ssh-keygen

