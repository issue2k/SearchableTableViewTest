//
//  TMTPatient.h
//  tablesearch
//
//  Created by jakob on 27.05.15.
//  Copyright (c) 2015 eevol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMTPatient : NSObject

@property (strong, nonatomic) NSString *socialSecurityIdentifier;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSDate *birthdate;

- (NSString *)fullName;
- (NSUInteger)age;

@end
