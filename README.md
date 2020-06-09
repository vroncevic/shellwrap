# Shell wrapper for Java Application.

***shellwrap*** is shell tool for creating Java Service Wrapper.

Developed in bash code: ***100%***.

The README is used to introduce the tool and provide instructions on
how to install the tool, any machine dependencies it may have and any
other information that should be provided before the tool is installed.

[![GitHub issues open](https://img.shields.io/github/issues/vroncevic/shellwrap.svg)](https://github.com/vroncevic/shellwrap/issues)
 [![GitHub contributors](https://img.shields.io/github/contributors/vroncevic/shellwrap.svg)](https://github.com/vroncevic/shellwrap/graphs/contributors)

<!-- START doctoc -->
**Table of Contents**

- [Installation](https://github.com/vroncevic/shellwrap#installation)
- [Usage](https://github.com/vroncevic/shellwrap#usage)
- [Dependencies](https://github.com/vroncevic/shellwrap#dependencies)
- [Shell tool structure](https://github.com/vroncevic/shellwrap#shell-tool-structure)
- [Docs](https://github.com/vroncevic/shellwrap#docs)
- [Copyright and Licence](https://github.com/vroncevic/shellwrap#copyright-and-licence)
<!-- END doctoc -->

### INSTALLATION

Navigate to release [page](https://github.com/vroncevic/shellwrap/releases) download and extract release archive.

To install modules type the following:

```
tar xvzf shellwrap-x.y.z.tar.gz
cd shellwrap-x.y.z
cp -R ~/sh_tool/bin/   /root/scripts/shellwrap/ver.1.0/
cp -R ~/sh_tool/conf/  /root/scripts/shellwrap/ver.1.0/
cp -R ~/sh_tool/log/   /root/scripts/shellwrap/ver.1.0/
```

![alt tag](https://raw.githubusercontent.com/vroncevic/shellwrap/dev/docs/setup_tree.png)

Or You can use docker to create image/container.

### USAGE

```
# Create symlink for shell tool
ln -s /root/scripts/shellwrap/ver.1.0/bin/shellwrap.sh /root/bin/shellwrap

# Setting PATH
export PATH=${PATH}:/root/bin/

# Creating wrapper script for Java Application
shellwrap MyApp.jar
```

### DEPENDENCIES

This tool requires these other modules and libraries:

* sh_util https://github.com/vroncevic/sh_util

### SHELL TOOL STRUCTURE

***shellwrap*** is based on MOP.

Shell tool structure:
```
.
├── bin/
│   ├── shellwrap.sh
│   └── of_operation.sh
├── conf/
│   ├── shellwrap.cfg
│   └── shellwrap_util.cfg
└── log/
    └── shellwrap.log
```

### DOCS

[![Documentation Status](https://readthedocs.org/projects/shellwrap/badge/?version=latest)](https://shellwrap.readthedocs.io/projects/shellwrap/en/latest/?badge=latest)

More documentation and info at:

* https://shellwrap.readthedocs.io/en/latest/

### COPYRIGHT AND LICENCE

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

Copyright (C) 2018 by https://vroncevic.github.io/shellwrap

This tool is free software; you can redistribute it and/or modify
it under the same terms as Bash itself, either Bash version 4.2.47 or,
at your option, any later version of Bash 4 you may have available.

