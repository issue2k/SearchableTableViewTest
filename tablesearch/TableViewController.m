//
//  TableViewController.m
//  tablesearch
//
//  Created by jakob on 27.05.15.
//  Copyright (c) 2015 eevol. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "TMTPatient.h"

@interface TableViewController ()

@property (strong, nonatomic) NSMutableArray *data;
@property (strong,nonatomic) NSMutableArray *filteredData;
@property (strong, nonatomic) UISearchController *patientSearchController;

@end

@implementation TableViewController

@synthesize data;
@synthesize filteredData;
@synthesize patientSearchController;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadMockData];
    [self loadSearchBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Fill data source

- (void)loadMockData {
    data = [NSMutableArray array];
    
    // Configure birthdate formatter
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMdd"];
    
    TMTPatient *patient1 = [[TMTPatient alloc] init];
    [patient1 setLastName:@"Müller"];
    [patient1 setFirstName:@"Martin"];
    [patient1 setSocialSecurityIdentifier:@"5986454556452"];
    [patient1 setBirthdate:[dateFormat dateFromString:@"19821122"]];
    [data addObject:patient1];
    
    TMTPatient *patient2 = [[TMTPatient alloc] init];
    [patient2 setLastName:@"Kamarauskas"];
    [patient2 setFirstName:@"Tomas"];
    [patient2 setSocialSecurityIdentifier:@"1469282536565"];
    [patient2 setBirthdate:[dateFormat dateFromString:@"19771115"]];
    [data addObject:patient2];
    
    TMTPatient *patient3 = [[TMTPatient alloc] init];
    [patient3 setLastName:@"Drangmeister"];
    [patient3 setFirstName:@"Jakob"];
    [patient2 setSocialSecurityIdentifier:@"8625841578963"];
    [patient3 setBirthdate:[dateFormat dateFromString:@"19020115"]];
    [data addObject:patient3];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(patientSearchController.active) {
        return filteredData.count;
    }
    else {
        return data.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"TMTPatientCell";
    TableViewCell *cell = (TableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if(cell == nil) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    TMTPatient *patientObject = nil;
    if (patientSearchController.active) {
        patientObject = [filteredData objectAtIndex:indexPath.row];
    } else {
        patientObject = [data objectAtIndex:indexPath.row];
    }
    
    if(patientObject) {
        [[cell fullNameLabel] setText:[patientObject fullName]];
        [[cell ageLabel] setText:[NSString stringWithFormat:@"%@", @([patientObject age])]];
        [[cell birthdateLabel] setText:[[patientObject birthdate] description]];
        [[cell socialSecurityIdentifierLabel] setText:[patientObject socialSecurityIdentifier]];
    }
    
    return cell;
}

#pragma mark - Search bar delegates

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = searchController.searchBar.text;
    [self filterDataForSearchString:searchString];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.patientSearchController setActive:NO];
    [self.tableView reloadData];
}

#pragma mark - Search bar helpers

- (void)loadSearchBar {
    patientSearchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    patientSearchController.searchResultsUpdater = self;
    [patientSearchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = patientSearchController.searchBar;
    
    patientSearchController.searchBar.delegate = self;
    patientSearchController.dimsBackgroundDuringPresentation = NO;
    patientSearchController.hidesNavigationBarDuringPresentation = YES;
    
    self.definesPresentationContext = YES;
}

- (void)filterDataForSearchString:(NSString *)searchString {
    if(![searchString isEqualToString:@""]) {
        NSString *searchAttribute = @"fullName"; // Can be extended to filter multiple attributes (if they need)
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.%@ contains[c] %@", searchAttribute, searchString];
        filteredData = [NSMutableArray arrayWithArray:[data filteredArrayUsingPredicate:predicate]];
        [self.tableView reloadData];
    }
}

@end
