//
//  FeedViewCell.m
//  instagram
//
//  Created by Marin Hyatt on 7/6/21.
//

#import "FeedViewCell.h"
#import "Parse/Parse.h"
#import "DateTools.h"

@implementation FeedViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self updateAppearance];
    
    // Add gesture recognizer
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showDetails:)];
    UITapGestureRecognizer *tapHideGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideDetails:)];
    // Attach gesture recognizer to image view and enables user interaction
    [self.postImageView addGestureRecognizer:tapGestureRecognizer];
    [self.postImageView setUserInteractionEnabled:YES];
    [self.detailView addGestureRecognizer:tapHideGestureRecognizer];
    [self.detailView setUserInteractionEnabled:YES];
    
    self.detailView.hidden = YES;
}

- (void)updateAppearance {
    self.postImageView.image = nil;
    
    if (self.post[@"image"] != nil) {
        // TODO: fix data request
        // Update post with image, caption, username, etc
        PFFileObject *image = self.post[@"image"];
            [image getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
                self.postImageView.image = [UIImage imageWithData:data];
            }];
        
        // Sets captions
        self.postCaption.text = self.post[@"caption"];
        
        self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2;
        self.profilePicture.layer.masksToBounds = true;
    
        
        // Gets user
        PFUser *user = self.post[@"author"];
        self.username.text = user[@"username"];
        self.detailUsername.text = user[@"username"];
        
        
        self.likeCount.text = [NSString stringWithFormat:@"%@", self.post[@"likeCount"]];
        self.commentCount.text = [NSString stringWithFormat:@"%@", self.post[@"commentCount"]];
        
        NSDate *createdAt = self.post.createdAt;
        
        // Format timestamp correctly
        self.timestamp.text = [NSString stringWithFormat:@"%@", createdAt];
        
        double timeInterval = createdAt.timeIntervalSinceNow;
        
        NSDate *timeAgoDate = [NSDate dateWithTimeIntervalSinceNow:timeInterval];
        
        // Configure output format
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateStyle = NSDateFormatterShortStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
        // Convert Date to String
        // If more than a week has passed since the tweet, display the date. Else, use DateTool to get the time elapsed
        if (fabs(timeInterval) > 604800) {
            self.timestamp.text = [formatter stringFromDate:createdAt];
        } else {
            self.timestamp.text = timeAgoDate.shortTimeAgoSinceNow;
        }
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)showDetails:(UITapGestureRecognizer *)sender {
    NSLog(@"Show details");
//    if (self.detailView.hidden == YES) {
    self.detailView.hidden = !self.detailView.hidden;
    
    // Passes post to detail view
    self.detailView.post = self.post;
}

-(void)hideDetails:(UITapGestureRecognizer *)sender {
    NSLog(@"Hide details");
//    if (self.detailView.hidden == YES) {
    self.detailView.hidden = YES;
    
    // Passes post to detail view
    self.detailView.post = self.post;
}


@end
