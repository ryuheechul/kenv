// Menu: Nix Package Search
// Description: Search Nix for packages
// Author: Heechul Ryu

import "@johnlindquist/kit";

const baseUrl = "https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=";

const term = await arg("Package name:");

const url = `${baseUrl}${term}`;
await $`open ${url}`;
