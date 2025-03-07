# TyporaTrim

**TyporaTrim** is a PowerShell script that uses [ImageMagick](https://imagemagick.org) to process images by first trimming any extra whitespace around the content and then adding a 60px border with a specified colour. This tool is particularly useful when you need to ensure that images have consistent margins.

## Repository Contents

- **TyporaTrim.ps1**: The main PowerShell script that trims an image and adds a border.
- **test.png**: A sample image used to test the script.
- **test_trimmed.png**: The output image generated from `test.png` after processing.

## Prerequisites

- **ImageMagick**: Ensure that ImageMagick is installed on your system and that the `magick` command is available in your PATH. You can download ImageMagick from [here](https://imagemagick.org/script/download.php).
- **PowerShell**: The script is designed to run in PowerShell (tested on PowerShell 5.1 and later).

## How to Use

1. Open a PowerShell prompt and navigate to the directory containing `TyporaTrim.ps1`.
2. Run the script using the following syntax:

   ```powershell
   .\TyporaTrim.ps1 -InputFile <path_to_image> -BorderColor <colour_code>
   ```
