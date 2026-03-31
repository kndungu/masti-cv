#!/bin/bash
set -e

# If a Yarn repo is present, ensure it uses a valid keyring; otherwise disable it.
if grep -Rqs "dl.yarnpkg.com/debian" /etc/apt/sources.list /etc/apt/sources.list.d 2>/dev/null; then
	if command -v curl >/dev/null 2>&1 && command -v gpg >/dev/null 2>&1; then
		sudo install -d -m 0755 /etc/apt/keyrings
		curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg \
			| gpg --dearmor \
			| sudo tee /etc/apt/keyrings/yarn-archive-keyring.gpg >/dev/null

		echo "deb [signed-by=/etc/apt/keyrings/yarn-archive-keyring.gpg] https://dl.yarnpkg.com/debian stable main" \
			| sudo tee /etc/apt/sources.list.d/yarn.list >/dev/null
	else
		if [ -f /etc/apt/sources.list.d/yarn.list ]; then
			sudo mv /etc/apt/sources.list.d/yarn.list /etc/apt/sources.list.d/yarn.list.disabled
		fi
	fi
fi

# Update package lists
sudo apt-get update

# This for sure works but it takes too long
# sudo apt-get install -y texlive-full luatex

# Install required packages
# texlive-full is ~5GB; these targeted packages cover everything awesome-cv.cls needs:
#   texlive-latex-base/recommended: article class, geometry, fancyhdr, xcolor, hyperref, parskip, graphicx, etc.
#   texlive-latex-extra:            enumitem, ragged2e, xifthen, tcolorbox, bookmark, etc.
#   texlive-fonts-extra:            fontawesome5, roboto, sourcesanspro, unicode-math
#   texlive-luatex:                 lualatex engine + fontspec support
sudo apt-get install -y \
  texlive-latex-base \
  texlive-latex-recommended \
  texlive-latex-extra \
  texlive-fonts-recommended \
  texlive-fonts-extra \
  texlive-luatex \
  latexmk
