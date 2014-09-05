//
//  OWAddSpaceObjectViewController.m
//  Out of this world
//
//  Created by Mohit Jain on 01/09/14.
//  Copyright (c) 2014 CodeBeerStartups. All rights reserved.
//

#import "OWAddSpaceObjectViewController.h"

@interface OWAddSpaceObjectViewController ()

@end

@implementation OWAddSpaceObjectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *orionImage = [UIImage imageNamed:@"Orion.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:orionImage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addButtonPressed:(id)sender {
    OWSpaceObject *spaceObject = self.returnNewSpaceObject;
    [self.delegate addSpaceObject:spaceObject];
    
}


- (OWSpaceObject *) returnNewSpaceObject
{
    OWSpaceObject *spaceObject = [[OWSpaceObject alloc] init];
    spaceObject.name = self.nameTextField.text;
    spaceObject.nickName = self.nicknameTextField.text;
    spaceObject.diameter = [self.diameterTextField.text floatValue];
    spaceObject.temperature = [self.tempratureTextField.text floatValue];
    spaceObject.numberOfMoons = [self.numberOfMoonsTextField.text intValue];
    spaceObject.interestingFact = self.interestingFactTextField.text;
    return spaceObject;
    
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self.delegate didCancel];
}

@end
