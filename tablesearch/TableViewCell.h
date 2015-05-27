//
//  TableViewCell.h
//  tablesearch
//
//  Created by jakob on 27.05.15.
//  Copyright (c) 2015 eevol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMTPatient.h"

@interface TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *socialSecurityIdentifierLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthdateLabel;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;

@end
