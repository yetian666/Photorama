//
//  FlickrAPI.m
//  Photorama
//
//  Created by Ye Tian on 27/10/2016.
//  Copyright © 2016 Ye Tian. All rights reserved.
//

#import "FlickrAPI.h"

NSString * const APIKey = @"edf9466d9d47bb3073c9d90b12a72687";
NSString * const BaseURLString = @"https://api.flickr.com/services/rest";
NSString * const InterestingPhotosMethod = @"flickr.interestingness.getList";

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

@end
