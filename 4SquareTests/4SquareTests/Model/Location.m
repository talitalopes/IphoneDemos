//
//  Location.m
//  4SquareTests
//
//  Created by Talita Gomes on 10/17/13.
//  Copyright (c) 2013 Talita Gomes. All rights reserved.
//

#import "Location.h"

@implementation Location

- (id)initWithDictionary: (NSDictionary *)dic {
    self = [super init];
    
    if (self) {
        self.address = [dic valueForKey:@"address"];
        self.latitude = [[dic valueForKey:@"latitude"] doubleValue];
        self.longitude = [[dic valueForKey:@"longitude"] doubleValue];
        self.distance = [[dic valueForKey:@"distance"] doubleValue];
        self.city = [dic valueForKey:@"city"];
        self.state = [dic valueForKey:@"state"];
        self.country = [dic valueForKey:@"country"];
    }
    
    return self;
}

@end
