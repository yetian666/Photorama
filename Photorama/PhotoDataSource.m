//
//  PhotoDataSource.m
//  Photorama
//
//  Created by Ye Tian on 27/10/2016.
//  Copyright © 2016 Ye Tian. All rights reserved.
//

#import "PhotoDataSource.h"

@implementation PhotoDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return _photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"UICollectionViewCell" forIndexPath: indexPath];
  
  return cell;
}

#pragma mark - Initializers
- (instancetype) initWithPhotos:(NSArray *)photos {
  self = [super init];
  if (self) {
    _photos = [photos copy];
  }
  return self;
}

- (instancetype) init {
  return [self initWithPhotos:nil];
}

@end
