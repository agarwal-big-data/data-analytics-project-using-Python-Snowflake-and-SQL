# -------------------------------
# IMPORTS (inbuilt Python modules)
# -------------------------------

import json
# json is an inbuilt Python module used to work with JSON data.
# In this script, we are NOT directly using json functions,
# but we keep it for clarity to show the file contains JSON records.

import os
# os is an inbuilt Python module used for interacting with the Operating System.
# We use it here for:
# - creating directories
# - safely joining file paths


# -------------------------------
# USER-DEFINED VARIABLES
# -------------------------------

input_file = "/Users/deepdata/Downloads/Yelp JSON/yelp_dataset/yelp_academic_dataset_review.json"
# input_file is a variable created by us.
# It stores the absolute path of the large Yelp JSON file.
# IMPORTANT: This file contains ONE JSON object per line.

output_prefix = "split_file_"
# output_prefix is a user-defined variable.
# It will be used to name the output files like:
# split_file_1.json, split_file_2.json, etc.

num_files = 10
# num_files tells Python into how many parts
# we want to split the big JSON file.

output_dir = "/Users/deepdata/Downloads/yelp_splits"
# output_dir stores the directory path
# where all the smaller split files will be saved.


# -------------------------------
# DIRECTORY CREATION
# -------------------------------

os.makedirs(output_dir, exist_ok=True)
# os.makedirs() is an inbuilt function from the os module.
# It creates the directory if it does not exist.
# exist_ok=True means:
# - Do NOT throw an error if the folder already exists.


# -------------------------------
# COUNT TOTAL LINES IN FILE
# -------------------------------

with open(input_file, "r", encoding="utf8") as f:
    # open() is an inbuilt Python function to open a file.
    # "r" means read mode.
    # encoding="utf8" ensures proper reading of special characters.

    total_lines = sum(1 for _ in f)
    # sum() is an inbuilt function.
    # This line:
    # - loops over every line in the file
    # - counts how many lines exist
    # Each line = one JSON record

# At this point, Python has reached the end of the file.


lines_per_file = total_lines // num_files
# // is floor division.
# This calculates how many lines should go into EACH split file.
# Example:
# If total_lines = 1000 and num_files = 10
# lines_per_file = 100


print(f"Total lines: {total_lines}, Lines per file: {lines_per_file}")
# print() is an inbuilt function used to display output.
# f-string is used to insert variable values into text.


# -------------------------------
# SPLITTING THE FILE
# -------------------------------

with open(input_file, "r", encoding="utf8") as f:
    # We open the input file AGAIN because earlier
    # we already reached the end while counting lines.

    for i in range(num_files):
        # range() is an inbuilt function.
        # This loop runs num_files times.
        # i starts from 0 and goes to num_files - 1.

        output_filename = os.path.join(
            output_dir, f"{output_prefix}{i+1}.json"
        )
        # os.path.join() safely joins directory and filename.
        # i+1 is used so file numbering starts from 1, not 0.

        with open(output_filename, "w", encoding="utf8") as out_file:
            # Open a new output file in WRITE mode.

            for j in range(lines_per_file):
                # Inner loop controls how many lines
                # go into the current split file.

                line = f.readline()
                # readline() is an inbuilt file method.
                # It reads ONE line from the input file at a time.

                if not line:
                    # If line is empty, it means
                    # we reached the end of the input file.
                    break

                out_file.write(line)
                # write() writes the line into the output file.


# -------------------------------
# COMPLETION MESSAGE
# -------------------------------

print("✅ JSON file successfully split into smaller parts!")
# Final confirmation message once the process is complete.
