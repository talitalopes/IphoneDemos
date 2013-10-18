//
//  Category.h
//  4SquareTests
//
//  Created by Talita Gomes on 10/17/13.
//  Copyright (c) 2013 Talita Gomes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpecialCategory : NSObject

@property (nonatomic, strong) NSString *categoryId;
@property (nonatomic, strong) NSString *name;

- (id)initWithDictionary: (NSDictionary *)dic;

@end
