#!/usr/bin/env python3

"""
This script will count the number of words (only in the values) in a json file.
"""

import json
import sys

filepath = sys.argv[1] if len(sys.argv) > 1 else None

if not filepath:
    print("Please provide a filepath")
    sys.exit(1)

with open(filepath) as file:
    data = json.load(file)

    # Search for all the values in the json file recursively
    values = []

    def get_final_value(obj):
        for _key, value in obj.items():
            if isinstance(value, dict):
                get_final_value(value)
            elif isinstance(value, str):
                values.append(value.strip())

    get_final_value(data)

    # Concatenate all the values into a single string
    final_string = " ".join(values)

    # Split the string into a list of words
    words = final_string.split(" ")

    # Remove empty strings
    words = [word for word in words if word]

    # Print the number of words
    print("Word count:", len(words))

sys.exit(0)
