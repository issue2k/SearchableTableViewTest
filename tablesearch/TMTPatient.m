//
//  TMTPatient.m
//  tablesearch
//
//  Created by jakob on 27.05.15.
//  Copyright (c) 2015 eevol. All rights reserved.
//

#import "TMTPatient.h"

@implementation TMTPatient

@synthesize lastName, firstName;

- (NSUInteger)age {
    if(!self.birthdate) {
        return 0;
    }
    NSDate *now = [NSDate date];
    NSDateComponents *ageComponent = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self.birthdate toDate:now options:0];
    NSUInteger age = [ageComponent year];
    return age;
}

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", firstName, lastName];
}

@end
