//
//  OWAddSpaceObjectViewController.h
//  Out of this world
//
//  Created by Mohit Jain on 01/09/14.
//  Copyright (c) 2014 CodeBeerStartups. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWSpaceObject.h"

@protocol OWAddSpaceObjectViewControllerDelegate <NSObject>

@required

-(void) addSpaceObject:(OWSpaceObject *)spaceObject;
-(void) didCancel;

@end

@interface OWAddSpaceObjectViewController : UIViewController

@property (weak, nonatomic) id <OWAddSpaceObjectViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *nicknameTextField;
@property (strong, nonatomic) IBOutlet UITextField *diameterTextField;
@property (strong, nonatomic) IBOutlet UITextField *tempratureTextField;
@property (strong, nonatomic) IBOutlet UITextField *numberOfMoonsTextField;
@property (strong, nonatomic) IBOutlet UITextField *interestingFactTextField;
- (IBAction)addButtonPressed:(id)sender;
- (IBAction)cancelButtonPressed:(id)sender;


@end
