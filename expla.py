# We import the json module.
# "import" means we are bringing ready-made Python tools into our program.
# json is used to work with JSON data.
# In this program, we do not directly use json functions,
# but we keep it to clearly show that the file contains JSON records.
import json


# We import the os module.
# os helps Python talk to the operating system.
# It is used for working with folders and file paths.
import os


# We create a variable named input_file.
# A variable is like a named box that stores a value.
# This box stores TEXT (a file path).
# This path tells Python where the large JSON file is located on the computer.
input_file = "/Users/deepdata/Downloads/Yelp JSON/yelp_dataset/yelp_academic_dataset_review.json"


# We create a variable named output_prefix.
# This variable stores TEXT.
# This text will be used as the START of every output file name.
# Example:
# split_file_1.json
# split_file_2.json
# split_file_3.json
output_prefix = "split_file_"


# We create a variable named num_files.
# This variable stores a NUMBER.
# This number tells Python into how many smaller files
# the big JSON file should be divided.
num_files = 10


# We create a variable named output_dir.
# This variable stores the folder location where
# all the split files will be saved.
output_dir = "/Users/deepdata/Downloads/yelp_splits"


# We tell Python to create the folder stored in output_dir.
# os.makedirs() creates folders.
# exist_ok=True means:
# if the folder already exists, do NOT show an error.
os.makedirs(output_dir, exist_ok=True)


# We open the large JSON file in READ mode.
# "r" means read-only mode.
# encoding="utf8" allows reading special characters safely.
with open(input_file, "r", encoding="utf8") as f:

    # We count how many lines are in the file.
    # Each line contains ONE JSON object.
    # sum(1 for _ in f) means:
    # add 1 for every line found in the file.
    total_lines = sum(1 for _ in f)


# We calculate how many lines should go into EACH split file.
# // means division without decimal (whole number only).
lines_per_file = total_lines // num_files


# We print information on the screen.
# This helps us verify that the calculation is correct.
print(f"Total lines: {total_lines}, Lines per file: {lines_per_file}")


# We open the input file AGAIN.
# This is necessary because the file was fully read earlier
# while counting lines.
with open(input_file, "r", encoding="utf8") as f:

    # This loop runs num_files times.
    # Each loop creates ONE output split file.
    for i in range(num_files):

        # We create the full output file path.
        # os.path.join safely joins folder path and file name.
        # i+1 is used so file numbering starts from 1 instead of 0.
        output_filename = os.path.join(
            output_dir,
            f"{output_prefix}{i+1}.json"
        )

        # We open the output file in WRITE mode.
        # "w" means write mode (creates a new file).
        with open(output_filename, "w", encoding="utf8") as out_file:

            # This loop controls how many lines
            # will be written into the current split file.
            for j in range(lines_per_file):

                # We read ONE line from the input file.
                line = f.readline()

                # If no line is returned,
                # it means the input file has ended.
                if not line:
                    break

                # We write the line into the current output file.
                out_file.write(line)


# We print a final message to confirm that the task is completed.
print("✅ JSON file successfully split into smaller parts!")

