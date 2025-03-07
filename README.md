# TyporaTrim

**TyporaTrim** is a PowerShell script that leverages [ImageMagick](https://imagemagick.org) to process images in two steps:

1. **Trim:** It first removes any extra whitespace around the image content using ImageMagick’s `-trim +repage` options.
2. **Add Border:** It then adds a border on all sides. By default, the border is 60px wide, but you can override this by providing a custom width using the `-BorderWidth` parameter.

Additionally, the script provides flexibility for the border colour:

- If you supply a border colour via the `-BorderColor` parameter, that colour is used.
- If not, the script extracts the top-left pixel’s colour from the input image and uses it as the border colour.

## Repository Contents

- **TyporaTrim.ps1**: The PowerShell script that trims the image, extracts a border colour if needed, and adds a border.
- **test.png**: A sample input image used for testing the script.
- **test_trimmed.png**: The output image generated from `test.png` after processing.

## Prerequisites

- **ImageMagick**: Ensure ImageMagick is installed and that the `magick` command is available in your system’s PATH. You can download it from [ImageMagick Downloads](https://imagemagick.org/script/download.php) or install using Scoop: `scoop install imagemagick`.
- **PowerShell**: The script is intended to run in PowerShell (compatible with PowerShell 5.1 and later).

## How to Use

1. Open a PowerShell prompt and navigate to the directory containing `TyporaTrim.ps1`.
2. Run the script with the following syntax:

   ```powershell
   .\TyporaTrim.ps1 -InputFile <path_to_image> [-BorderColor <hex_colour>] [-BorderWidth <width_in_pixels>]
   ```

If you don't specify `-BorderColor` then the top-left pixel colour will be used.

If you don't specify `-BorderWidth` then a width of 60px will be used.

## How to Use in Typora

1. In **Preferences** > **Export** select the existing Image export type or create a new custom Image export method.
2. In the **After Export** section, check **Run Command** and enter the following command:

   `pwsh.exe -noprofile [path to your script]\TyporaTrim.ps1 "${outputPath}"`

3. Check the **Show command output** option to show the output of the command. This is useful for checking the script has worked and can be turned off later.

### Examples

- **Using a specified border colour and custom border width:**

  ```powershell
  .\TyporaTrim.ps1 -InputFile "test.png" -BorderColor "#0d1117" -BorderWidth 80
  ```

- **Using the top-left pixel’s colour as the border colour with the default border width (60px):**

  ```powershell
  .\TyporaTrim.ps1 -InputFile "test.png"
  ```

  If no border colour is provided, the script extracts the top-left pixel’s colour using the following command:

  ```powershell
  magick input.png -format "%[hex:p{0,0}]" info:
  ```

  **Explanation of the command:**

  - **`-format "%[hex:p{...}]"`**: Tells ImageMagick to output the pixel colour in hexadecimal format.
  - **`%[hex:p{0,0}]`**: Retrieves the colour of the pixel at the coordinates:
    - **`0`** is the x-coordinate for the leftmost column.
    - **`0`** represents the y-coordinate for the top row.
  - The result is the hex colour of the top-left pixel, which is then prepended with a `#` and used as the border colour.

## Output

The processed image is saved in the same directory as the input file with `_trimmed` appended before the `.png` extension. For example, if the input file is `test.png`, the output will be `test_trimmed.png`.
