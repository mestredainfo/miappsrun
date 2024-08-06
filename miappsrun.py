#!/usr/bin/env python3

# Copyright (C) 2004-2024 Murilo Gomes Julio
# SPDX-License-Identifier: GPL-2.0-only

# Organização: Mestre da Info
# Site: https://www.mestredainfo.com.br

import sys
import os
import platform
from subprocess import Popen,PIPE

if (platform.system() == "Linux"):
	miAppsFile = "/opt/mestredainfo/miapps/miapps"
	miAppsPath = os.path.dirname(sys.executable)
else:
	miAppsFile = "C:\\\\mestredainfo\\\\miapps\\\\miapps.exe"
	miAppsPath = os.path.dirname(sys.executable)

if os.path.isfile(miAppsFile):
	if os.path.exists(miAppsPath):
		miappsProc = Popen([miAppsFile, os.path.dirname(sys.executable)])
	else:
		print("App not found!")
else:
	print("MIApps not found!")

sys.exit()
