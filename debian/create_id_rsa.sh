#!/bin/bash

COMMENT=$1

ssh-keygen -t rsa -C $COMMENT
