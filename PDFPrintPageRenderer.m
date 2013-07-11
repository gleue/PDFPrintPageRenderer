//
//  PDFPrintPageRenderer.h
//  PDFPrintPageRenderer
//
//  Created by Tim Gleue on 11.07.13.
//  Copyright (c) 2013 Tim Gleue • interactive software. All rights reserved.
//

#import "PDFPrintPageRenderer.h"

/* Converts cm to points */
#define CM2PTS(a) ((a) * 0.393700787 * 72.0)

@implementation PDFPrintPageRenderer

/* Subtracts user specified margins in cm from -paperRect. */
- (CGRect)printableRect {
    
    CGRect rect = self.paperRect;
    
    rect.origin.x += CM2PTS(self.margins.left);
    rect.size.width -= CM2PTS(self.margins.left + self.margins.right);
    rect.origin.y += CM2PTS(self.margins.top);
    rect.size.height -= CM2PTS(self.margins.top + self.margins.bottom);

    return rect;
}

/* Returns paper size A4 (21 x 29.7cm) in points. */
- (CGRect)paperRect {
    
    return CGRectMake(0.0, 0.0, CM2PTS(21.0), CM2PTS(29.7));
}

/* Does the actual conversion to PDF */
- (NSData*)printToPDF {
    
    NSMutableData *pdfData = [NSMutableData data];
    
    UIGraphicsBeginPDFContextToData(pdfData, self.paperRect, nil);
    
    [self prepareForDrawingPages:NSMakeRange(0, self.numberOfPages)];
    
    CGRect bounds = UIGraphicsGetPDFContextBounds();

    for (NSInteger i = 0 ; i < self.numberOfPages; i++) {

        UIGraphicsBeginPDFPage();
        
        [self drawPageAtIndex:i inRect:bounds];
    }
    
    UIGraphicsEndPDFContext();
    
    return pdfData;
}

@end
