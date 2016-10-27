//
//  ViewController.m
//  Photorama
//
//  Created by Ye Tian on 27/10/2016.
//  Copyright © 2016 Ye Tian. All rights reserved.
//

#import "PhotosViewController.h"

@interface PhotosViewController ()

@property (nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation PhotosViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [_photoStore fetchInterestingPhotosWithCompletion: ^(NSArray *photos) {
    NSLog(@"Found %lu photos", (unsigned long) photos.count);
    
    if (photos.count == 0) {
      NSLog(@"Zero photos! How SAD!");
      return;
    }
    
    [_photoStore fetchImageForPhoto: photos.firstObject completion: ^(UIImage *image) {
      [[NSOperationQueue mainQueue] addOperationWithBlock: ^ {
        _imageView.image = image;
      }];
    }];
  }];
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
