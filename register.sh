#!/bin/bash

for filename in commands/*; do 
    name=$(echo $filename | sed 's/.*\///' )
    gh alias set $name - < "./$filename"
done
