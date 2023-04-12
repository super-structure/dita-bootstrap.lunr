# dita-bootstrap.lunr

Lunr Search from DITA with a Bootstrap look-and-feel

[![license](https://img.shields.io/github/license/jason-fox/fox.jason.open-graph.svg)](http://www.apache.org/licenses/LICENSE-2.0)
[![DITA-OT 4.0](https://img.shields.io/badge/DITA--OT-4.0-blue.svg)](http://www.dita-ot.org/4.0)

This is a [DITA-OT Plug-in](https://www.dita-ot.org/plugins) adding a Lunr search function to the Bootstrap HTML.

![](https://jason-fox.github.io/fox.jason.open-graph/open-graph.png)

<details>
<summary><strong>Table of Contents</strong></summary>

-   [Install](#install)
    -   [Installing DITA-OT](#installing-dita-ot)
    -   [Installing the Plug-in](#installing-the-plug-in)
-   [Usage](#usage)
-   [License](#license)

</details>

## Install

The DITA-OT Lunr Search Plug-in  has been tested against [DITA-OT 4.x](http://www.dita-ot.org/download). It is recommended
that you upgrade to the latest version.

### Installing DITA-OT

<a href="https://www.dita-ot.org"><img src="https://www.dita-ot.org/images/dita-ot-logo.svg" align="right" height="55"></a>

The DITA-OT Lunr Search Plug-in  is a plugin for the DITA Open Toolkit.

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
dita install https://github.com/jason-fox/dita-bootstrap.lunr/archive/master.zip
```

The `dita` command line tool requires no additional configuration.

---


## Usage

#### Adding Lunr Search to HTML Bootstrap output

To run, use any `html5-bootstrap` transform and add the `lunr.search` parameter.

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