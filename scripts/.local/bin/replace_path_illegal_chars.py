#!/usr/bin/pypy3
# vim: ft=python
import sys

replace = {
    "\\": "⧹",
    "/":  "⧸",
    "|":  "￨",
    ":":  "꞉",
    "*":  "∗",
    "?":  "？",
    "\"": "″",
    "<":  "﹤",
    ">":  "﹥",
}

def do_replace(line):
    for k, v in replace.items():
        line = line.replace(k, v)
    return line

for line in sys.stdin:
    print(do_replace(line), end="")
