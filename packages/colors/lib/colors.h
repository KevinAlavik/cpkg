#ifndef COLORS_H
#define COLORS_H

// Regular colors
#define red          "\x1B[31m"
#define green        "\x1B[32m"
#define yellow       "\x1B[33m"
#define blue         "\x1B[34m"
#define magenta      "\x1B[35m"
#define cyan         "\x1B[36m"
#define white        "\x1B[37m"

// Bold colors
#define bold_red     "\x1B[1m\x1B[31m"
#define bold_green   "\x1B[1m\x1B[32m"
#define bold_yellow  "\x1B[1m\x1B[33m"
#define bold_blue    "\x1B[1m\x1B[34m"
#define bold_magenta "\x1B[1m\x1B[35m"
#define bold_cyan    "\x1B[1m\x1B[36m"
#define bold_white   "\x1B[1m\x1B[37m"

// Background colors
#define bg_black     "\x1B[40m"
#define bg_red       "\x1B[41m"
#define bg_green     "\x1B[42m"
#define bg_yellow    "\x1B[43m"
#define bg_blue      "\x1B[44m"
#define bg_magenta   "\x1B[45m"
#define bg_cyan      "\x1B[46m"
#define bg_white     "\x1B[47m"

// Reset color
#define reset        "\x1B[0m"

#endif /* COLORS_H */