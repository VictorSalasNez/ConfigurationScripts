FailedBrewInstallation=()
FailedBrewCastInstallation=()

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
    echo "=============== installing Homebrew ==============="
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
}

ohmyzsh_installation(){
  if [ -d ~/.oh-my-zsh ]; then
    echo oh-my-zsh is already installed
  else
    echo "=============== Installing oh-my-zsh ==============="
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi
}

install_brew_cask_packages(){
  while read package
  do
    if brew install --cask "${package}" ; then
      echo " package ${package} successfully installed"
    else
      FailedBrewCastInstallation+=("${package}")
    fi
  done < "brew_packages/cask_${1}.txt"
}

install_brew_packages(){
  while read package
  do
    if brew install "${package}" ; then
      echo " package ${package} successfully installed"
    else
      FailedBrewInstallation+=("${package}")
    fi
  done < "brew_packages/${1}.txt"
}

homebrew_package_installation() {
  install_brew_cask_packages "${1}"
  install_brew_packages "${1}"
}

apppend_pluging_activation() {
  echo "========== activating plugins ============"
  echo 'eval $(thefuck --alias)' >>  ~/.zshrc
  echo "source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >>  ~/.zshrc
  echo "source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >>  ~/.zshrc
}

change_theme() {
  echo "========== add 2 last directories in terminal============"
  sed -i '' "s/%c%/%2~%/g" "${ZSH}/themes/robbyrussell.zsh-theme"
}

brew_installation
ohmyzsh_installation

# $# number of parameters
while [ $# -gt 0 ]; do
  case $1 in
    -h | --help)
      usage
      exit 0
      ;;
    -d | --development)
      echo Installing development tools -----------------
      homebrew_package_installation development
      ;;
    -p | --personal)
      echo Installing non-development tools -----------------
      homebrew_package_installation personal
      ;;
    *)
      echo "Invalid option: $1" >&2
      usage
      exit 1
      ;;
  esac
  shift
done

apppend_pluging_activation
change_theme

echo "=========== packages that fail ============"
echo "packages: ${FailedBrewInstallation[*]}"
echo "cast: ${FailedBrewCastInstallation[*]}"