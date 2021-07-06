//
//  ComposeViewController.m
//  instagram
//
//  Created by Marin Hyatt on 7/6/21.
//

#import "ComposeViewController.h"
#import "ComposeView.h"
#import "CameraViewController.h"

@interface ComposeViewController () <CameraViewControllerDelegate>
@property (strong, nonatomic) IBOutlet ComposeView *composeView;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Sets itself as the delegate for camera view controller
    
    
}

- (void)passBackImage:(UIImage *)image {
    self.composeView.image.image = image;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CameraViewController *cameraController = [segue destinationViewController];
    cameraController.delegate = self;
}


@end
