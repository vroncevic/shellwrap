# Shell wrapper for Java Application

**shellwrap** is shell tool for creating Java Service Wrapper.

Developed in **[bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell))** code: **100%**.

[![shellwrap shell checker](https://github.com/vroncevic/shellwrap/workflows/shellwrap%20shell%20checker/badge.svg)](https://github.com/vroncevic/shellwrap/actions?query=workflow%3A%22shellwrap+shell+checker%22)

The README is used to introduce the tool and provide instructions on
how to install the tool, any machine dependencies it may have and any
other information that should be provided before the tool is installed.

[![GitHub issues open](https://img.shields.io/github/issues/vroncevic/shellwrap.svg)](https://github.com/vroncevic/shellwrap/issues) [![GitHub contributors](https://img.shields.io/github/contributors/vroncevic/shellwrap.svg)](https://github.com/vroncevic/shellwrap/graphs/contributors)

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**

- [Installation](#installation)
- [Usage](#usage)
- [Dependencies](#dependencies)
- [Shell tool structure](#shell-tool-structure)
- [Docs](#docs)
- [Copyright and licence](#copyright-and-licence)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

### Installation

Navigate to release **[page](https://github.com/vroncevic/shellwrap/releases)** download and extract release archive.

To install **shellwrap** type the following:

```
tar xvzf shellwrap-x.y.z.tar.gz
cd shellwrap-x.y.z
cp -R ~/sh_tool/bin/   /root/scripts/shellwrap/ver.1.0/
cp -R ~/sh_tool/conf/  /root/scripts/shellwrap/ver.1.0/
cp -R ~/sh_tool/log/   /root/scripts/shellwrap/ver.1.0/
```

![alt tag](https://raw.githubusercontent.com/vroncevic/shellwrap/dev/docs/setup_tree.png)

Or You can use docker to create image/container.

[![shellwrap docker checker](https://github.com/vroncevic/shellwrap/workflows/shellwrap%20docker%20checker/badge.svg)](https://github.com/vroncevic/shellwrap/actions?query=workflow%3A%22shellwrap+docker+checker%22)

### Usage

```
# Create symlink for shell tool
ln -s /root/scripts/shellwrap/ver.1.0/bin/shellwrap.sh /root/bin/shellwrap

# Setting PATH
export PATH=${PATH}:/root/bin/

# Creating wrapper script for Java Application
shellwrap MyApp.jar
```

### Dependencies

**shellwrap** requires next modules and libraries:
* sh_util [https://github.com/vroncevic/sh_util](https://github.com/vroncevic/sh_util)

### Shell tool structure

**shellwrap** is based on MOP.

Code structure:
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

### Docs

[![Documentation Status](https://readthedocs.org/projects/shellwrap/badge/?version=latest)](https://shellwrap.readthedocs.io/projects/shellwrap/en/latest/?badge=latest)

More documentation and info at:
* [https://shellwrap.readthedocs.io/en/latest/](https://shellwrap.readthedocs.io/en/latest/)
* [https://www.gnu.org/software/bash/manual/](https://www.gnu.org/software/bash/manual/)

### Copyright and licence

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

Copyright (C) 2015 by [vroncevic.github.io/shellwrap](https://vroncevic.github.io/shellwrap)

**shellwrap** is free software; you can redistribute it and/or modify
it under the same terms as Bash itself, either Bash version 4.2.47 or,
at your option, any later version of Bash 4 you may have available.

Lets help and support FSF.

[![Free Software Foundation](https://raw.githubusercontent.com/vroncevic/shellwrap/dev/docs/fsf-logo_1.png)](https://my.fsf.org/)

[![Donate](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://my.fsf.org/donate/)
