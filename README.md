# Font Production Project Template (for UFO/Designspace)
Replace this Readme with info about your project!

Note: This is for a UFO3/Designspace project

## Commands
### Starting a local development environment
Open this project in your terminal and use the following 3 commands:

Use Python3 to start a new virtual environment:
```bash
python3 -m venv .venv
```

... Activate that environment:
```bash
source .venv/bin/activate
```

... Install the requirements of the project in the virtual environment:
```bash
pip install -r requirements.txt
```

... And finally, if any of the below build commands don't work, you might have left the virtual environment. You just need to re-activate it:
```bash
source .venv/bin/activate
```

### Adding an alias (optional)
It might be useful to make a handy "alias" for the top two commands, since you will by typing them all the time.

First, check which "shell" you are using; newer macs use `zsh`, older macs use `bash`. Run this command to check:
```bash
echo $SHELL
```
... if it says `/bin/zsh` then you're using `zsh`; if it says `/bin/bash`, then you're using `bash`.

Then, paste this command to alias the first two commands above to just `venv`. Replace `~/.zshrc` with `~/.bashrc` if you are using `bash`.
```bash
echo 'alias venv="python3 -m venv .venv && source .venv/bin/activate"' >> ~/.zshrc
```
... then restart the terminal.

From now on you only need to type `venv` to start a virtual environment, or activate one if it already exists.

### Building and testing fonts
To build OTFs, TTFs, Variable Fonts, and WOFFs from `.designspace` files in `A  Sources`, use the following command, or drag the file in to your Terminal:

```bash
./build.sh
```
... or you can generate things individually:
```bash
./build-otfs.sh
./build-ttfs.sh
./build-vfttfs.sh
./build-woffs.sh
./build-vfwoffs.sh
```

To use `fontbakery` to check the OTFs and TTFs in `B  Builds`, use either of these commands:
```bash
./build-test.sh
```

This will generate an HTML output in `D  Proofs`.

### Freezing the development environment
To “Freeze” all the dependencies in the python environment, run this command: 
```bash
pip freeze > requirements-freeze.txt
```
This make a new `requirements-freeze.txt` with the packages pip has installed and their exact version numbers. This will ensure that the next time you initialize your project and run `pip install -r requirements-freeze.txt`, all the dependencies will be exactly the same as they are now.

# License
Uses MIT license. Demo fonts are Mutator Sans, by Erik van Blokland, also licensed under MIT (or BSD?).