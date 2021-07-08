//
//  ProfileCollectionViewCell.h
//  instagram
//
//  Created by Marin Hyatt on 7/8/21.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileCollectionViewCell : UICollectionViewCell
@property Post *post;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;
-(void)updateAppearance;

@end

NS_ASSUME_NONNULL_END
