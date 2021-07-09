//
//  FeedViewCell.h
//  instagram
//
//  Created by Marin Hyatt on 7/6/21.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "Parse/Parse.h"
#import "DetailView.h"
#import "FeedViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol FeedViewCellDelegate;


@interface FeedViewCell : UITableViewCell
@property Post *post;
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *postCaption;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet DetailView *detailView;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@property (weak, nonatomic) IBOutlet UILabel *commentCount;
@property (weak, nonatomic) IBOutlet UILabel *timestamp;
@property (weak, nonatomic) IBOutlet UILabel *detailUsername;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) id<FeedViewCellDelegate> delegate; // Delegate that handles the profile picture being tapped
- (void) showDetails:(UITapGestureRecognizer *)sender;
-(void) updateAppearance;

@end

@protocol FeedViewCellDelegate <NSObject>
- (void)feedCell:(FeedViewCell *) feedCell didTap: (PFUser *)user;

@end

NS_ASSUME_NONNULL_END
