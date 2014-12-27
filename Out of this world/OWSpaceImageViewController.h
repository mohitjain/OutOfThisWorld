//
//  OWSpaceImageViewController.h
//  Out of this world
//
//  Created by Mohit Jain on 31/08/14.
//  Copyright (c) 2014 CodeBeerStartups. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWSpaceObject.h"


@interface OWSpaceImageViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) OWSpaceObject *spaceObject;

@end
