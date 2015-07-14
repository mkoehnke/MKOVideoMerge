# MKOVideoMerge
This is a sample implementation for stitching multiple video files into a single file using AVFoundation. **Note:** According to Apple, placing multiple video segments on the same composition track can potentially lead to dropping frames at the transitions between video segments, especially on embedded devices. This class is an attempt to avoid this issue. 

**Take a look at the Example project to see how to use this it.**

# Usage
Just drag the MKOVideoMerge class into your project, import it and *AVFoundation* to your linked frameworks. Calling the following function, starts the merging process:
 
```objective-c
[MKOVideoMerge mergeVideoFiles:fileURLs completion:^(NSURL *mergedVideoFile, NSError *error) {
	//handle result	
}];
```
