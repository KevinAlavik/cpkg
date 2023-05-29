# Web Request Header for C

This header file provides basic functions for handling web requests in C, including `fetch()`, `get()`, and `post()`. It utilizes the `libcurl` library.

## Prerequisites

- `libcurl` library needs to be installed. You can install it using the following commands:

  - Ubuntu or Debian-based systems:
    ```shell
    sudo apt-get install libcurl4-openssl-dev
    ```

  - CentOS or Fedora-based systems:
    ```shell
    sudo yum install libcurl-devel
    ```

  - macOS with Homebrew:
    ```shell
    brew install curl
    ```

## Usage

1. Include the `web_request.h` header file in your C source file using `#include "web_request.h"`.

2. To compile your C file, use the following command, linking against `libcurl`:
   ```shell
   gcc main.c -o main -lcurl
Replace main.c with the name of your C source file.

After successful compilation, an executable file named main (or the specified output name) will be created in the same directory.

Execute the program by running the following command in the terminal:

```shell
./main
```
Adjust the command if you've provided a different output name during compilation.

The program will make web requests using the provided functions (fetch(), get(), and post()) and display the response data.

## Example
Here's an example code snippet that demonstrates how to use the get() function to fetch the content of a URL:

```c
#include <stdio.h>
#include <stdlib.h>

#include "web_request.h"

int main() {
    char *url = "https://example.com";
    char *response = get(url);

    if (response != NULL) {
        printf("Response:\n%s\n", response);
        free(response);
    } else {
        printf("Failed to fetch URL: %s\n", url);
    }

    return 0;
}
```
Make sure to adjust the URL and include any necessary error handling in your actual code.
