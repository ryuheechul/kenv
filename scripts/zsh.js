// Menu: run command with zsh login shell alias & function
// Description: to run aliases and functions not only binaries
// Author: Heechul Ryu
import "@johnlindquist/kit";

// allowlist for command/alias/function
const commands = [
    "light",
    "dark",
]

const preview = async (name) => md(`${name}`);

const results = commands.map((name) => ({
    name,
    value: name,
    preview: async () => preview(name)
}))

let cmd = await arg("Select command:", results)

// `-l` is not enough to `source ~/.zshrc` automatically when it's used with `-c`
// learned that from, https://stackoverflow.com/a/37284456/1570165
await $`zsh -lc 'source ~/.zshrc; ${cmd}'`
