//
//  SpecialDetailsViewController.m
//  4SquareTests
//
//  Created by Talita Gomes on 10/20/13.
//  Copyright (c) 2013 Talita Gomes. All rights reserved.
//

#import "SpecialDetailsViewController.h"

@interface SpecialDetailsViewController ()

@end

@implementation SpecialDetailsViewController

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
    
    self.descriptionLabel.text = self.special.description;
    self.addressLabel.text = [self.special address];
    self.navigationItem.title = self.special.title;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
