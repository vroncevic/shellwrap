<img align="right" src="https://raw.githubusercontent.com/vroncevic/shellwrap/dev/docs/shellwrap_logo.png" width="25%">

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

![Debian Linux OS](https://raw.githubusercontent.com/vroncevic/shellwrap/dev/docs/debtux.png)

Navigate to release **[page](https://github.com/vroncevic/shellwrap/releases)** download and extract release archive.

To install **shellwrap** type the following

```
tar xvzf shellwrap-x.y.tar.gz
cd shellwrap-x.y
cp -R ~/sh_tool/bin/   /root/scripts/shellwrap/ver.x.y/
cp -R ~/sh_tool/conf/  /root/scripts/shellwrap/ver.x.y/
cp -R ~/sh_tool/log/   /root/scripts/shellwrap/ver.x.y/
```

Self generated setup script and execution
```
./shellwrap_setup.sh

[setup] installing App/Tool/Script shellwrap
	Wed 24 Nov 2021 08:20:09 PM CET
[setup] clean up App/Tool/Script structure
[setup] copy App/Tool/Script structure
[setup] remove github editor configuration files
[setup] set App/Tool/Script permission
[setup] create symbolic link of App/Tool/Script
[setup] done

/root/scripts/shellwrap/ver.2.0/
├── bin/
│   ├── center.sh
│   ├── display_logo.sh
│   └── shellwrap.sh
├── conf/
│   ├── shellwrap.cfg
│   ├── shellwrap.logo
│   ├── shellwrap_util.cfg
│   └── template/
│       └── shell.template
└── log/
    └── shellwrap.log

4 directories, 8 files
lrwxrwxrwx 1 root root 48 Nov 24 20:20 /root/bin/shellwrap -> /root/scripts/shellwrap/ver.2.0/bin/shellwrap.sh
```

Or You can use docker to create image/container.

[![shellwrap docker checker](https://github.com/vroncevic/shellwrap/workflows/shellwrap%20docker%20checker/badge.svg)](https://github.com/vroncevic/shellwrap/actions?query=workflow%3A%22shellwrap+docker+checker%22)

### Usage

```
# Create symlink for shell tool
ln -s /root/scripts/shellwrap/ver.x.y/bin/shellwrap.sh /root/bin/shellwrap

# Setting PATH
export PATH=${PATH}:/root/bin/

# Creating wrapper script for Java Application
shellwrap WoLAN.jar
                                                                                             
shellwrap ver.2.0
Wed 24 Nov 2021 09:02:08 PM CET

[check_root] Check permission for current session? [ok]
[check_root] Done

	                                             
	     _          _ _                          
	 ___| |__   ___| | |_      ___ __ __ _ _ __  
	/ __| '_ \ / _ \ | \ \ /\ / / '__/ _` | '_ \ 
	\__ \ | | |  __/ | |\ V  V /| | | (_| | |_) |
	|___/_| |_|\___|_|_| \_/\_/ |_|  \__,_| .__/ 
	                                      |_|    
	                                             
		Info   github.io/shellwrap ver.2.0 
		Issue  github.io/issue
		Author vroncevic.github.io

[shellwrap] Loading basic and util configuration!
100% [================================================]

[load_conf] Loading App/Tool/Script configuration!
[check_cfg] Checking configuration file [/root/scripts/shellwrap/ver.2.0/conf/shellwrap.cfg] [ok]
[check_cfg] Done

[load_conf] Done

[load_util_conf] Load module configuration!
[check_cfg] Checking configuration file [/root/scripts/shellwrap/ver.2.0/conf/shellwrap_util.cfg] [ok]
[check_cfg] Done

[load_util_conf] Done

[check_tool] Checking tool [/usr/bin/java]? [ok]
[check_tool] Done

[shellwrap] Generating App executable file [WoLAN.sh]
[shellwrap] Remove WoLAN.sh
[shellwrap] Set permission!
[shellwrap] Wrapping java application [WoLAN.jar]
[logging] Checking directory [/root/scripts/shellwrap/ver.2.0/log/]? [ok]
[logging] Write info log!
[logging] Done

[shellwrap] Done
```

### Dependencies

**shellwrap** requires next modules and libraries
* shellwrap [https://github.com/vroncevic/shellwrap](https://github.com/vroncevic/shellwrap)

### Shell tool structure

**shellwrap** is based on MOP.

Shell tool structure
```
sh_tool/
├── bin/
│   ├── center.sh
│   ├── display_logo.sh
│   └── shellwrap.sh
├── conf/
│   ├── shellwrap.cfg
│   ├── shellwrap.logo
│   ├── shellwrap_util.cfg
│   └── template/
│       └── shell.template
└── log/
    └── shellwrap.log
```

### Docs

[![Documentation Status](https://readthedocs.org/projects/shellwrap/badge/?version=latest)](https://shellwrap.readthedocs.io/projects/shellwrap/en/latest/?badge=latest)

More documentation and info at
* [https://shellwrap.readthedocs.io/en/latest/](https://shellwrap.readthedocs.io/en/latest/)
* [https://www.gnu.org/software/bash/manual/](https://www.gnu.org/software/bash/manual/)

### Copyright and licence

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

Copyright (C) 2016 by [vroncevic.github.io/shellwrap](https://vroncevic.github.io/shellwrap)

**shellwrap** is free software; you can redistribute it and/or modify
it under the same terms as Bash itself, either Bash version 4.2.47 or,
at your option, any later version of Bash 4 you may have available.

Lets help and support FSF.

[![Free Software Foundation](https://raw.githubusercontent.com/vroncevic/shellwrap/dev/docs/fsf-logo_1.png)](https://my.fsf.org/)

[![Donate](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://my.fsf.org/donate/)
