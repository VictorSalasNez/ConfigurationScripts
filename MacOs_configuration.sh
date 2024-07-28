
usage(){
  echo "Usage: $0 [OPTIONS]"
  echo "Options:"
  echo " -h, --help          Display this help message"
  echo " -d, --development   install development tools"
  echo " -p, --personal      install non-development tools"
}

brew_installation(){
  which -s brew
  if [[ $? == 0 ]] ; then
    echo brew is already installed
    #brew update
  else
      echo installing Homebrew
    #/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
}

ohmyzsh_installation(){
  if [ -d ~/.oh-my-zsh ]; then
    echo oh-my-zsh is already installed
  else
    echo installing oh-my-zsh
    #sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi
}

echo $#
while [ $# -gt 0 ]; do
  case $1 in
    -h | --help)
      usage
      exit 0
      ;;
    -d | --development)
      echo Installing development tools
      ;;
    -p | --personal)
      echo Installing non-development tools
      ;;
    *)
      echo "Invalid option: $1" >&2
      usage
      exit 1
      ;;
  esac
  shift
done


#while read package
#do
#  echo brew install --cask $package
#done < brew_packages/cast_development.txt


# Install homebrew
  # Install development.txt packages
  # Install packages
  # Upgrade every package

# Install oh my zsh
  # Default terminal
  # add plugins (history dirhistory macos)
