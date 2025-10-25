/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

git config --global user.name "anujachaitanya"
git config --global user.email "anujachaitanya09@gmail.com"
git clone https://github.com/anujachaitanya/configurationFiles.git


echo "installing brew packages"
./configurationFiles/scripts/installTools.sh

echo "installing Apps"
./configurationFiles/scripts/installApps.sh

echo "setting up shell"
./configurationFiles/scripts/shellSetup.sh

# echo "setting up emacs"
# ./scripts/setupEmacs.sh

## ssh-keygen

