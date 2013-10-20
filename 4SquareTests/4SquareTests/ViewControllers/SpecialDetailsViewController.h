//
//  SpecialDetailsViewController.h
//  4SquareTests
//
//  Created by Talita Gomes on 10/20/13.
//  Copyright (c) 2013 Talita Gomes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoursquareSpecial.h"

@interface SpecialDetailsViewController : UIViewController

@property (nonatomic, strong) FoursquareSpecial *special;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end
