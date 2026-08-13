#!/bin/bash

SCRIPT_ROOT=$(realpath $(dirname "$0"))

TARGET=${1:-ALL}

check_target()
{
  case $TARGET in
    ALL)
      return 0
      ;;
    $1)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

# VS CODE configs
if check_target code
then
  echo "Linking VScode configs"
  VSCODE_CFG_DIR=~/.config/Code/User
  mkdir --parents "$VSCODE_CFG_DIR"
  rm -f $VSCODE_CFG_DIR/settings.json
  ln -s "$SCRIPT_ROOT/VSCode/settings.json" "$VSCODE_CFG_DIR/settings.json"

  rm -f ~/.config/Code/User/keybindings.json
  ln -s "$SCRIPT_ROOT/VSCode/keybindings.json" ~/.config/Code/User/keybindings.json
fi

# Helix configs
if check_target helix
then
  echo "Linking Helix configs"
  HELIX_CFG_DIR=~/.config/helix
  mkdir --parents $HELIX_CFG_DIR
  rm -f $HELIX_CFG_DIR/config.toml
  ln -s "$SCRIPT_ROOT/helix/config.toml" "$HELIX_CFG_DIR/config.toml"

  rm -f $HELIX_CFG_DIR/languages.toml
  ln -s "$SCRIPT_ROOT/helix/languages.toml" "$HELIX_CFG_DIR/languages.toml"

  HELIX_THEME_DIR=$HELIX_CFG_DIR/themes
  mkdir --parents $HELIX_THEME_DIR
  rm -f "$HELIX_THEME_DIR/alagyn.toml"
  ln -s "$SCRIPT_ROOT/helix/alagyn-theme.toml" "$HELIX_THEME_DIR/alagyn.toml"
fi

# ghostty configs
if check_target ghostty
then
  echo "Linking ghostty configs"
  GHOSTTY_CFG_DIR=~/.config/ghostty
  mkdir --parents $GHOSTTY_CFG_DIR
  rm -f $GHOSTTY_CFG_DIR/config.ghostty
  ln -s "$SCRIPT_ROOT"/config.ghostty $GHOSTTY_CFG_DIR/
fi

# lazygit configs
if check_target lazygit
then
  echo "Linking lazygit configs"
  LAZYGIT_CFG_DIR=~/.config/lazygit
  mkdir --parents $LAZYGIT_CFG_DIR
  rm -rf $LAZYGIT_CFG_DIR/config.yml
  ln -s "$SCRIPT_ROOT"/lazygit.config.yaml $LAZYGIT_CFG_DIR/config.yml
fi

# Nano
if check_target nano
then
  rm -f ~/.nanorc
  ln -s "$SCRIPT_ROOT"/.nanorc ~/
fi
