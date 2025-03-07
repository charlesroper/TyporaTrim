param (
	[Parameter(Mandatory = $true)]
	[string]$InputFile,

	[Parameter(Mandatory = $false)]
	[string]$BorderColor,

	[Parameter(Mandatory = $false)]
	[int]$BorderWidth = 60
)

# Check if the input file exists.
if (!(Test-Path $InputFile)) {
	Write-Error "Input file '$InputFile' does not exist."
	exit 1
}

# If no BorderColor provided, get the top-left pixel's colour.
if (-not $BorderColor) {
	Write-Host "No border color specified, using top-left pixel colour..."
	# The command:
	#   magick input.png -format "%[hex:p{0,0}]" info:
	#
	# breaks down as follows:
	#
	# 1. -format "%[hex:p{...}]" tells ImageMagick to output a value using a format string.
	#
	# 2. Inside the format string, %[hex:p{...}] means: "retrieve the colour
	#    value of the pixel at the position specified inside the curly braces, and convert it to a hexadecimal string."
	#
	# 3. The expression inside the curly braces is: {0,0}
	#
	#    - '0' is the x-coordinate for the leftmost column of the image.
	#    - '0' is the y-coordinate for the top row of the image.
	#
	#    Together, p{0,0} specifies the top-left pixel (since image coordinates start at (0,0) in the top-left).
	#
	# 4. Finally, info: outputs this information to the console.
	#
	# In summary, this command accesses the top-left pixel's colour, converts it into a hexadecimal string, and then prints it.
	$BorderColor = magick $InputFile -format "%[hex:p{0,0}]" info:
	$BorderColor = "#$BorderColor"
	Write-Host "Detected border color: $BorderColor"
}

# Get the directory and base file name.
$directory = Split-Path -Parent $InputFile
$baseName = [System.IO.Path]::GetFileNameWithoutExtension($InputFile)

# Construct the output filename by appending '_trimmed' before the extension.
$outputFile = Join-Path $directory ("{0}_trimmed.png" -f $baseName)

# Run ImageMagick to trim the image and add a 60px border with the specified border colour.
magick $InputFile -trim +repage -bordercolor $BorderColor -border $BorderWidth $outputFile

Write-Host "Added border size of: ${BorderWidth}px"
Write-Host "Output saved as: $outputFile"
