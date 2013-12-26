//
//  DemoTableViewController.m
//  4SquareTests
//
//  Created by Talita Gomes on 10/30/13.
//  Copyright (c) 2013 Talita Gomes. All rights reserved.
//

#import "DemoTableViewController.h"

@interface DemoTableViewController ()

@end

@implementation DemoTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.specials = [[NSMutableArray alloc] init];
    
    [self startSignificantChangeUpdates];

    [self.refreshControl addTarget:self action:@selector(loadSpecials) forControlEvents:UIControlEventValueChanged];
    self.refreshControl.tintColor = [UIColor blueColor];

    /* UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"Carregando..."];     
    self.refreshControl = refreshControl;*/

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.refreshControl beginRefreshing];
    [self.tableView setContentOffset:CGPointMake(0, -self.refreshControl.frame.size.height - 50) animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadSpecials {
    NSString *dateString = [self dateForURL];
    
    NSString *latitude = [NSString stringWithFormat:@"%f", self.coords.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", self.coords.longitude];
    
    NSString *url = [NSString stringWithFormat:K_FOURSQUARE_SEARCH_SPECIALS, latitude, longitude, K_FOURSQUARE_CLIENT_ID, K_FOURSQUARE_CLIENT_SECRET, dateString];
    if (![CLLocationManager locationServicesEnabled]) {
        url = [NSString stringWithFormat:K_FOURSQUARE_SEARCH_SPECIALS_DEFAULT, K_FOURSQUARE_CLIENT_ID, K_FOURSQUARE_CLIENT_SECRET, dateString];
    }
    
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
        
        [self.refreshControl endRefreshing];
        
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
    democell.address.text = [special address];
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

- (void)startSignificantChangeUpdates
{
    if ([CLLocationManager locationServicesEnabled])
    {
        if (!self.locationManager)
            self.locationManager = [[CLLocationManager alloc] init];
        
        self.locationManager.delegate = self;
        [self.locationManager startMonitoringSignificantLocationChanges];
    } else {
        [self triggerLoadSpecials];
    }
}

- (void)stopSignificantChangesUpdates
{
    [self.locationManager stopUpdatingLocation];
    self.locationManager = nil;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = placemarks[0];
        NSDictionary *addressDictionary = [placemark addressDictionary];
        NSString *city = addressDictionary[(NSString *)kABPersonAddressCityKey];
        NSString *state = addressDictionary[(NSString *)kABPersonAddressStateKey];
        NSString *country = placemark.country;
        
        self.coords = placemark.location.coordinate;
        
        NSLog(@"%@", [NSString stringWithFormat:@"%@, %@, %@", city, state, country]);
        [self triggerLoadSpecials];
    }];
    
    [self stopSignificantChangesUpdates];
}

-(void)triggerLoadSpecials {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self loadSpecials];
    });
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
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
