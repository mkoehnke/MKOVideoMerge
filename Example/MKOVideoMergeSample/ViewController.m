//
// ViewController.m
//
// Copyright (c) 2015 Mathias Koehnke (http://www.mathiaskoehnke.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "ViewController.h"
#import "MKOVideoMerge.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@end

@implementation ViewController

- (IBAction)mergeButtonTouched:(UIButton *)mergeButton {
    [self.activityIndicator setHidden:NO];
    [mergeButton setHidden:YES];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"mp4"];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    NSArray *fileURLs = @[fileURL, fileURL, fileURL];
    
    [MKOVideoMerge mergeVideoFiles:fileURLs completion:^(NSURL *mergedVideoFile, NSError *error) {
        void(^completionHandler)(void) = ^{
            [self.activityIndicator setHidden:YES];
            [mergeButton setHidden:NO];
        };
        
        if (error == nil) {
            AVPlayerViewController *vc = [[AVPlayerViewController alloc] init];
            vc.player = [AVPlayer playerWithURL:mergedVideoFile];
            [self presentViewController:vc animated:YES completion:^{
                completionHandler();
                [vc.player play];
            }];
        } else {
            NSString *errorMessage = [NSString stringWithFormat:@"Could not merge files: %@", [error localizedDescription]];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alert animated:YES completion:completionHandler];
        }
    }];
}

@end
