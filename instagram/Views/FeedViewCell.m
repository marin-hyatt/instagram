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
}

- (void)updateAppearance {
    self.postImageView.image = nil;
    
    if (self.post[@"image"] != nil) {
        PFFileObject *image = self.post[@"image"];
            [image getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
                self.postImageView.image = [UIImage imageWithData:data];
            }];
        self.postCaption.text = self.post[@"caption"];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
