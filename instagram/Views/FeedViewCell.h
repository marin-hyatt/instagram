//
//  FeedViewCell.h
//  instagram
//
//  Created by Marin Hyatt on 7/6/21.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "Parse/Parse.h"

NS_ASSUME_NONNULL_BEGIN

@interface FeedViewCell : UITableViewCell
@property Post *post;
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *postCaption;
@property (weak, nonatomic) IBOutlet UILabel *username;
- (void) showDetails:(UITapGestureRecognizer *)sender;
-(void) updateAppearance;

@end

NS_ASSUME_NONNULL_END
