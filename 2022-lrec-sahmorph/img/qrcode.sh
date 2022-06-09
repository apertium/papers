#qrencode -o qrcode.png -l M "https://github.com/jonorthwash/ultrasound-processing"

qrencode -o qrcode.svg -t SVG -l M "https://github.com/apertium/apertium-sah"
inkscape qrcode.svg --export-filename=qrcode.pdf


