//
//  FeedViewCell.m
//  instagram
//
//  Created by Marin Hyatt on 7/6/21.
//

#import "FeedViewCell.h"
#import "Parse/Parse.h"

@implementation FeedViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self updateAppearance];
    
    // Add gesture recognizer
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showDetails:)];
    // Attach gesture recognizer to profile picture and enables user interaction
    [self.postImageView addGestureRecognizer:tapGestureRecognizer];
    [self.postImageView setUserInteractionEnabled:YES];
}

- (void)updateAppearance {
    self.postImageView.image = nil;
    
    if (self.post[@"image"] != nil) {
        // Update post with image, caption, username, etc
        PFFileObject *image = self.post[@"image"];
            [image getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
                self.postImageView.image = [UIImage imageWithData:data];
            }];
        self.postCaption.text = self.post[@"caption"];
        
        // Gets user
        PFUser *user = self.post[@"author"];
        self.username.text = user[@"username"];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)showDetails:(UITapGestureRecognizer *)sender {
    NSLog(@"Show details");
}


@end
