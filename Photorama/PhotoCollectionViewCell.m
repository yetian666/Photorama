//
//  PhotoCollectionViewCell.m
//  Photorama
//
//  Created by Ye Tian on 27/10/2016.
//  Copyright © 2016 Ye Tian. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell

- (void) updateWithImage: (UIImage *) image {
  if (image) [_spinner stopAnimating];
  else [_spinner startAnimating];
  
  _imageView.image = image;
}

- (void) awakeFromNib {
  [super awakeFromNib];
  [self updateWithImage:nil];
}

- (void) prepareForReuse {
  [super prepareForReuse];
  [self updateWithImage:nil];
}

@end
