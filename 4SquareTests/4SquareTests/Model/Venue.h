//
//  Venue.h
//  4SquareTests
//
//  Created by Talita Gomes on 10/17/13.
//  Copyright (c) 2013 Talita Gomes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contact.h"
#import "Location.h"

@interface Venue : NSObject

@property (nonatomic, strong) NSString *venueId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) Contact *contact;
@property (nonatomic, strong) Location *location;

@end
