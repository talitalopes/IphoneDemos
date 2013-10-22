//
//  my_demos_4squareViewController.h
//  4SquareTests
//
//  Created by Talita Gomes on 10/17/13.
//  Copyright (c) 2013 Talita Gomes. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>
#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "Global.h"
#import "FoursquareSpecial.h"
#import "Demo4SquareCell.h"
#import "SpecialDetailsViewController.h"

@interface Demo4squareViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) NSMutableArray *specials;
@property (nonatomic) int specialsCount;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic) CLLocationCoordinate2D coords;
@end
