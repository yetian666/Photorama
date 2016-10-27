//
//  PhotoStore.h
//  Photorama
//
//  Created by Ye Tian on 27/10/2016.
//  Copyright © 2016 Ye Tian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface PhotoStore : NSObject

- (void) fetchInterestingPhotosWithCompletion: (void(^)(NSArray *)) completion;
- (void) fetchImageForPhoto: (Photo *) photo completion: (void(^)(UIImage *)) completion;

@end
