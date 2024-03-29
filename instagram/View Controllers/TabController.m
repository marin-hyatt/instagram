//
//  TabController.m
//  instagram
//
//  Created by Marin Hyatt on 7/9/21.
//

#import "TabController.h"
#import "Parse/Parse.h"
#import "ProfileViewController.h"

@interface TabController () <UITabBarControllerDelegate>
@property PFUser *user;

@end

@implementation TabController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    self.user = [PFUser currentUser];
    NSLog(@"%@", self.user);
}

- (void)tabBarController:(UITabBarController *)tabBarController
 didSelectViewController:(UIViewController *)viewController {
    // Checks if profile tab has been selected
    if (tabBarController.selectedIndex == 1) {
        NSLog(@"Profile view controller selected");
        // Pass current user to profile view
        ProfileViewController *vc = (ProfileViewController*) [[(UINavigationController*)[[tabBarController viewControllers] objectAtIndex:1] viewControllers] objectAtIndex:0];
        vc.user = self.user;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
