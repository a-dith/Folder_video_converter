# Folder Video Converter

This is a Bash script that allows you to convert entire video files in the folder to the x265 format using FFmpeg. 
The script iterates over files in the current directory, identifies video files, and converts them to x265 format with minimal loss in quality.

## Prerequisites

To use this script, you need to have the following dependencies installed:

- FFmpeg: A multimedia framework that handles the audio and video processing.
- FFprobe: A tool that comes with FFmpeg and provides detailed information about media files.

Make sure you have FFmpeg and ffprobe installed on your system before running this script.

## Usage

1. Place the script in the directory containing the video files you want to convert.
2. Open a terminal and navigate to the directory where the script is located.
3. Run the following command to make the script executable:

   ```shell
   chmod +x script.sh
   ```
4. Execute the script by running the following command:

   ```shell
    ./script.sh
    ```
The script will start converting video files to the x265 format using FFmpeg. 
Once sucessfully converted, the converted files will be moved to the completed_files directory, while the source files will be moved to the source_files directory.

## File Organization

 *  source_files: This directory will contain the original video files after they have been converted sucessfully.
 *  completed_files: This directory will contain the successfully converted video files.

## Checking Output File

The script includes a function called check_output_file that checks if the output file already exists and has the same duration as the input file. 
If the output file exists and has the same duration, it is considered a successful conversion. 
In this case, the input and output files are moved to their respective directories.
If the output file exists and does't have the same duration, it is considered a un-successful conversion.
In that case, the `FFmpeg` command is run.
After running the `FFmpeg` command, the function check_output_file is called again.
Here the unsucessful conversion is ignored.

## Supported Video Formats
The script supports the following video formats for conversion:

*    mp4
*    avi
*    mkv
*    flv
*    mov
*    ts

Make sure your input files have one of these formats for successful conversion.

## Note
   * This script uses the x265 codec for video conversion and copies the audio stream without modification.
   * The script utilizes `FFmpeg` `-hide_banner` and `-loglevel panic` options to minimize console output.
   * the script calls `FFprobe` to print required console output.

## Disclaimer

Please note that video conversion can be a resource-intensive process, and the speed of conversion may vary depending on your system specifications and the size of the input files.
