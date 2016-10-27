//
//  ViewController.m
//  Photorama
//
//  Created by Ye Tian on 27/10/2016.
//  Copyright © 2016 Ye Tian. All rights reserved.
//

#import "PhotosViewController.h"
#import "PhotoDataSource.h"

@interface PhotosViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) PhotoDataSource *photoDataSource;

@end

@implementation PhotosViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  _photoDataSource = [PhotoDataSource new];
  _collectionView.dataSource = _photoDataSource;
  
  [_photoStore fetchInterestingPhotosWithCompletion: ^(NSArray *photos) {
    NSLog(@"Found %lu photos", (unsigned long) photos.count);
    
    if (photos.count == 0) {
      NSLog(@"Zero photos! How SAD!");
      return;
    }
    
    [_photoStore fetchImageForPhoto: photos.firstObject completion: ^(UIImage *image) {
      [[NSOperationQueue mainQueue] addOperationWithBlock: ^ {
        _photoDataSource.photos = photos;
        [_collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
      }];
    }];
  }];
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
