#!/bin/bash

SCRIPT_ROOT=$(realpath $(dirname "$0"))

# VS CODE configs
echo "Linking VScode configs"
VSCODE_CFG_DIR=~/.config/Code/User
mkdir --parents "$VSCODE_CFG_DIR"
rm -f $VSCODE_CFG_DIR/settings.json
ln -s "$SCRIPT_ROOT/VSCode/settings.json" "$VSCODE_CFG_DIR/settings.json"

rm -f ~/.config/Code/User/keybindings.json
ln -s "$SCRIPT_ROOT/VSCode/keybindings.json" ~/.config/Code/User/keybindings.json

# Helix configs
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

# ghostty configs
echo "Linking ghostty configs"
GHOSTTY_CFG_DIR=~/.config/ghostty
mkdir --parents $GHOSTTY_CFG_DIR
rm -f $GHOSTTY_CFG_DIR/config.ghostty
ln -s "$SCRIPT_ROOT"/config.ghostty $GHOSTTY_CFG_DIR/
