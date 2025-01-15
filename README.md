<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**

- [Intellij Database Scripts](#intellij-database-scripts)
- [Folder `bin/`](#folder-bin)
  - [`start-au-container.bat`](#start-au-containerbat)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

This repository is about many my scripts for different purpose

# Intellij Database Scripts
Put the scripts to IntelliJ database data extesions, location:
`C:\Users\<username>\AppData\Roaming\JetBrains\IntelliJIdea2023.3\extensions\com.intellij.database\data\extractors`

# Folder `bin/`
Setup windows local PATH env variable so this bin folder is there.

## `start-au-container.bat`
If want to run it within IntelliJ, then setup following:
1. Go to File → Settings → Tools → External Tools
2. Click the + button to add a new tool
3. Fill in these fields:
  - Name: Start AU Container
  - Program: cmd
  - Arguments: /c start /min cmd /k "start-au-container -useCurrent"
  - Working directory: $ProjectFileDir$
