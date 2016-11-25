//
//  PhotoInfoViewController.h
//  Photorama
//
//  Created by Ye Tian on 28/10/2016.
//  Copyright © 2016 Ye Tian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Photo;
@class PhotoStore;

@interface PhotoInfoViewController : UIViewController

@property (nonatomic) Photo *photo;
@property (nonatomic) PhotoStore *photoStore;

@end
