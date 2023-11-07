/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" ## brew install 
brew install alacritty tmux tree openjdk@17 colima docker docker-compose tig autojump
brew install --cask intellij-idea visual-studio-code 

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git config --global user.name "anujachaitanya"
git clone https://github.com/anujachaitanya/configurationFiles.git 

ln -s ./configurationFiles/vimrc .vimrc    
ln -s ./configurationFiles/zshrc .zshrc
ln -s ./configurationFiles/alacritty.yml .alacritty.yml     
ln -s ./configurationFiles/tmux.conf .tmux.conf     

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git .zsh/powerlevel10k

source .zshrc

## ssh-keygen 