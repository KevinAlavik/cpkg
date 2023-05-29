#ifndef WEB_REQUEST_H
#define WEB_REQUEST_H

#include <stdio.h>
#include <stdlib.h>
#include <curl/curl.h>

// Struct to store the response data
struct Response {
    char *data;
    size_t size;
};

// Callback function to write the response data
static size_t writeCallback(void *contents, size_t size, size_t nmemb, void *userp) {
    size_t realSize = size * nmemb;
    struct Response *response = (struct Response *)userp;

    response->data = realloc(response->data, response->size + realSize + 1);
    if (response->data == NULL) {
        printf("Failed to allocate memory for response data.\n");
        return 0;
    }

    memcpy(&(response->data[response->size]), contents, realSize);
    response->size += realSize;
    response->data[response->size] = '\0';

    return realSize;
}

// Function to fetch the content of a URL
char *fetch(const char *url) {
    CURL *curl;
    struct Response response = { .data = NULL, .size = 0 };

    curl = curl_easy_init();
    if (curl) {
        curl_easy_setopt(curl, CURLOPT_URL, url);
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, writeCallback);
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, (void *)&response);

        CURLcode res = curl_easy_perform(curl);
        if (res != CURLE_OK) {
            printf("Failed to fetch URL: %s\n", curl_easy_strerror(res));
        }

        curl_easy_cleanup(curl);
    }

    return response.data;
}

// Function to perform a GET request to a URL
char *get(const char *url) {
    return fetch(url);
}

// Function to perform a POST request to a URL
char *post(const char *url, const char *data) {
    CURL *curl;
    struct Response response = { .data = NULL, .size = 0 };

    curl = curl_easy_init();
    if (curl) {
        curl_easy_setopt(curl, CURLOPT_URL, url);
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, writeCallback);
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, (void *)&response);
        curl_easy_setopt(curl, CURLOPT_POSTFIELDS, data);

        CURLcode res = curl_easy_perform(curl);
        if (res != CURLE_OK) {
            printf("Failed to perform POST request: %s\n", curl_easy_strerror(res));
        }

        curl_easy_cleanup(curl);
    }

    return response.data;
}

#endif  // WEB_REQUEST_H
