//
//  OWSpaceObject.h
//  Out of this world
//
//  Created by Mohit Jain on 31/08/14.
//  Copyright (c) 2014 CodeBeerStartups. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OWSpaceObject : NSObject

@property (strong, nonatomic)NSString *name;
@property (nonatomic) float gravitianalForce;
@property (nonatomic) float diameter;
@property (nonatomic) float yearLength;
@property (nonatomic) float dayLength;
@property (nonatomic) float temperature;
@property (nonatomic) int numberOfMoons;
@property (strong, nonatomic)NSString *nickName;
@property (strong, nonatomic)NSString *interestingFact;

@property (strong, nonatomic) UIImage *spaceImage;

-(id)initWithData: (NSDictionary *)data andImage:(UIImage *)image;

@end
