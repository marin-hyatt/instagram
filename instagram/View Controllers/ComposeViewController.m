//
//  ComposeViewController.m
//  instagram
//
//  Created by Marin Hyatt on 7/6/21.
//

#import "ComposeViewController.h"
#import "ComposeView.h"
#import "Post.h"

@interface ComposeViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet ComposeView *composeView;
- (IBAction)onImagePickerClicked:(UITapGestureRecognizer *)sender;


@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self showImagePicker];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSLog(@"Finished picking/taking a photo!");
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    UIImage *resizedOriginalImage = [self resizeImage:originalImage withSize: CGSizeMake(originalImage.size.width * 0.6, originalImage.size.height * 0.6)];
    
    // Pass image back to compose view controller
    [self.composeView.image setImage:resizedOriginalImage];
    
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

- (IBAction)cancelCompose:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)postImage:(UIBarButtonItem *)sender {
    NSString *caption = self.composeView.caption.text;
    
    // Post photo to instagram
    [Post postUserImage:self.composeView.image.image withCaption:caption withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Error! %@", error.localizedDescription);
        } else {
            NSLog(@"Photo posted");
        }
    }];
    
    // Dismiss view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    CameraViewController *cameraController = [segue destinationViewController];
//    cameraController.delegate = self;
//}


- (IBAction)onImagePickerClicked:(UITapGestureRecognizer *)sender {
    [self showImagePicker];
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
@end
