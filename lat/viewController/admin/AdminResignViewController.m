//
//  AdminResignViewController.m
//  lat
//
//  Created by Techsviewer on 6/18/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import "AdminResignViewController.h"
#import "LevelTitleCell.h"
#import "AdminGameSetViewController.h"

@interface AdminResignViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *lbl_title;
@property (weak, nonatomic) IBOutlet UITableView *tbl_data;

@end

@implementation AdminResignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.lbl_title.text = [NSString stringWithFormat:@"Reassign regions for %@", self.family[PARSE_FAMILY_NAME]];
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self fetchData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) fetchData
{
    self.tbl_data.dataSource = self;
    self.tbl_data.delegate = self;
    [self.tbl_data reloadData];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"LevelTitleCell";
    LevelTitleCell *cell = (LevelTitleCell *)[tv dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell){
        cell.lbl_title.text = [NSString stringWithFormat:@"Level %d", (int)indexPath.row + 1];
    }
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    AdminGameSetViewController * rootView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AdminGameSetViewController"];
    rootView.levelNum = (int)indexPath.row + 1;
    rootView.family = self.family;
    [self.navigationController pushViewController:rootView animated:YES];
}
@end
