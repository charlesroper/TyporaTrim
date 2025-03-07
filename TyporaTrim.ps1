param (
	[Parameter(Mandatory = $true)]
	[string]$InputFile,

	[Parameter(Mandatory = $true)]
	[string]$BorderColor
)

# Check if the input file exists.
if (!(Test-Path $InputFile)) {
	Write-Error "Input file '$InputFile' does not exist."
	exit 1
}

# Get the directory and base file name.
$directory = Split-Path -Parent $InputFile
$baseName = [System.IO.Path]::GetFileNameWithoutExtension($InputFile)

# Construct the output filename by appending '_trimmed' before the extension.
$outputFile = Join-Path $directory ("{0}_trimmed.png" -f $baseName)

# Run ImageMagick to trim the image and add a 60px border with the specified border colour.
magick $InputFile -trim +repage -bordercolor $BorderColor -border 60 $outputFile

Write-Host "Output saved as: $outputFile"
