#!/usr/bin/env bash

set -e
# fail when there is no ~/.kenv - https://github.com/johnlindquist/kit/discussions/577#discussioncomment-1628815
if ! test -d ~/.kenv; then
	echo 'Script Kit not found at `~/.kenv`'
	echo 'Install Script Kit first - https://www.scriptkit.com/'
	exit 1
fi

# customize these vars by providing it on your own
my_kenv_install_location="${my_kenv_install_location:-${HOME}/.local/my-kenv}"
my_kenv_name="${my_kenv_name:-my-kenv}"

echo "my_kenv_install_location: ${my_kenv_install_location}"
echo "my_kenv_name: ${my_kenv_name}"


if command -v  gh > /dev/null; then
	gh repo clone ryuheechul/kenv -- "${my_kenv_install_location}"
else
	git clone https://github.com/ryuheechul/kenv "${my_kenv_install_location}"
fi

link_destination="${HOME}/.kenv/kenvs/${my_kenv_name}"

ln -sf "${my_kenv_install_location}" "${link_destination}"
# this is to workaround an issue like https://github.com/johnlindquist/kit/discussions/728
ln -sf "${HOME}/.kenv/node_modules" "${link_destination}/node_modules"

echo "Installation seems successful! Check '${link_destination}' to verify"
