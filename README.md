# PDFPrintPageRenderer

Converting HTML to multi-page PDF.

## Requirements

* iOS 4.2+
* ARC

## Usage

* Add `PDFPageRenderer.{h|m}` to your project
* Use a UIWebView to display HTML
* Create PDFPageRenderer and add UIWebView's viewPrintFormatter
* Optionally set renderer margins
* Call renderer's -printToPDF method to get an NSData containing the PDF
* Write NSData to file

See `-convertToPDF:` in `HTML2PDFTest\ViewController.m` for more details.

## License

Copyright (c) 2013 [Tim Gleue](http://www.gleue-interactive.com). Released under the MIT license.