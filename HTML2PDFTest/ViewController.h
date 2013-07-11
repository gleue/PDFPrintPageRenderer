//
//  ViewController.h
//  HTML2PDFTest
//
//  Created by Tim Gleue on 11.07.13.
//  Copyright (c) 2013 Tim Gleue • interactive software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIWebViewDelegate>

// Filename of data (HTML or PDF) to display in web view
@property (strong, nonatomic) NSString *documentPath;

// Flag indicating that -documentPath points to a resource in the app bundle
@property (assign, nonatomic) BOOL bundleResource;

@end
