//
//  ProfileView.m
//  instagram
//
//  Created by Marin Hyatt on 7/8/21.
//

#import "ProfileView.h"

@implementation ProfileView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)updateAppearance {
    
    // Sets username
    self.username.text = self.user.username;
    
    // Sets profile picture
    self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2;
    self.profilePicture.layer.masksToBounds = true;
}

@end
