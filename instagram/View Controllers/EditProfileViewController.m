//
//  EditProfileViewController.m
//  instagram
//
//  Created by Marin Hyatt on 7/9/21.
//

#import "EditProfileViewController.h"
#import "EditProfileView.h"
#import "UIImageView+AFNetworking.h"
#import "Post.h"

@interface EditProfileViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet EditProfileView *editProfileView;
- (IBAction)onProfilePictureTapped:(UITapGestureRecognizer *)sender;

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Gets profile picture from user
    PFFileObject * postImage = self.user[@"profilePhoto"];
    NSURL * imageURL = [NSURL URLWithString:postImage.url];
    [self.editProfileView.profilePicture setImageWithURL:imageURL];
    
//    self.editProfileView.profilePicture.layer.cornerRadius = self.editProfileView.profilePicture.frame.size.width / 2;
//    self.editProfileView.profilePicture.layer.masksToBounds = true;
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSLog(@"Finished picking/taking a photo!");
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    
    UIImage *resizedOriginalImage = [self resizeImage:originalImage withSize: CGSizeMake(originalImage.size.width * 0.6, originalImage.size.height * 0.6)];
    
    // Pass image back to compose view controller
    [self.editProfileView.profilePicture setImage:resizedOriginalImage];
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Resizes image to get under 10MB limit for Parse
- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

-(void) showImagePicker {
    // Sets up image picker
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;

    // Checks to see if phone or simulator is able to take pictures
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onUpdateButtonPressed:(UIButton *)sender {
    // Network request to update user profile picture
    NSLog(@"Button pressed");
    // check if image is not nil
    if (self.editProfileView.profilePicture.image) {
        NSLog(@"image is not null");
        NSData *imageData = UIImagePNGRepresentation(self.editProfileView.profilePicture.image);
        // get image data and check if that is not nil
        if (imageData) {
            NSLog(@"creating file object");
            // Create file object
            PFFileObject *file = [PFFileObject fileObjectWithName:@"image.png" data:imageData];
            
            // Update user info
            PFUser *user = self.user;
            
            NSLog(@"File: %@", file);
            
            user[@"profilePhoto"] = file;
            
            [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
              if (succeeded) {
                     NSLog(@"Profile picture updated!");
              } else {
                     NSLog(@"Error: %@", error.description);
              }
             }];
        }
    }
}
- (IBAction)onProfilePictureTapped:(UITapGestureRecognizer *)sender {
    [self showImagePicker];
}
@end
