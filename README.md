# DITA Bootstrap Lunr Search

<a href="https://www.dita-ot.org"><img src="https://www.dita-ot.org/images/dita-ot-logo.svg" align="right" height="55"></a>

_DITA Bootstrap Lunr Search_ is a [DITA Open Toolkit plug-in](https://www.dita-ot.org/plugins) that extends the [DITA Bootstrap](https://infotexture.github.io/dita-bootstrap/) HTML output with a [Lunr.js](https://lunrjs.com/) search function.

<!-- MarkdownTOC levels="2,3" -->

- [Installation](#installation)
  - [Installing DITA-OT](#installing-dita-ot)
  - [Installing the Plug-in](#installing-the-plug-in)
  - [Installing Node.js](#installing-nodejs)
- [Usage](#usage)
  - [Adding Lunr Search to HTML Bootstrap output](#adding-lunr-search-to-html-bootstrap-output)
  - [Adding Lunr Search to a GitHub Action](#adding-lunr-search-to-a-github-action)
  - [Parameter Reference](#parameter-reference)
- [License](#license)

<!-- /MarkdownTOC -->

## Installation

The _DITA Bootstrap Lunr Search_ plug-in has been tested with [DITA-OT 4.x](http://www.dita-ot.org/download). Use the latest version for best results.

### Installing DITA-OT

1.  Download the latest distribution package from the project website at
    [dita-ot.org/download](https://www.dita-ot.org/download).
2.  Extract the contents of the package to the directory where you want to install DITA-OT.
3.  **Optional**: Add the absolute path for the `bin` directory to the _PATH_ system variable.

    This defines the necessary environment variable to run the `dita` command from the command line.

See the [DITA-OT documentation](https://www.dita-ot.org/4.0/topics/installing-client.html) for detailed installation instructions.

### Installing the Plug-in

- Run the plug-in installation commands:

```console
dita install https://github.com/jason-fox/fox.jason.extend.css/archive/master.zip
dita install https://github.com/infotexture/dita-bootstrap/archive/master.zip
dita install https://github.com/infotexture/dita-bootstrap.lunr/archive/master.zip
```

### Installing Node.js

<a href="https://nodejs.org/"><img src="https://simpleicons.org/icons/nodedotjs.svg" align="right" width="70" height="70" align="right" width="55" height="55"></a>

The _DITA Bootstrap Lunr Search_ plug-in uses the [Node.js](https://nodejs.org/) JavaScript runtime to generate the Lunr.js search index. Node.js must therefore be present for the index to be generated successfully.

To download and install a copy, follow the instructions for your operating system on the [download page](https://nodejs.org/en/download/).

## Usage

### Adding Lunr Search to HTML Bootstrap output

To run, use the `html5-bootstrap` transformation and add the `args.hdr` parameter.

```console
PATH_TO_DITA_OT/bin/dita -f html5-bootstrap -o out -i PATH_TO_DITAMAP \
  --args.hdr=path/to/your-header.xml
```

A sample header file with a search box is provided with the plug-in: [includes/hdr.navbar.lunr.xml](./includes/hdr.navbar.lunr.xml) - the core markup can be seen below.

```xml
<li class="nav-item d-flex align-items-center">
  <span class="nav-link pe-2">
    <i class="bi bi-search"/>
  </span>
  <form class="search-box position-relative me-auto">
    <input type="search" class="form-control" placeholder="Search…" aria-label="Search for…" dir="auto"/>
  </form>
</li>
```

### Adding Lunr Search to a GitHub Action

You can use the standard [dita-ot-action](https://github.com/dita-ot/dita-ot-action) to run with Lunr Search. Since the transform requires Node.js to function, it is necessary to install it as part of the `install` process. Also, when creating documents in languages other than English, please ensure that the appropriate `locale` has been set prior to running the transform to ensure that the search index is generated correctly.

```yaml
name: Create DITA with Lunr Search (DE)
permissions:
  contents: write

'on':
  workflow_dispatch: null

jobs:
  build-dita:
    name: Build DITA
    runs-on: ubuntu-latest
    steps:
      - name: Git checkout
        uses: actions/checkout@v3
      - name: Build HTML5 + Bootstrap
        uses: dita-ot/dita-ot-action@4.0.2
        with:
          install: |
            apt-get update -q
            export DEBIAN_FRONTEND=noninteractive
            apt-get install -qy --no-install-recommends nodejs
            nodejs -v
            locale-gen de_DE.UTF-8
            LANG="de_DE.UTF-8"
            LANGUAGE="de_DE:de"
            LC_ALL="de_DE.UTF-8"
          plugins: |
            fox.jason.extend.css
            dita-bootstrap
            dita-bootstrap.lunr
          project: .github/dita-ot/html.xml
      - name: 'Deploy Documentation to GitHub Pages'
        uses: JamesIves/github-pages-deploy-action@v4.4.3
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
          branch: gh-pages
          folder: out
```

### Parameter Reference

- `offline.mode` - enables Lunr search to work in conjunction with DITA Bootstrap [offline mode](https://infotexture.github.io/dita-bootstrap/offline.html) - this requires an additional plugin to be installed.

## License

[Apache 2.0](LICENSE) © 2023-2026 Jason Fox

The Program includes the following additional software components which were obtained under license:

- lunr.js - https://github.com/olivernn/lunr.js - **MIT license**
- lunr-languages - https://github.com/MihaiValentin/lunr-languages - **Mozilla Public license**
