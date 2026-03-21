#!/bin/bash

# Create icons directory
mkdir -p icons

# Generate iOS icons
echo "Generating iOS icons..."
rsvg-convert -w 1024 -h 1024 app_icon.svg -o icons/ios_1024x1024.png

# Generate macOS icons with correct sizes
echo "Generating macOS icons..."
rsvg-convert -w 16 -h 16 app_icon.svg -o icons/mac_16x16.png
rsvg-convert -w 32 -h 32 app_icon.svg -o icons/mac_32x32.png
rsvg-convert -w 32 -h 32 app_icon.svg -o icons/mac_16x16@2x.png
rsvg-convert -w 128 -h 128 app_icon.svg -o icons/mac_128x128.png
rsvg-convert -w 256 -h 256 app_icon.svg -o icons/mac_256x256.png
rsvg-convert -w 512 -h 512 app_icon.svg -o icons/mac_512x512.png
rsvg-convert -w 1024 -h 1024 app_icon.svg -o icons/mac_512x512@2x.png

# Generate the missing 64x64 icon for 32x32@2x
rsvg-convert -w 64 -h 64 app_icon.svg -o icons/mac_32x32@2x.png

echo "All icons generated successfully!"
echo "iOS: 1024x1024"
echo "macOS: 16x16, 32x32, 16x16@2x, 32x32@2x, 128x128, 256x256, 512x512, 512x512@2x"
