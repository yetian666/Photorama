//
//  PhotoStore.m
//  Photorama
//
//  Created by Ye Tian on 27/10/2016.
//  Copyright © 2016 Ye Tian. All rights reserved.
//

#import "PhotoStore.h"
#import "FlickrAPI.h"

@interface PhotoStore ()

@property (nonatomic) NSURLSession *session;

@end

@implementation PhotoStore

- (instancetype)init {
  self = [super init];
  if (self) {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    _session = [NSURLSession sessionWithConfiguration:config];
  }
  return self;
}

- (void)fetchInterestingPhotos {
  NSURL *url = [FlickrAPI interestingPhotosURL];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  NSURLSessionDataTask *task = [_session dataTaskWithRequest:request
                                           completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                             if (data == nil) NSLog(@"Failed to fetch data. Error: %@", error);
                                             else {
                                               NSString *jsonString = [[NSString alloc] initWithData:data
                                                                                            encoding:NSUTF8StringEncoding];
                                               NSLog(@"%@", jsonString);
                                             }
                                           }];
  
  [task resume];
}
@end
