//
//  EditProfileViewController.m
//  lat
//
//  Created by Techsviewer on 6/17/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import "EditProfileViewController.h"

@interface EditProfileViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, CircleImageAddDelegate>
{
    BOOL isCamera;
    BOOL isGallery;
    BOOL hasPhoto;
    
    NSMutableArray * m_showData;
}
@property (weak, nonatomic) IBOutlet CircleImageView *img_thumb;
@property (weak, nonatomic) IBOutlet UITextField *edt_profileName;
@property (weak, nonatomic) IBOutlet UITextField *edt_password;
@property (weak, nonatomic) IBOutlet UITextField *edt_confirm;

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _img_thumb.delegate = self;
    
    [self fetchData];
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) fetchData
{
    m_showData = [NSMutableArray new];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [self.family fetchInBackgroundWithBlock:^(PFObject* object, NSError * error){
        if(object)
            self.family = object;
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            if (error){
                [Util showAlertTitle:self title:@"Error" message:[error localizedDescription]];
            }else{
                self.edt_profileName.text = self.family[PARSE_FAMILY_NAME];
                self.edt_password.text = self.family[PARSE_FAMILY_PASSWORD];
                self.edt_confirm.text = self.family[PARSE_FAMILY_PASSWORD];
                PFFile * thumbFile = self.family[PARSE_FAMILY_AVATAR];
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
    if([super checkNetworkState]){
        [_edt_profileName resignFirstResponder];
        NSString * name = _edt_profileName.text;
        NSString * pwd = _edt_password.text;
        NSString * confirm = _edt_confirm.text;
        if(name.length == 0){
            NSString *errorString = @"Please input your profile name.";
            [Util showAlertTitle:self title:@"Error" message:errorString finish:^{
                [_edt_profileName becomeFirstResponder];
            }];
            return;
        }
        if([Util stringContainsInArray:name :m_showData]){
            NSString *errorString = @"You entered an existing profile name. Please try again.";
            [Util showAlertTitle:self title:@"Error" message:errorString finish:^{
                [_edt_profileName becomeFirstResponder];
            }];
            return;
        }
        if(pwd.length == 0){
            NSString *errorString = @"Please input your password.";
            [Util showAlertTitle:self title:@"Error" message:errorString finish:^{
                [_edt_password becomeFirstResponder];
            }];
            return;
        }
        if(pwd.length != 0 && ![pwd isEqualToString:confirm]){
            NSString *errorString = @"Please check your confirm password.";
            [Util showAlertTitle:self title:@"Error" message:errorString finish:^{
                [_edt_confirm becomeFirstResponder];
            }];
            return;
        }
        
        if(hasPhoto){
            UIImage *profileImage = [Util getUploadingImageFromImage:_img_thumb.image];
            NSData *imageData = UIImageJPEGRepresentation(profileImage, 0.8);
            self.family[PARSE_FAMILY_AVATAR] = [PFFile fileWithData:imageData];
        }
        self.family[PARSE_FAMILY_NAME] = name;
        if(pwd.length > 0){
            self.family[PARSE_FAMILY_PASSWORD] = pwd;
        }
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [self.family saveInBackgroundWithBlock:^(BOOL success, NSError * error){
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                if(success){
                    [Util showAlertTitle:self title:@"Success" message:@"Your profile successfully changed." finish:^{
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                }else{
                    [Util showAlertTitle:self title:@"Error" message:[error localizedDescription]];
                }
            });
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
    image = [Util cropedImage:image];
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
