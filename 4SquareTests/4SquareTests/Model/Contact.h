//
//  Contact.h
//  4SquareTests
//
//  Created by Talita Gomes on 10/17/13.
//  Copyright (c) 2013 Talita Gomes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject

@property (nonatomic, strong) NSString *formattedPhone;
@property (nonatomic, strong) NSString *twitter;

- (id)initWithDictionary: (NSDictionary *)dic;

@end
