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
        
        [self.tableView reloadData];
        
        NSLog(@"loaded: %d", self.specialsCount);
        
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

#pragma ###################################################################################################################
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.specials count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"CellSpecial";
    
    Demo4SquareCell *cell = (Demo4SquareCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[Demo4SquareCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    // Bugfix on scrolling
    cell = (Demo4SquareCell *) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    FoursquareSpecial *special = [self.specials objectAtIndex:[indexPath row]];
    Demo4SquareCell *democell = (Demo4SquareCell *)cell;
    
    if ([indexPath row] % 2 == 1) {
        democell.backgroundColor = [UIColor whiteColor];
    }
    
    democell.name.text = special.title;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:NO];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    SpecialDetailsViewController *specialVC = [storyboard instantiateViewControllerWithIdentifier:@"SpecialDetailsViewController"];
    NSLog(@"%@", specialVC);
    
    specialVC.special = [self.specials objectAtIndex:[indexPath row]];
    [self.navigationController pushViewController:specialVC animated:YES];
}


@end
