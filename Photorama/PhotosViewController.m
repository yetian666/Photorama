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
  }];
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
