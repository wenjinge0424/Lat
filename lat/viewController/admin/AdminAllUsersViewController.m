//
//  AdminAllUsersViewController.m
//  lat
//
//  Created by Techsviewer on 6/18/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import "AdminAllUsersViewController.h"
#import "ProfileUserCell.h"
#import "AdminUserDetailViewController.h"

@interface AdminAllUsersViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    NSMutableArray * m_showData;
    NSMutableArray * m_allData;
}
@property (weak, nonatomic) IBOutlet UIButton *btn_allUsers;
@property (weak, nonatomic) IBOutlet UIButton *btn_banedUsers;
@property (weak, nonatomic) IBOutlet UITextField *edt_searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tbl_data;

@end

@implementation AdminAllUsersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edt_searchBar.delegate = self;
    [self.edt_searchBar addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.edt_searchBar setText:@""];
    [self setSelectButtonAt:0];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) fetchData
{
    m_allData = [NSMutableArray new];
    m_showData = [NSMutableArray new];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    PFQuery * query = [PFQuery queryWithClassName:PARSE_TABLE_FAMILY];
    [query whereKey:PARSE_FAMILY_ADMIN equalTo:[PFUser currentUser]];
    if(self.btn_allUsers.isSelected){
        [query whereKey:PARSE_FAMILY_ISBANNED notEqualTo:[NSNumber numberWithBool:YES]];
    }else{
        [query whereKey:PARSE_FAMILY_ISBANNED equalTo:[NSNumber numberWithBool:YES]];
    }
    [query findObjectsInBackgroundWithBlock:^(NSArray *arrays, NSError *errs){
        if (errs){
            [SVProgressHUD dismiss];
            [Util showAlertTitle:self title:@"Error" message:[errs localizedDescription]];
        }else{
            if(arrays.count == 0){/// is friend
                [SVProgressHUD dismiss];
                self.tbl_data.delegate = self;
                self.tbl_data.dataSource = self;
                [self.tbl_data reloadData];
            }else{
                for(PFObject * object in arrays){
                    [m_allData addObject:object];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    m_showData = [[NSMutableArray alloc] initWithArray:m_allData];
                    [SVProgressHUD dismiss];
                    self.tbl_data.delegate = self;
                    self.tbl_data.dataSource = self;
                    [self.tbl_data reloadData];
                });
            }
        }
    }];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void) setSelectButtonAt:(int)index
{
    if(index == 0){
        self.btn_allUsers.selected = YES;
        [self.btn_allUsers setBackgroundColor:[UIColor whiteColor]];
        self.btn_banedUsers.selected = NO;
        [self.btn_banedUsers setBackgroundColor:[UIColor colorWithRed:162/255.f green:159/255.f blue:126/255.f alpha:1.f]];
        [self fetchData];
        
    }else{
        self.btn_banedUsers.selected = YES;
        [self.btn_banedUsers setBackgroundColor:[UIColor whiteColor]];
        self.btn_allUsers.selected = NO;
        [self.btn_allUsers setBackgroundColor:[UIColor colorWithRed:162/255.f green:159/255.f blue:126/255.f alpha:1.f]];
        
        [self fetchData];
    }
}

- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)onAllusers:(id)sender {
    [self setSelectButtonAt:0];
}
- (IBAction)onBanedUsers:(id)sender {
    [self setSelectButtonAt:1];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [m_showData count];
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"ProfileUserAdminCell";
    ProfileUserCell *cell = (ProfileUserCell *)[tv dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell){
        PFObject * family = [m_showData objectAtIndex:indexPath.row];
        cell.lbl_userName.text = family[PARSE_FAMILY_NAME];
        cell.lbl_userType.text = @"User";
        cell.lbl_levelNum.text = [NSString stringWithFormat:@"%d", [family[PARSE_FAMILY_LEVEL] intValue]];
        PFFile * thumbFile = family[PARSE_FAMILY_AVATAR];
        [Util setImage:cell.img_thumb imgFile:thumbFile withDefaultImage:[UIImage imageNamed:@"img_emptyUser"]];
    }
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    PFObject * family = [m_showData objectAtIndex:indexPath.row];
    AdminUserDetailViewController * rootView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AdminUserDetailViewController"];
    rootView.family = family;
    [self.navigationController pushViewController:rootView animated:YES];
}

- (void) searchAction:(NSString*)searchKey
{
    m_showData = [NSMutableArray new];
    if(searchKey.length == 0){
        for(PFObject * object in m_allData){
            [m_showData addObject:object];
        }
    }else{
        for(PFObject * object in m_allData){
            NSString * name = object[PARSE_FAMILY_NAME];
            if([name rangeOfString:searchKey].location != NSNotFound){
                [m_showData addObject:object];
            }
        }
    }
    self.tbl_data.delegate = self;
    self.tbl_data.dataSource = self;
    [self.tbl_data reloadData];
}
#pragma mark - UItextfield delegate
- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self searchAction:textField.text];
    return YES;
}
- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString*  str = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [self searchAction:str];
    return YES;
}
- (void)textFieldChanged:(UITextField *)textField
{
    [self searchAction:textField.text];
}

- (IBAction)check_valid:(id)sender {
}
@end
