#!/usr/bin/python
# -*- coding: utf-8 -*-
import requests

# Define the url and wordlist file path

url = 'http://192.168.59.69/'
wordlist_file = 'Lab1/web_directory_wordlist.txt'

# Define the file extensions to search for

file_extensions = ['.html', '.php', '.txt']

# Read the wordlist file into a list

with open(wordlist_file, 'r') as f:
    wordlist = [line.strip() for line in f]


# Function to check if a directory exists
found_directories = []
def check_directory(directory):
    response = requests.get(url + directory)
    if response.status_code == 200:
        found_directories.append(directory)
        return True
    else:
        return False






# Loop through each directory in the wordlist and check if it exists

for directory in wordlist:
    if check_directory(directory):
        print ('Directory found: ' + directory)

for word in wordlist:
    for extension in file_extensions:
        for directory in found_directories:
            file_url = url + directory + "/" + word + extension
            response = requests.get(file_url)
            if response.status_code == 200:
                print("File found: " + file_url)


        
