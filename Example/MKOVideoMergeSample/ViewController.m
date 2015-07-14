//
//  ViewController.m
//  VideoMergeDemo
//
//  Created by Mathias Köhnke on 12/07/15.
//  Copyright (c) 2015 Mathias Koehnke. All rights reserved.
//

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
