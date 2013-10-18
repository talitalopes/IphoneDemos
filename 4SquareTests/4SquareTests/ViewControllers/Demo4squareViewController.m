//
//  my_demos_4squareViewController.m
//  4SquareTests
//
//  Created by Talita Gomes on 10/17/13.
//  Copyright (c) 2013 Talita Gomes. All rights reserved.
//

#import "Demo4squareViewController.h"

@interface Demo4squareViewController ()

@end

@implementation Demo4squareViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.specials = [[NSMutableArray alloc] init];
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self loadSpecials];
    });
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadSpecials {
    NSString *dateString = [self dateForURL];
    
    NSString *url = [NSString stringWithFormat:K_FOURSQUARE_SEARCH_SPECIALS, K_FOURSQUARE_CLIENT_ID, K_FOURSQUARE_CLIENT_SECRET, dateString];

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *response = [[operation.responseObject valueForKey:@"response"] valueForKey:@"specials"];
        self.specialsCount = [[response valueForKey:@"count"] integerValue];
        
        NSArray *items = [response valueForKey:@"items"];
        for (NSDictionary *dic in items) {
            [self.specials addObject:[[FoursquareSpecial alloc] initWithDictionary:dic]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failed");
        
    }];
    
    [operation start];
}

- (NSString *)dateForURL {
    NSDate *date = [NSDate date];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"YYYYMMdd"];
    
    return [dateFormat stringFromDate:date];
}

@end
