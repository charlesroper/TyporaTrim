# TyporaTrim

[![License:  MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![PowerShell](https://img.shields.io/badge/PowerShell-5.1+-blue.svg)](https://github.com/PowerShell/PowerShell)
[![ImageMagick](https://img.shields.io/badge/ImageMagick-Required-red.svg)](https://imagemagick.org)

**TyporaTrim** is a PowerShell script that leverages [ImageMagick](https://imagemagick.org) to process images by trimming whitespace and adding intelligent borders. Perfect for preparing screenshots and diagrams for documentation.

## Table of Contents

- [Features](#features)
- [Before & After](#before--after)
- [Installation](#installation)
- [Usage](#usage)
  - [Standalone Usage](#standalone-usage)
  - [Typora Integration](#typora-integration)
  - [Examples](#examples)
- [How It Works](#how-it-works)
- [Output](#output)
- [Contributing](#contributing)
- [License](#license)
- [Author](#author)

## Features

TyporaTrim processes images in two intelligent steps:

1. **Trim:** Removes extra whitespace around the image content using ImageMagick's `-trim +repage` options. 
2. **Add Border:** Adds a customizable border on all sides (default: 60px).

**Smart Border Coloring:**
- If you supply a border colour via the `-BorderColor` parameter, that colour is used. 
- If not, the script automatically extracts the top-left pixel's colour from the input image and uses it as the border colour. 

## Before & After

<table>
<tr>
<td><b>Before</b></td>
<td><b>After</b></td>
</tr>
<tr>
<td><img src="test.png" alt="Original image with whitespace" width="400"/></td>
<td><img src="test_trimmed.png" alt="Trimmed image with border" width="400"/></td>
</tr>
</table>

## Installation

### Prerequisites

- **ImageMagick**: Required for image processing
- **PowerShell**: Version 5.1 or later

### Steps

1. **Install ImageMagick**

   Choose one of the following methods:

   **Scoop:**
   ```powershell
   scoop install imagemagick
   ```

   **Winget:**
   ```powershell
   winget install ImageMagick.ImageMagick
   ```

   **Manual Download:**
   Download from [ImageMagick Downloads](https://imagemagick.org/script/download.php) and ensure `magick` is available in your system's PATH.
   
3. **Clone the repository**
   ```powershell
   git clone https://github.com/charlesroper/TyporaTrim.git
   cd TyporaTrim
   ```

4. **Verify ImageMagick installation**
   ```powershell
   magick -version
   ```

## Usage

### Standalone Usage

1. Open a PowerShell prompt and navigate to the directory containing `TyporaTrim.ps1`.
2. Run the script with the following syntax: 

   ```powershell
   .\TyporaTrim.ps1 -InputFile <path_to_image> [-BorderColor <hex_colour>] [-BorderWidth <width_in_pixels>]
   ```

**Parameters:**
- `-InputFile` (required): Path to the image you want to process
- `-BorderColor` (optional): Hex color code for the border (e.g., `"#0d1117"`)
- `-BorderWidth` (optional): Border width in pixels (default: 60)

> **Note:** If you don't specify `-BorderColor`, the top-left pixel colour will be automatically detected and used. 

### Typora Integration

Integrate TyporaTrim into your Typora export workflow:

1. In **Preferences** > **Export**, select the existing Image export type or create a new custom Image export method.
2. In the **After Export** section, check **Run Command** and enter the following command: 

   ```
   pwsh.exe -noprofile [path to your script]\TyporaTrim.ps1 "${outputPath}"
   ```

3. Check the **Show command output** option to view the command output.  This is useful for verification and can be disabled later.

### Examples

**Using a specified border colour and custom border width:**

```powershell
.\TyporaTrim.ps1 -InputFile "test.png" -BorderColor "#0d1117" -BorderWidth 80
```

**Using automatic color detection with default border width (60px):**

```powershell
.\TyporaTrim.ps1 -InputFile "test.png"
```

**Processing multiple images with a consistent border:**

```powershell
Get-ChildItem *.png | ForEach-Object { .\TyporaTrim.ps1 -InputFile $_.FullName -BorderColor "#ffffff" }
```

## How It Works

When no border colour is provided, the script extracts the top-left pixel's colour using: 

```powershell
magick input.png -format "%[hex:p{0,0}]" info:
```

**Explanation of the command:**

- **`-format "%[hex:p{...}]"`**: Tells ImageMagick to output the pixel colour in hexadecimal format.
- **`%[hex:p{0,0}]`**: Retrieves the colour of the pixel at coordinates (0,0):
  - First **`0`** is the x-coordinate (leftmost column)
  - Second **`0`** is the y-coordinate (top row)
- The result is the hex colour of the top-left pixel, which is then prepended with `#` and used as the border colour.

## Output

The processed image is saved in the same directory as the input file with `_trimmed` appended before the `.png` extension. 

**Example:**
- Input: `test.png`
- Output: `test_trimmed.png`

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.  For major changes, please open an issue first to discuss what you would like to change.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

**Charles Roper** - [@charlesroper](https://github.com/charlesroper)

---

**Topics:** `powershell` · `imagemagick` · `typora` · `image-processing` · `automation`
