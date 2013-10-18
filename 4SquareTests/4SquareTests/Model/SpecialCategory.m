//
//  Category.m
//  4SquareTests
//
//  Created by Talita Gomes on 10/17/13.
//  Copyright (c) 2013 Talita Gomes. All rights reserved.
//

#import "SpecialCategory.h"

@implementation SpecialCategory

- (id)initWithDictionary: (NSDictionary *)dic {
    self = [super init];
    
    if (self) {
        self.categoryId = [dic valueForKey:@"id"];
        self.name = [dic valueForKey:@"name"];
    }
    
    return self;
}

@end
