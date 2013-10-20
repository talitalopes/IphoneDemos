//
//  my_demos_4squareViewController.h
//  4SquareTests
//
//  Created by Talita Gomes on 10/17/13.
//  Copyright (c) 2013 Talita Gomes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "Global.h"
#import "FoursquareSpecial.h"
#import "Demo4SquareCell.h"
#import "SpecialDetailsViewController.h"

@interface Demo4squareViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *specials;
@property (nonatomic) int specialsCount;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
