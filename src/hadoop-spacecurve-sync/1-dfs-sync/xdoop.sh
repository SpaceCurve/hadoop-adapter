#!/bin/bash

find control-dir -name "*.json" -print | xargs -I % -t bash -c 'cat % | ./mapper.py'
