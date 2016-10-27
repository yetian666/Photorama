//
//  Photo.h
//  Photorama
//
//  Created by Ye Tian on 27/10/2016.
//  Copyright © 2016 Ye Tian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject

@property(readonly, copy, nonatomic) NSString *title;
@property(readonly, nonatomic) NSURL *remoteURL;
@property(readonly, copy, nonatomic) NSString *photoID;
@property(readonly, nonatomic) NSDate *dateTaken;

- (instancetype)initWithTitle:(NSString *)title
                      photoID:(NSString *)photoID
                    remoteURL:(NSURL *)URL
                    dateTaken:(NSDate *)dateTaken NS_DESIGNATED_INITIALIZER;

@end
