//
//  FlickrAPI.m
//  Photorama
//
//  Created by Ye Tian on 27/10/2016.
//  Copyright © 2016 Ye Tian. All rights reserved.
//

#import "FlickrAPI.h"
#import "Photo.h"

NSString * const APIKey = @"edf9466d9d47bb3073c9d90b12a72687";
NSString * const BaseURLString = @"https://api.flickr.com/services/rest";
NSString * const InterestingPhotosMethod = @"flickr.interestingness.getList";

@interface FlickrAPI ()

+ (Photo *) photoFromJSON: (NSDictionary *) jsonDict;

@end

@implementation FlickrAPI

+ (NSURL *)flickrURLForMethod:(NSString *)method parameters:(NSDictionary *)params {
  NSURLComponents *components = [NSURLComponents componentsWithString:BaseURLString];
  NSMutableArray *queryItems = [NSMutableArray array];
  
  NSMutableDictionary *allParams = [@{ @"method": method,
                                       @"format": @"json",
                                       @"nojsoncallback": @"1",
                                       @"api_key": APIKey } mutableCopy];
  [allParams addEntriesFromDictionary:params];
  
  for (NSString *queryKey in allParams.allKeys) {
    NSURLQueryItem *queryItem = [NSURLQueryItem queryItemWithName:queryKey value:allParams[queryKey]];
    [queryItems addObject:queryItem];
  }
  
  components.queryItems = queryItems;
  
  return components.URL;
}

+ (NSURL *)interestingPhotosURL {
  NSDictionary *parameters = @{@"extras": @"url_h,date_taken"};
  return [self flickrURLForMethod:InterestingPhotosMethod parameters:parameters];
}

+ (Photo *) photoFromJSON: (NSDictionary *) jsonDict {
  NSString *photoID = jsonDict[@"id"];
  NSString *title = jsonDict[@"title"];
  NSURL *URL = [NSURL URLWithString:jsonDict[@"url_h"]];
  NSDate *dateTaken = [[FlickrAPI dateFormatter] dateFromString:jsonDict[@"datetaken"]];
  
  if (!photoID || !title || !URL || !dateTaken) return nil;
  
  return [[Photo alloc] initWithTitle:title photoID:photoID remoteURL:URL dateTaken:dateTaken];
}

+ (NSArray *)photosFromJSONData:(NSData *)jsonData {
  
  NSMutableArray *photos = [NSMutableArray array];
  
  NSError *parseError = nil;
  NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&parseError];
  
  if (jsonObject != nil) {
    NSDictionary *jsonPhotosDict = jsonObject[@"photos"];
    NSArray *jsonPhotosArray = jsonPhotosDict[@"photo"];
    for (NSDictionary *jsonSinglePhotoDict in jsonPhotosArray) {
      Photo *photo = [FlickrAPI photoFromJSON: jsonSinglePhotoDict];
      if (photo) [photos addObject:photo];
    }
  }
  else NSLog(@"Failed to parse JSON data. Error: %@", parseError);
  
  return photos;
}

+ (NSDateFormatter *)dateFormatter {
  static NSDateFormatter *formatter = nil;
  
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
  });
  
  return formatter;
}

@end
