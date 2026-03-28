#### Running on Codespaces

  * Run `bash scripts/install-packages.sh`.
  * Install the extension `LaTeX Workshop`.
  * Done, start editing. The PDF will be generated on save. You may need to run `Build LaTeX project` from the command palette (`Ctrl+Shift+P`) the first time.
  * When done editing, run `bash scripts/compress-pdf.sh` to reduce the PDF size.

#### Running on Mac

  * Install Homebrew: https://brew.sh/
  * Install MacTex: `brew cask install mactex-no-gui` - Over 4GB, will take a while.
  * Update some packages: `sudo tlmgr update --self && sudo tlmgr update --all`.
  * Open with VSCode.
  * Install the extension `LaTeX Workshop`.
  * Done, start editing. The PDF will be generated on save.
