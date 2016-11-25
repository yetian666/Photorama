//
//  PhotoStore.m
//  Photorama
//
//  Created by Ye Tian on 27/10/2016.
//  Copyright © 2016 Ye Tian. All rights reserved.
//

#import "PhotoStore.h"
#import "FlickrAPI.h"
#import "Photo.h"

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

- (void)fetchInterestingPhotosWithCompletion: (void(^)(NSArray *)) completion {
  NSParameterAssert(completion);
  NSURL *url = [FlickrAPI interestingPhotosURL];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  NSURLSessionDataTask *task = [_session dataTaskWithRequest:request
                                           completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                             if (data == nil) NSLog(@"Failed to fetch data. Error: %@", error);
                                             else {
                                               NSArray *photos = [self processInterestingPhotosRequestWithData:data error:error];
                                               if (photos) NSLog(@"Data returned by Flickr parsed");
                                               else NSLog(@"Error parsing JSON data: %@", error);
                                               
                                               completion(photos);
                                             }
                                           }];
  
  [task resume];
}

- (void) fetchImageForPhoto: (Photo *) photo completion: (void(^)(UIImage *)) completion {
  NSParameterAssert(photo);
  NSParameterAssert(completion);
  
  if (photo.image != nil) {
    completion(photo.image);
    return;
  }
  
  NSURLRequest *request = [NSURLRequest requestWithURL: photo.remoteURL];
  NSURLSessionDataTask *task = [_session dataTaskWithRequest: request
                                           completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
                                             UIImage *image = [self processImageRequestWithData:data error:error];
                                             if (image) photo.image = image;
                                             completion(image);
                                           }];
  
  [task resume];
}

- (NSArray *) processInterestingPhotosRequestWithData: (NSData *) data error: (NSError *) error {
  if (data) return [FlickrAPI photosFromJSONData:data];
  else return nil;
}

- (UIImage *) processImageRequestWithData: (NSData *) data error: (NSError *) error {
  if (data == nil) return nil;
  return [UIImage imageWithData:data];
}

@end
