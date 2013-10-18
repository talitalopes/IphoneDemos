//
//  FoursquareSpecial.m
//  4SquareTests
//
//  Created by Talita Gomes on 10/17/13.
//  Copyright (c) 2013 Talita Gomes. All rights reserved.
//

#import "FoursquareSpecial.h"

@implementation FoursquareSpecial

- (id)initWithDictionary: (NSDictionary *)dic {
    self = [super init];
    
    if (self) {
        self.specialId = [dic valueForKey:@"id"];
        self.type = [dic valueForKey:@"type"];
        self.message = [dic valueForKey:@"message"];
        self.description = [dic valueForKey:@"description"];
        self.title = [dic valueForKey:@"title"];
        self.provider = [dic valueForKey:@"provider"];
        self.redemption = [dic valueForKey:@"redemption"];
        self.venue = [[Venue alloc] initWithDictionary:[dic valueForKey:@"venue"]];
    }
    
    return self;
}

@end
