//
//  ProfileCollectionViewCell.m
//  instagram
//
//  Created by Marin Hyatt on 7/8/21.
//

#import "ProfileCollectionViewCell.h"

@implementation ProfileCollectionViewCell

- (void)updateAppearance {
    // Update picture
    self.thumbnailView.image = nil;
    
    if (self.post[@"image"] != nil) {
        // Update post with image, caption, username, etc
        PFFileObject *image = self.post[@"image"];
        [image getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
            self.thumbnailView.image = [UIImage imageWithData:data];
        }];
    }
}

@end
