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

NS_ASSUME_NONNULL_BEGIN

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
- (void) showDetails:(UITapGestureRecognizer *)sender;
-(void) updateAppearance;

@end

NS_ASSUME_NONNULL_END
