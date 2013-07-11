//
//  ViewController.m
//  HTML2PDFTest
//
//  Created by Tim Gleue on 11.07.13.
//  Copyright (c) 2013 Tim Gleue • interactive software. All rights reserved.
//

#import "ViewController.h"
#import "PDFPrintPageRenderer.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *convertButton;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {

    [super viewDidLoad];

    NSURL *url = nil;

    if (self.bundleResource) {
        
        // If document to load is located in
        // bundle, construct path from bundle
        // path
        //
        NSString *filename = [self.documentPath stringByDeletingPathExtension];
        NSString *extension = [self.documentPath pathExtension];
        NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:extension];

        url = [NSURL fileURLWithPath:path];
        
    } else {
        
        // Otherwise load document from
        // fully specified path
        //
        url = [NSURL fileURLWithPath:self.documentPath];
    }

    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    [self.webView loadRequest:request];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"ShowPDF"]) {
        
        ViewController *controller = segue.destinationViewController;
        
        // Tell destination ViewController to
        // use document path as is - see method
        // -viewDidLoad
        //
        controller.documentPath = sender;
        controller.bundleResource = NO;
    }
}

#pragma mark - WebView delegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    // Disable button while loading
    //
    self.convertButton.enabled = NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    // Reenable button when done
    //
    self.convertButton.enabled = YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error",  nil)
                                                    message:error.localizedDescription
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                          otherButtonTitles:nil];
    
    [alert show];
}

#pragma mark - Actions

- (IBAction)convertToPDF:(id)sender {
    
    // Use the UIWebView' formatter to
    // layout content during printing
    //
    PDFPrintPageRenderer *pdfRenderer = [[PDFPrintPageRenderer alloc] init];
    UIViewPrintFormatter *viewFormatter = [self.webView viewPrintFormatter];

    [pdfRenderer addPrintFormatter:viewFormatter startingAtPageAtIndex:0];
    [pdfRenderer setMargins:UIEdgeInsetsMake(1.0, 1.0, 1.0, 1.0)];
    
    // Print UIWebView's content to PDF
    // and save data to a file in app's
    // Documents folder
    //
    NSData *pdfData = [pdfRenderer printToPDF];
    NSArray *docURLs = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *url = docURLs[0];

    NSString *filename = [[self.documentPath stringByDeletingPathExtension] stringByAppendingPathExtension:@"pdf"];
    NSString *filepath = [url.path stringByAppendingPathComponent:filename];
    
    [pdfData writeToFile:filepath atomically:YES];

    // Display converted PDF in a new
    // ViewController instance
    //
    [self performSegueWithIdentifier:@"ShowPDF" sender:filepath];
}

@end
