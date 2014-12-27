//
//  OWSpaceDataViewController.m
//  Out of this world
//
//  Created by Mohit Jain on 31/08/14.
//  Copyright (c) 2014 CodeBeerStartups. All rights reserved.
//

#import "OWSpaceDataViewController.h"

@interface OWSpaceDataViewController ()

@end

@implementation OWSpaceDataViewController

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
    self.view.backgroundColor = [UIColor blackColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"DataCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"NickName:";
            cell.detailTextLabel.text = self.spaceObject.nickName;
            break;
        case 1:
            cell.textLabel.text = @"Diameter:";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%f", self.spaceObject.diameter];
            break;
        case 2:
            cell.textLabel.text = @"Gravitional Force:";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%f", self.spaceObject.gravitianalForce];
            break;
        case 3:
            cell.textLabel.text = @"Length of the Year:";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%f", self.spaceObject.yearLength];
            break;
        case 4:
            cell.textLabel.text = @"Length of the day:";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%f", self.spaceObject.dayLength];
            break;
        case 5:
            cell.textLabel.text = @"Temprature:";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%f", self.spaceObject.temperature];
            break;
        case 6:
            cell.textLabel.text = @"Number of moons:";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%i", self.spaceObject.numberOfMoons];
            break;
        case 7:
            cell.textLabel.text = @"Interesting Fact:";
            cell.detailTextLabel.text = self.spaceObject.interestingFact;
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
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

@end
