//
//  Venue.m
//  4SquareTests
//
//  Created by Talita Gomes on 10/17/13.
//  Copyright (c) 2013 Talita Gomes. All rights reserved.
//

#import "Venue.h"

@implementation Venue

- (id)initWithDictionary: (NSDictionary *)dic {
    self = [super init];
    
    if (self) {
        self.venueId = [dic valueForKey:@"id"];
        self.name = [dic valueForKey:@"name"];
        self.contact = [[Contact alloc] initWithDictionary:[dic valueForKey:@"contact"]];
        self.location = [[Location alloc] initWithDictionary:[dic valueForKey:@"location"]];
    }
    
    return self;
}

@end
