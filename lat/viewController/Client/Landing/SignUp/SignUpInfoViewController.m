//
//  SignUpInfoViewController.m
//  lat
//
//  Created by Techsviewer on 6/25/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import "SignUpInfoViewController.h"
#import "TermsViewController.h"

@interface SignUpInfoViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, CircleImageAddDelegate>
{
    BOOL isCamera;
    BOOL isGallery;
    BOOL hasPhoto;
}
@property (weak, nonatomic) IBOutlet CircleImageView *img_thumb;
@property (weak, nonatomic) IBOutlet UITextField *edt_firstname;
@property (weak, nonatomic) IBOutlet UITextField *edt_lastname;
@property (weak, nonatomic) IBOutlet UIButton *etn_next;

@end

@implementation SignUpInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.edt_firstname.delegate = self;
    self.edt_lastname.delegate = self;
    [_edt_firstname addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [_edt_lastname addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    _img_thumb.delegate = self;
    [self.etn_next setEnabled:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (IBAction)onNext:(id)sender {
    if([super checkNetworkState]){
        if(!hasPhoto){
            NSString *msg = @"Are you sure you want to proceed without a profile photo?";
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            alert.customViewColor = MAIN_COLOR;
            alert.horizontalButtons = YES;
            [alert addButton:@"Yes" actionBlock:^(void) {
                [self signUpUserInfo];
            }];
            [alert addButton:@"Upload photo" actionBlock:^(void) {
                [self tapCircleImageView];
            }];
            [alert showError:@"Sign Up" subTitle:msg closeButtonTitle:nil duration:0.0f];
        }else{
            [self signUpUserInfo];
        }
    }
}
- (void) signUpUserInfo
{
    if (hasPhoto){
        UIImage *profileImage = [Util getUploadingImageFromImage:_img_thumb.image];
        NSData *imageData = UIImageJPEGRepresentation(profileImage, 0.8);
        self.user[PARSE_USER_AVATAR] = [PFFile fileWithData:imageData];
    }
    self.user[PARSE_USER_FULLNAME] = [NSString stringWithFormat:@"%@ %@",  _edt_firstname.text, _edt_lastname.text];
    self.user[PARSE_USER_FIRSTNAME] = _edt_firstname.text;
    self.user[PARSE_USER_LASTSTNAME] = _edt_lastname.text;
    self.user[PARSE_USER_TYPE] = [NSNumber numberWithInt:100];
    self.user[PARSE_USER_PREVIEWPWD] = self.user.password;
    
    TermsViewController * rootView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TermsViewController"];
    rootView.user = self.user;
    rootView.isAdmin = YES;
    [self.navigationController pushViewController:rootView animated:YES];
}

- (void) tapCircleImageView {
    UIAlertController *actionsheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [actionsheet addAction:[UIAlertAction actionWithTitle:@"Take a new photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self onTakePhoto:nil];
    }]];
    [actionsheet addAction:[UIAlertAction actionWithTitle:@"Select from gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self onChoosePhoto:nil];
    }]];
    [actionsheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    [self presentViewController:actionsheet animated:YES completion:nil];
}

- (void)onChoosePhoto:(id)sender {
    if (![Util isPhotoAvaileble]){
        [Util showAlertTitle:self title:@"Error" message:@"Check your permissions in Settings > Privacy > Photo"];
        return;
    }
    isGallery = YES;
    isCamera = NO;
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)onTakePhoto:(id)sender {
    if (![Util isCameraAvailable]){
        [Util showAlertTitle:self title:@"Error" message:@"Check your permissions in Settings > Privacy > Cameras"];
        return;
    }
    isCamera = YES;
    isGallery = NO;
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    if (isCamera && ![Util isCameraAvailable]){
        [Util showAlertTitle:self title:@"Error" message:@"Check your permissions in Settings > Privacy > Cameras"];
        return;
    }
    if (isGallery && ![Util isPhotoAvaileble]){
        [Util showAlertTitle:self title:@"Error" message:@"Check your permissions in Settings > Privacy > Photo"];
        return;
    }
    UIImage *image = (UIImage *)[info valueForKey:UIImagePickerControllerOriginalImage];
    hasPhoto = YES;
    image = [Util cropedImage:image];
    [_img_thumb setImage:image];
    [self checkState];
}
- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
    if (isGallery && ![Util isPhotoAvaileble]){
        [Util showAlertTitle:self title:@"Error" message:@"Check your permissions in Settings > Privacy > Photo"];
        return;
    }
    if (isCamera && ![Util isCameraAvailable]){
        [Util showAlertTitle:self title:@"Error" message:@"Check your permissions in Settings > Privacy > Cameras"];
        return;
    }
}


- (void) checkState
{
    [self.etn_next setEnabled:NO];
    self.etn_next.selected = NO;
    if(_edt_firstname.text.length > 0 && _edt_lastname.text.length > 0){
        [self.etn_next setEnabled:YES];
    }
}
#pragma mark - UItextfield delegate
- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [self checkState];
    return YES;
}
- (void)textFieldChanged:(UITextField *)textField
{
    [self checkState];
}
@end
