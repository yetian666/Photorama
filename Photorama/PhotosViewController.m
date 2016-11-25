//
//  ViewController.m
//  Photorama
//
//  Created by Ye Tian on 27/10/2016.
//  Copyright © 2016 Ye Tian. All rights reserved.
//

#import "PhotosViewController.h"
#import "PhotoDataSource.h"
#import "PhotoCollectionViewCell.h"
#import "PhotoInfoViewController.h"

@interface PhotosViewController () <UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) PhotoDataSource *photoDataSource;

@end

@implementation PhotosViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  _photoDataSource = [PhotoDataSource new];
  _collectionView.dataSource = _photoDataSource;
  _collectionView.delegate = self;
  
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

- (void) collectionView: (UICollectionView *)collectionView willDisplayCell: (UICollectionViewCell *)cell forItemAtIndexPath: (NSIndexPath *)indexPath {
  Photo *photo = _photoDataSource.photos[indexPath.row];
  [_photoStore fetchImageForPhoto: photo completion: ^(UIImage *image) {
    [[NSOperationQueue mainQueue] addOperationWithBlock: ^ {
      NSUInteger photoIndex = [_photoDataSource.photos indexOfObject: photo];
      NSIndexPath *photoIndexPath = [NSIndexPath indexPathForItem: photoIndex inSection: 0];
      
      PhotoCollectionViewCell *cell = (PhotoCollectionViewCell *) [_collectionView cellForItemAtIndexPath: photoIndexPath];
      [cell updateWithImage: image];
    }];
  }];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString: @"ShowPhoto"]) {
    NSIndexPath *selectedIndexPath = [_collectionView indexPathsForSelectedItems].firstObject;
    Photo *photo = _photoDataSource.photos[selectedIndexPath.row];
    
    PhotoInfoViewController *pivc = segue.destinationViewController;
    pivc.photoStore = _photoStore;
    pivc.photo = photo;
  }
}

@end
