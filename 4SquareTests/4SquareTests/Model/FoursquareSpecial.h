//
//  FoursquareSpecial.h
//  4SquareTests
//
//  Created by Talita Gomes on 10/17/13.
//  Copyright (c) 2013 Talita Gomes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Venue.h"

@interface FoursquareSpecial : NSObject

@property (nonatomic, strong) NSString *specialId;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *provider;
@property (nonatomic, strong) NSString *redemption;
@property (nonatomic, strong) Venue *venue;

- (id)initWithDictionary: (NSDictionary *)dic;

@end
