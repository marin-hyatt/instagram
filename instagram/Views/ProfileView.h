//
//  ProfileView.h
//  instagram
//
//  Created by Marin Hyatt on 7/8/21.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileView : UIView
@property (weak, nonatomic) PFUser *user;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
-(void)updateAppearance;

@end

NS_ASSUME_NONNULL_END
