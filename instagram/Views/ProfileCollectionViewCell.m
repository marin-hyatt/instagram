//
//  ProfileCollectionViewCell.m
//  instagram
//
//  Created by Marin Hyatt on 7/8/21.
//

#import "ProfileCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"

@implementation ProfileCollectionViewCell

- (void)updateAppearance {
    // Update picture
    self.thumbnailView.image = nil;
    
    if (self.post[@"image"] != nil) {
        PFFileObject * postImage = self.post[@"image"]; // set your column name from Parse here
        NSURL * imageURL = [NSURL URLWithString:postImage.url];
        [self.thumbnailView setImageWithURL:imageURL];
    }
}

@end
