#!/usr/bin/env bash

set -e

expand-tilde () {
	echo -n "${1/#~/$HOME}"
}

# customize these vars by providing it on your own
my_kenv_name="${my_kenv_name:-my-kenv}"
my_kenv_clone_path="${my_kenv_clone_path:-~/.local/my-kenv}"
# to deal with ~ not being expanded for some command like gh - https://stackoverflow.com/a/15859195/1570165
my_kenv_clone_path="$(expand-tilde "${my_kenv_clone_path}")"

script_kit_should_be_installed_path="$(expand-tilde ~/.kenv)"
source_node_modules="${script_kit_should_be_installed_path}/node_modules"
link_destination="${script_kit_should_be_installed_path}/kenvs/${my_kenv_name}"

echo "Installation is starting with given values for variables"
echo "- script_kit_should_be_installed_path: ${script_kit_should_be_installed_path}"
echo "- my_kenv_name: ${my_kenv_name}"
echo "- my_kenv_clone_path: ${my_kenv_clone_path}"
echo "- source_node_modules: ${source_node_modules}"
echo "- link_destination: ${link_destination}"

# fail when there is no ~/.kenv - https://github.com/johnlindquist/kit/discussions/577#discussioncomment-1628815
if ! test -d "${script_kit_should_be_installed_path}"; then
	echo "Script Kit not found at \`${script_kit_should_be_installed_path}\`"
	echo 'Install Script Kit first - https://www.scriptkit.com/'
	exit 1
fi

set -x

if command -v  gh > /dev/null; then
	gh repo clone ryuheechul/kenv -- "${my_kenv_clone_path}"
else
	git clone https://github.com/ryuheechul/kenv "${my_kenv_clone_path}"
fi

ln -sf "${my_kenv_clone_path}" "${link_destination}"
# this is to workaround an issue like https://github.com/johnlindquist/kit/discussions/728
ln -sf "${source_node_modules}" "${link_destination}/node_modules"

set +x

echo "Installation seems successful! Check '${link_destination}' to verify"
