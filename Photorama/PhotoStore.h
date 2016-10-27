//
//  PhotoStore.h
//  Photorama
//
//  Created by Ye Tian on 27/10/2016.
//  Copyright © 2016 Ye Tian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoStore : NSObject

- (void)fetchInterestingPhotosWithCompletion: (void(^)(NSArray *)) completion;

@end
