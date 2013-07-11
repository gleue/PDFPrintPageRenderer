//
//  PDFPrintPageRenderer.h
//  PDFPrintPageRenderer
//
//  Created by Tim Gleue on 11.07.13.
//  Copyright (c) 2013 Tim Gleue • interactive software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDFPrintPageRenderer : UIPrintPageRenderer

// Paper margins in centimeters
@property (assign, nonatomic) UIEdgeInsets margins;

// Convert content to PDF w/ paper size A4 (21 x 29.7cm)
- (NSData *)printToPDF;

@end
