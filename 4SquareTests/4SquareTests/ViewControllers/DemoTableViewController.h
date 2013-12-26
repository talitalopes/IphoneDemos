//
//  DemoTableViewController.h
//  4SquareTests
//
//  Created by Talita Gomes on 10/30/13.
//  Copyright (c) 2013 Talita Gomes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>
#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "Global.h"
#import "FoursquareSpecial.h"
#import "Demo4SquareCell.h"
#import "SpecialDetailsViewController.h"

@interface DemoTableViewController : UITableViewController<CLLocationManagerDelegate>

@property (nonatomic, strong) NSMutableArray *specials;
@property (nonatomic) int specialsCount;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic) CLLocationCoordinate2D coords;

@end
