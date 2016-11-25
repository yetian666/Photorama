//
//  PhotoInfoViewController.m
//  Photorama
//
//  Created by Ye Tian on 28/10/2016.
//  Copyright © 2016 Ye Tian. All rights reserved.
//

#import "PhotoInfoViewController.h"
#import "Photo.h"
#import "PhotoStore.h"

@interface PhotoInfoViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation PhotoInfoViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [_photoStore fetchImageForPhoto: _photo completion: ^(UIImage *image) {
    [[NSOperationQueue mainQueue] addOperationWithBlock: ^ {
      _imageView.image = image;
    }];
  }];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void) setPhoto: (Photo *) photo {
  _photo = photo;
  self.navigationItem.title = photo.title;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
