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

activate that environment:
```bash
source .venv/bin/activate
```

Install the requirements of the project in the virtual environment:
```bash
pip install -r requirements.txt
```

And finally, if any of the below build commands don't work, you might have left the virtual environment. You just need to re-activate it:
```bash
source .venv/bin/activate
```

### Building and testing fonts
To build OTFs, TTFs and WOFFs from `.designspace` files in `A  Font Sources`, use the following command, or drag the file in to your Terminal:
```bash
./static-build.sh
```

To use `fontbakery` to check the OTFs and TTFs in `B  Builds`, use either of these commands:
```bash
./static-checkOTFs.sh
./static-checkTTFs.sh
```
This will generate an HTML output in `D  Proofs`.

### Freezing the development environment
To “Freeze” all the dependencies in the python environment, run this command: 
```bash
pip freeze > requirements.txt
```
This will overwrite the `requirements.txt` with the packages pip has installed and their exact version numbers. This will ensure that the next time you need to run `pip install -r requirements.txt`, all the dependencies will be exactly the same.

# License
Uses MIT license. Demo fonts are Mutator Sans, by Erik van Blokland, also licensed under MIT (or BSD?).