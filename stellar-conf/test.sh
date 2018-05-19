#!/bin/bash

function main() {

echo "inside test.sh main:" $POSTGRES_PASSWORD
echo "variables:" $@

}

echo "test.sh"
main $@

sleep 10000
