# Scripts
My scripts for different purpose

# Intellij Database Scripts
Put the scripts to IntelliJ database data extesions, location:
`C:\Users\<username>\AppData\Roaming\JetBrains\IntelliJIdea2023.3\extensions\com.intellij.database\data\extractors`

# Folder `bin/`
Setup windows local PATH env variable so this bin folder is there.

## start-au-container.bat
If want to run it within IntelliJ, then setup following:
1. Go to File → Settings → Tools → External Tools
2. Click the + button to add a new tool
3. Fill in these fields:
  - Name: Start AU Container
  - Program: cmd
  - Arguments: /c start /min cmd /k "start-au-container -useCurrent"
  - Working directory: $ProjectFileDir$
