#include <stdio.h>
#include <stdlib.h>

#include "lib/web_request.h"

int main() {
    char *url = "https://puffer.is-a.dev/cpkg/source.json";
    char *response = get(url);

    if (response != NULL) {
        printf("Response:\n%s\n", response);
        free(response);
    } else {
        printf("Failed to fetch URL: %s\n", url);
    }

    return 0;
}
