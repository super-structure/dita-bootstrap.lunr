# DITA-OT Bootstrap Lunr Search Box

This is [DITA-OT Plug-in](https://www.dita-ot.org/plugins) is an extension to the [DITA Bootstrap](https://infotexture.github.io/dita-bootstrap/) Plug-in adding a [Lunr.js](https://lunrjs.com/) search function to the Bootstrap HTML.

<!-- MarkdownTOC levels="2,3" -->

-   [Install](#install)
    -   [Installing DITA-OT](#installing-dita-ot)
    -   [Installing the Plug-in](#installing-the-plug-in)
-   [Usage](#usage)
-   [License](#license)

<!-- /MarkdownTOC -->

## Install

The DITA-OT Bootstrap Lunr Plug-in  has been tested against [DITA-OT 4.x](http://www.dita-ot.org/download). It is recommended
that you upgrade to the latest version.

### Installing DITA-OT

<a href="https://www.dita-ot.org"><img src="https://www.dita-ot.org/images/dita-ot-logo.svg" align="right" height="55"></a>

The DITA-OT Bootstrap Lunr Search Plug-in is a plugin for the DITA Open Toolkit.

-   Full installation instructions for downloading DITA-OT can be found
    [here](https://www.dita-ot.org/4.0/topics/installing-client.html).

    1.  Download the `dita-ot-4.0.zip` package from the project website at
        [dita-ot.org/download](https://www.dita-ot.org/download)
    2.  Extract the contents of the package to the directory where you want to install DITA-OT.
    3.  **Optional**: Add the absolute path for the `bin` directory to the _PATH_ system variable.

    This defines the necessary environment variable to run the `dita` command from the command line.

```console
curl -LO https://github.com/dita-ot/dita-ot/releases/download/4.0/dita-ot-4.0.zip
unzip -q dita-ot-4.0.zip
rm dita-ot-4.0.zip
```

### Installing the Plug-in

-   Run the plug-in installation commands:

```console
dita install https://github.com/jason-fox/fox.jason.extend.css/archive/master.zip
dita install https://github.com/infotexture/dita-bootstrap/archive/master.zip
dita install https://github.com/infotexture/dita-bootstrap.lunr/archive/master.zip
```


### Installing Node.js

<a href="https://nodejs.org/"><img src="https://nodejs.org/static/images/logos/nodejs-new-pantone-black.svg" align="right" width="70" height="70" align="right" width="55" height="55"></a>

Node.js is a JavaScript runtime built on Chrome's V8 JavaScript engine. The DITA-OT
Bootstrap Lunr Search plugin uses [Node.js](https://nodejs.org/) to generate the Lunr.js search
index. Node.js must therefore be present on a user's machine for the index to be generated
successfully.

To download a copy follow the instructions on the [Install Page](https://nodejs.org/en/download/).

```console
apt-get update -q
export DEBIAN_FRONTEND=noninteractive
apt-get install -qy --no-install-recommends nodejs
nodejs -v
```

---


## Usage

#### Adding Lunr Search to HTML Bootstrap output

To run, use the `html5-bootstrap` transform and add the `lunr.search` parameter.

```console
PATH_TO_DITA_OT/bin/dita -f html5-bootstrap -o out -i PATH_TO_DITAMAP \
  --lunr.search=WEBSITE_URL \
  --args.hdr=path/to/your-header.xml
```

A sample header file `bs-navbar-lunr.hdr.xml` including a search box can be found [here](./includes/bs-navbar-lunr.hdr.xml)

### Parameter Reference

-  `lunr.search` - Website URL for the search to occur on.

## License

[Apache 2.0](LICENSE) © 2022 Jason Fox

The Program includes the following additional software components which were obtained under license:

-  lunr.js - https://github.com/olivernn/lunr.js - **MIT license**
