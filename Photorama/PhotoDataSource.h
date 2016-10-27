//
//  PhotoDataSource.h
//  Photorama
//
//  Created by Ye Tian on 27/10/2016.
//  Copyright © 2016 Ye Tian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoDataSource : NSObject <UICollectionViewDataSource>

@property (copy, nonatomic) NSArray *photos;

- (instancetype) initWithPhotos: (NSArray *) photos NS_DESIGNATED_INITIALIZER;

@end
