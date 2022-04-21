// Menu: Throw a window between screens
// Description: Either throw window or switch screen
// Author: Heechul Ryu

import "@johnlindquist/kit";

// derived from https://www.scriptkit.com/JamesHenry/automation-overload-example-of-running-macos-monterey-shortcuts-via-script-kit

// this makes external dependancies on shortcut side
// TODO: extract these scripts out of Shortcuts so it's less opaque and more likely work with multiple devices
const commands = [
    "am-to-screen1",
    "am-to-screen2",
    "am-to-left",
    "am-to-right",
    "mc-go-left",
    "mc-go-right",
]

const preview = async (name) => md(`${name}`);

const results = commands.map((name) => ({
    name,
    value: name,
    preview: async () => preview(name)
}))

let shortcut = await arg("Select command:", results)

// the location is hard coded
// TODO: establish better relationship with external source even though that's coming from mine.
await $`~/.local/bin/my-bin/darwin/shortcuts/async-run.sh ${shortcut}`
