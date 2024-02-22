#!/usr/bin/env bash

# auto-install preselected plugins from this repo.
# useful if you're modifying plugins for own use in a fork.

MY_PLUGINS_FILE="MY_PLUGINS.txt"

! test -f "$MY_PLUGINS_FILE" && {
	touch "$MY_PLUGINS_FILE"
	>&2 printf "add relative paths of plugins you want to enable to %s" "$MY_PLUGINS_FILE"
	exit 1
}

MY_PLUGINS="$(cat $MY_PLUGINS_FILE)"
XBAR_PLUGIN_DIR="$HOME/Library/Application Support/xbar/plugins"

mkdir -p "$XBAR_PLUGIN_DIR"

for plugin in $MY_PLUGINS; do
	plugin_name="$(basename "$plugin")"
	install_path="$XBAR_PLUGIN_DIR/$plugin_name"

	if test -f "$install_path" && ! test -L "$install_path"; then
		HAD_ERR=1
		>&2 printf "ERR: cannot overwrite non-symlink file: %s\n\n" "$install_path"
	else
		ln -s -f "$PWD/$plugin" "$install_path"
	fi
done

printf "$XBAR_PLUGIN_DIR\n"
ls -la "$XBAR_PLUGIN_DIR"

test -n "$HAD_ERR" && exit 1 || exit 0
