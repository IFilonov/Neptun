#!/bin/sh
echo "creating roles"
gosu postgres sh -c '/src/roles.sh'
