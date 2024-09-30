/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" ## brew install 

echo "installing brew packages"
./scripts/installTools.sh

echo "installing Apps"
./scripts/installApps.sh

echo "setting up shell"
./scripts/shellSetup.sh

echo "setting up emacs"
./scripts/setupEmacs.sh

## ssh-keygen

