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
    // Attach gesture recognizer to image view and enables user interaction
    [self.postImageView addGestureRecognizer:tapGestureRecognizer];
    [self.postImageView setUserInteractionEnabled:YES];
    
    self.detailView.hidden = YES;
}

- (void)updateAppearance {
    self.postImageView.image = nil;
    
    if (self.post[@"image"] != nil) {
        // Update post with image, caption, username, etc
        PFFileObject *image = self.post[@"image"];
            [image getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
                self.postImageView.image = [UIImage imageWithData:data];
            }];
        
        // Sets captions
        self.postCaption.text = self.post[@"caption"];
        self.postCaption1.text = self.post[@"caption"];
        
    
        
        // Gets user
        PFUser *user = self.post[@"author"];
        self.username.text = user[@"username"];
        
        self.likeCount.text = [NSString stringWithFormat:@"%@", self.post[@"likeCount"]];
        self.commentCount.text = [NSString stringWithFormat:@"%@", self.post[@"commentCount"]];
        
        NSDate *createdAt = self.post.createdAt;
        self.timestamp.text = [NSString stringWithFormat:@"%@", createdAt];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)showDetails:(UITapGestureRecognizer *)sender {
    NSLog(@"Show details");
    self.detailView.hidden = !self.detailView.hidden;
    
    // Passes post to detail view
    self.detailView.post = self.post;
}


@end
