//
//  EditProfileViewController.h
//  instagram
//
//  Created by Marin Hyatt on 7/9/21.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"

NS_ASSUME_NONNULL_BEGIN

@interface EditProfileViewController : UIViewController
@property PFUser *user;
- (IBAction)onUpdateButtonPressed:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
