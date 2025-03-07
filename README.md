# TyporaTrim

**TyporaTrim** is a PowerShell script that leverages [ImageMagick](https://imagemagick.org) to process images in two steps:

1. **Trim:** It first removes any extra whitespace around the image content using ImageMagick’s `-trim +repage` options.
2. **Add Border:** It then adds a 60px border on all sides.

Additionally, the script provides flexibility for the border colour:

- If you supply a border colour via the `-BorderColor` parameter, that colour is used.
- If not, the script extracts the top-right pixel’s colour (using an fx expression) from the input image and uses it as the border colour.

## Repository Contents

- **TyporaTrim.ps1**: The PowerShell script that trims the image, extracts a border colour if needed, and adds a 60px border.
- **test.png**: A sample input image used for testing the script.
- **test_trimmed.png**: The output image generated from `test.png` after processing.

## Prerequisites

- **ImageMagick**: Ensure ImageMagick is installed and that the `magick` command is available in your system’s PATH. You can download it from [ImageMagick Downloads](https://imagemagick.org/script/download.php).
- **PowerShell**: The script is intended to run in PowerShell (compatible with PowerShell 5.1 and later).

## How to Use

1. Open a PowerShell prompt and navigate to the directory containing `TyporaTrim.ps1`.
2. Run the script with the following syntax:

   ```powershell
   .\TyporaTrim.ps1 -InputFile <path_to_image> [-BorderColor <hex_colour>]
   ```

## How to Use in Typora

1. In **Preferences** > **Export** select the existing Image export type or create a new custom Image export method
2. In the **After Export** section, check **Run Command** and enter the following command:

   `pwsh.exe -noprofile [path to your script]\TyporaTrim.ps1 "${outputPath}"`

3. Check the **Show command output** option to show the output of the command. This is useful for checking the script has worked and can be turned off later.

### Examples

- **Using a specified border colour:**

  ```powershell
  .\TyporaTrim.ps1 -InputFile "test.png" -BorderColor "#0d1117"
  ```

- **Using the top-right pixel’s colour as the border colour:**

  ```powershell
  .\TyporaTrim.ps1 -InputFile "test.png"
  ```

  If no border colour is provided, the script extracts the top-right pixel’s colour using the following fx expression:

  ```powershell
  magick input.png -format "%[hex:p{%[fx:w-1],0}]" info:
  ```

  **Explanation of the fx Expression:**

  - **`-format "%[hex:p{...}]"`**: Tells ImageMagick to output the pixel colour in hexadecimal format.
  - **`%[hex:p{%[fx:w-1],0}]`**: Retrieves the colour of the pixel at the coordinates determined by the expression:
    - **`%[fx:w-1]`** calculates the x-coordinate by subtracting 1 from the image width (`w`), giving the rightmost pixel's x-coordinate.
    - **`0`** represents the y-coordinate for the top row.
  - The result is the hex colour of the top-right pixel, which is then prepended with a `#` and used as the border colour.

## Output

The processed image is saved in the same directory as the input file with `_trimmed` appended before the `.png` extension. For example, if the input file is `test.png`, the output will be `test_trimmed.png`.
