//
//  MKOVideoMerge.h
//  VideoMergeDemo
//
//  Created by Mathias Köhnke on 12/07/15.
//  Copyright (c) 2015 Mathias Koehnke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKOVideoMerge : NSObject
+ (void)mergeVideoFiles:(NSArray *)fileURLs
             completion:(void(^)(NSURL *mergedVideoFile, NSError *error))completion;
@end
