//
//  ProfileViewController.h
//  instagram
//
//  Created by Marin Hyatt on 7/8/21.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController
@property PFUser *user;

@end

NS_ASSUME_NONNULL_END
