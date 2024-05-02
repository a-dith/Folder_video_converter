#!/bin/bash

# Programe to convert video files to h265 and move sucessful files to the respective folder
# Clear the terminal screen
clear

# Get the current working directory
current_dir="$PWD"

# Create directories if they don't exist
mkdir -p "$current_dir/source_files"
mkdir -p "$current_dir/completed_files"

# Function to check if the output file already exists and has the same duration
check_output_file() {
    local input_file="$1"
    local output_file="$2"

    # Check if the output file already exists
    if [ -f "$output_file" ]; then
        # Get the duration of the input file
        input_duration=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$input_file")
        input_duration=$(printf "%.2f" "$input_duration")
        # Get the duration of the output file
        output_duration=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$output_file")
        output_duration=$(printf "%.2f" "$output_duration")
        # Compare the durations
        if [ "$input_duration" = "$output_duration" ]; then
            echo "Output file: '$output_file' "
            echo "already exists /or converted sucessfully. Moving files to respective folders."

            mv "$input_file" "source_files/"
            mv "$output_file" "completed_files/"
            return 0
        else
            return 1
        fi
    else
        return 1
    fi
}

# Iterate over files in the current directory
for f in "$current_dir"/*.*; do
    # Check if the file is not a directory and is a video file
    if [ ! -d "$f" ] && [[ "$f" =~ \.(mp4|avi|mkv|flv|mov|ts)$ ]]; then
        # Extract the file name and extension
        file_name=$(basename "$f")
        file_extension="${file_name##*.}"

        output_file="$current_dir/${file_name%.*} x265.mkv"

        # Check if the output file already exists and has the same duration
        if check_output_file "$f" "$output_file"; then
            continue
        else
            # Execute the ffmpeg command to overwrite or create the output file
            ffprobe -v error -show_entries format=filename,duration,size -of default=noprint_wrappers=1 -sexagesimal "$f"
            ffmpeg -hide_banner -loglevel panic -i "$f" -y -c:v libx265 -x265-params log-level=error -stats -c:a copy "$output_file"
            # Check if the output file already exists and has the same duration after ffmpeg conversion
            if check_output_file "$f" "$output_file"; then
                continue
            fi
        fi
    fi
done
