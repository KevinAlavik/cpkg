# cpkg
Package manager for C/C++

## Installing

Install via script:
```bash
bash -c "$(curl -fsSL https://puffer.is-a.dev/cpkg/install.sh)"
```
Install using [pot](https://github.com/kevinalavik/pot):
```shell
sudo pot install cpkg
```
or
```shell
sudo pot install cpkg@0.1.0
```
## Packages
- test-pkg
- test-pkg2
- colors
- web_request
- lazy

## Adding Packages
To add a package you will need to fork this repository. Then create an directory inside of the **packages/** directory, call the folder the name of your package. Inside of the package folder you need to add your header files (prefarable in an folder called like **lib/**, if you have documentation add that inside the main package directory. Then add a **cpkg-pack.json** file and the file should look something like this:

```json
{
    "headerDir": "lib/",
    "headerFiles": [
        "test.h"
    ]
}
```
Change the **headerDir** to the directory where the header files are located.

Then go into source.json and add this (change the values to match your package)

```json
{
    "packages": [
        {
            "name": "your-package",
            "source": "https://puffer.is-a.dev/cpkg/packages/your-package/cpkg-pack.json"
        }
    ]
}
```
Then commit the changes and create a pull request!
