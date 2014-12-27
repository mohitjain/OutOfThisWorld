//
//  OWOuterSpaceTableViewController.m
//  Out of this world
//
//  Created by Mohit Jain on 30/08/14.
//  Copyright (c) 2014 CodeBeerStartups. All rights reserved.
//

#import "OWOuterSpaceTableViewController.h"
#import "AstronomicalData.h"
#import "OWSpaceObject.h"
#import "OWSpaceImageViewController.h"
#import "OWSpaceDataViewController.h"

@interface OWOuterSpaceTableViewController ()

@end

@implementation OWOuterSpaceTableViewController
#define ADDED_SPACE_OBJECTS_KEY @"Added Space Objects Array"

#pragma mark - Lazy Instantion of properties

-(NSMutableArray *) planets{
    
    if (!_planets) {
        _planets = [[NSMutableArray alloc] init];
    }
    return _planets;
}

-(NSMutableArray *) addSpaceObjects{
    
    if (!_addSpaceObjects) {
        _addSpaceObjects = [[NSMutableArray alloc] init];
    }
    return _addSpaceObjects;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    for (NSMutableDictionary *planetData in [AstronomicalData allKnownPlanets]) {
        NSString *imageName = [NSString stringWithFormat:@"%@.jpg", planetData[PLANET_NAME]];
        OWSpaceObject *planet = [[OWSpaceObject alloc] initWithData:planetData andImage:[UIImage imageNamed:imageName]];
        [self.planets addObject:planet];
    }
    
    NSArray *myPlanetAsPropertyList = [[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_SPACE_OBJECTS_KEY];
    
    for (NSDictionary *dictionary in myPlanetAsPropertyList) {
        OWSpaceObject *spaceObject = [self spaceObjectAsAPropertyList:dictionary];
        [self.addSpaceObjects addObject:spaceObject];
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([sender isKindOfClass:[UITableViewCell class]])
    {
        if ([segue.destinationViewController isKindOfClass:[OWSpaceImageViewController class]])
        {
            OWSpaceImageViewController *nextViewController = segue.destinationViewController;
            NSIndexPath *path = [self.tableView indexPathForCell:sender];
            OWSpaceObject *spaceObject = [self.planets objectAtIndex:path.row];
            nextViewController.spaceObject = spaceObject;
        }
    }
    
    if([sender isKindOfClass:[NSIndexPath class]])
    {
        if ([segue.destinationViewController isKindOfClass:[OWSpaceDataViewController class]])
        {
            OWSpaceDataViewController *targetViewController = segue.destinationViewController;
            NSIndexPath *path = sender;
            OWSpaceObject *spaceObject = [self.planets objectAtIndex:path.row];
            targetViewController.spaceObject = spaceObject;
        }
    }
    
    if([segue.destinationViewController isKindOfClass:[OWAddSpaceObjectViewController class]])
    {
        OWAddSpaceObjectViewController *addSpaceObjectVC = segue.destinationViewController;
        addSpaceObjectVC.delegate = self;
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - OWAddSpaceObjectViewController Delegate

-(void)didCancel
{
    NSLog(@"Did Cancel");
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)addSpaceObject:(OWSpaceObject *)spaceObject
{
    
    [self.addSpaceObjects addObject:spaceObject];
    [self.planets addObject:spaceObject];
    // Will save to NSUserDetaults
    NSMutableArray *spaceObjectsAsPropertiesList = [[[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_SPACE_OBJECTS_KEY] mutableCopy];
    
    if (!spaceObjectsAsPropertiesList) {
        spaceObjectsAsPropertiesList = [[NSMutableArray alloc] init];
    }
    
    [spaceObjectsAsPropertiesList addObject:[self spaceObjectAsAPropertyList:spaceObject]];
    [[NSUserDefaults standardUserDefaults] setObject:spaceObjectsAsPropertiesList forKey:ADDED_SPACE_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
}


#pragma mark - Helper Methods

-(NSDictionary *)spaceObjectAsAPropertyList:(OWSpaceObject *) spaceObject
{
    NSData *imageData = UIImagePNGRepresentation(spaceObject.spaceImage);
    NSDictionary *dictionary = @{
                                    PLANET_NAME: spaceObject.name,
                                    PLANET_GRAVITY: @(spaceObject.gravitianalForce),
                                    PLANET_DIAMETER: @(spaceObject.diameter),
                                    PLANET_YEAR_LENGTH: @(spaceObject.yearLength),
                                    PLANET_DAY_LENGTH: @(spaceObject.dayLength),
                                    PLANET_TEMPERATURE: @(spaceObject.temperature),
                                    PLANET_NUMBER_OF_MOONS: @(spaceObject.numberOfMoons),
                                    PLANET_NICKNAME: spaceObject.nickName,
                                    PLANET_INTERESTING_FACT: spaceObject.interestingFact,
                                    PLANET_IMAGE: imageData
                                 };
    return dictionary;
}


-(OWSpaceObject *)spaceObjectForDictionary:(NSDictionary *) dictionary
{
    OWSpaceObject *spaceObject = [[OWSpaceObject alloc] initWithData:dictionary andImage:[UIImage imageNamed:@"EinsteinRing.jpg"]];
    return spaceObject;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 1) {
        return self.addSpaceObjects.count;
    }
    else
    {
        return self.planets.count;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    if (indexPath.section == 1) {
        // add code for new added objects
        OWSpaceObject *planet = [self.addSpaceObjects objectAtIndex:indexPath.row];
        cell.textLabel.text = planet.name;
        cell.detailTextLabel.text = planet.nickName;
        cell.imageView.image = planet.spaceImage;
    }
    else
    {
        OWSpaceObject *planet = [self.planets objectAtIndex:indexPath.row];
        cell.textLabel.text = planet.name;
        cell.detailTextLabel.text = planet.nickName;
        cell.imageView.image = planet.spaceImage;
        
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor =[UIColor colorWithWhite:0.5 alpha:1.0];
    
    return cell;
}

#pragma mark - UI Table view delegate

-(void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"push to space data" sender:indexPath];
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

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
