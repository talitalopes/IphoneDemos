//
//  Contact.m
//  4SquareTests
//
//  Created by Talita Gomes on 10/17/13.
//  Copyright (c) 2013 Talita Gomes. All rights reserved.
//

#import "Contact.h"

@implementation Contact

- (id)initWithDictionary: (NSDictionary *)dic {
    self = [super init];
    
    if (self) {
        self.formattedPhone = [dic valueForKey:@"formattedPhone"];
        self.twitter = [dic valueForKey:@"twitter"];
    }
    
    return self;
}

@end
