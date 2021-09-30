//
//  AdminEditProfileViewController.m
//  lat
//
//  Created by Techsviewer on 6/18/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import "AdminEditProfileViewController.h"

@interface AdminEditProfileViewController ()<CircleImageAddDelegate>
{
    PFUser * me;
    BOOL isCamera;
    BOOL isGallery;
    BOOL hasPhoto;
}
@property (weak, nonatomic) IBOutlet UITextField *edt_email;
@property (weak, nonatomic) IBOutlet UITextField *edt_password;
@property (weak, nonatomic) IBOutlet UITextField *edt_confirm;
@property (weak, nonatomic) IBOutlet UIButton *btn_next;

@property (weak, nonatomic) IBOutlet CircleImageView *img_thumb;
@end

@implementation AdminEditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _img_thumb.delegate = self;
    [self fetchData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) fetchData
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    me = [PFUser currentUser];
    [me fetchInBackgroundWithBlock:^(PFObject* object, NSError * error){
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            if (error){
                [Util showAlertTitle:self title:@"Error" message:[error localizedDescription]];
            }else{
                me = object;
                self.edt_email.text = me[PARSE_USER_NAME];
                self.edt_password.text = me[PARSE_USER_PREVIEWPWD];
                self.edt_confirm.text = me[PARSE_USER_PREVIEWPWD];
                
                PFFile * thumbFile = me[PARSE_USER_AVATAR];
                [Util setImage:self.img_thumb imgFile:thumbFile withDefaultImage:[UIImage imageNamed:@"img_emptyUser"]];
            }
        });
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
- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)onSave:(id)sender {
    PFUser * me = [PFUser currentUser];
    NSString * password = self.edt_password.text;
    NSString * confirm = self.edt_confirm.text;
    NSString * recentPassword = me[PARSE_USER_PREVIEWPWD];
    if(password.length < 6 || password.length > 20){
        [Util showAlertTitle:self title:@"Edit Profile" message:@"We detected an error. Help me review your answer and try again." finish:^(void) {
            [self.edt_password becomeFirstResponder];
        }];
    }else if(![password isEqualToString:confirm]){
        [Util showAlertTitle:self title:@"Edit Profile" message:@"We detected an error. Help me review your answer and try again." finish:^(void) {
            [self.edt_confirm becomeFirstResponder];
        }];
    }else{
        if(hasPhoto){
            UIImage *profileImage = [Util getUploadingImageFromImage:_img_thumb.image];
            NSData *imageData = UIImageJPEGRepresentation(profileImage, 0.8);
            me[PARSE_USER_AVATAR] = [PFFile fileWithData:imageData];
        }
        
        if(![recentPassword isEqualToString:password]){
            me.password = password;
            me[PARSE_USER_PREVIEWPWD] = password;
        }
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [me saveInBackgroundWithBlock:^(BOOL success, NSError * error){
            [PFUser logInWithUsernameInBackground:me.email password:me.password block:^(PFObject *object, NSError *error){
                [SVProgressHUD dismiss];
                if(!error){
                    [Util setLoginUserName:[Util getLoginUserName] password:password];
                    [Util showAlertTitle:self title:@"Success" message:@"Your profile successfully changed." finish:^{
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                }else{
                    [Util showAlertTitle:self title:@"Error" message:[error localizedDescription]];
                }
            }];
        }];
    }
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
    [_img_thumb setImage:image];
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

@end
