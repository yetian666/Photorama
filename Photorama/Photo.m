//
//  Photo.m
//  Photorama
//
//  Created by Ye Tian on 27/10/2016.
//  Copyright © 2016 Ye Tian. All rights reserved.
//

#import "Photo.h"

@implementation Photo

#pragma mark - Initializers

- (instancetype)initWithTitle:(NSString *)title photoID:(NSString *)photoID remoteURL:(NSURL *)URL dateTaken:(NSDate *)dateTaken {
  self = [super init];
  if (self) {
    _title = [title copy];
    _photoID = [photoID copy];
    _remoteURL = URL;
    _dateTaken = dateTaken;
  }
  return self;
}

- (instancetype)init {
  return [self initWithTitle:nil photoID:nil remoteURL:nil dateTaken:nil];
}

#pragma mark - Description

- (NSString *)description {
  return [NSString stringWithFormat:@"< Photo id=\"%@\" title=\"%@\"> ",
          _photoID, _title];
}

@end
