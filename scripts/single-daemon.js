// Menu: Single Daemon
// Description: Run command in background as singleton daemon
// Author: Heechul Ryu

import "@johnlindquist/kit";

// commands that I would like to run as a singleton daemons
const commands = [
    "base16-shell-auto-reload-on-tmux",
    // TODO: the naming and discovering the file can improve
    "~/.config/dfs-rhc/bin/darwin/base16-shell-to-follow-system-appearance.sh",
]

const preview = async (name) => md(`${name}`);

const results = commands.map((name) => ({
    name,
    value: name,
    preview: async () => preview(name)
}))

let cmd = await arg("Select command:", results)

// currently the dependancy is at https://github.com/ryuheechul/dotfiles/tree/master/bin/local
// maybe this repo should just merge to the dotfiles repo above at one point
await $`single-daemon ${cmd}`

// if the PATH ever gets a problem
// check by `cat ~/.kenv/.env`
// run `~/.kit/bin/kit sync-path` to let Script Kit to set the proper PATH
