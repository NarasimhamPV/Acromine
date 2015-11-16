//
//  ViewController.m
//  AcromineTest
//
//  Created by PV Narasimham Peetla on 11/12/15.
//  Copyright © 2015 PV Narasimham. All rights reserved.
//

#import "ViewController.h"
#import "AcromineAPIClient.h"
#import "MBProgressHUD.h"

@interface ViewController () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSString *searchString;
@property (nonatomic, strong) NSMutableArray *resultsDataArray;

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
- (IBAction)searchButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *resultsTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.resultsDataArray = [NSMutableArray array];
    
//    [self loadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Private API -
- (void)loadData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[AcromineAPIClient sharedClient] getAbbreviationDefinitionsForQuery:self.searchString success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (self.resultsDataArray) {
            [self.resultsDataArray removeAllObjects];
        }

        self.resultsDataArray = [[[responseObject objectAtIndex:0] objectForKey:@"lfs"] mutableCopy];
        
        [self.resultsTableView reloadData];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        
        NSLog(@"%s %@", __FUNCTION__, responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

- (IBAction)searchButtonAction:(id)sender {
    
    self.searchString = self.searchTextField.text;
    
    [self loadData];
}

#pragma mark - Delegates -

#pragma mark - UITextFieldDelegates
// called when 'return' key pressed. return NO to ignore.
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    self.searchString = textField.text;
    [textField resignFirstResponder];
    
    [self loadData];
    
    return NO;
    
}

#pragma mark - UITableViewDelegates

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.resultsDataArray count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [[self.resultsDataArray objectAtIndex:indexPath.row] objectForKey:@"lf"];
    
    return cell;

}

@end
