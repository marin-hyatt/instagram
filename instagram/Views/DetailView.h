//
//  DetailView.h
//  instagram
//
//  Created by Marin Hyatt on 7/7/21.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailView : UIView
@property (nonatomic, strong) Post *post;
-(void) updateAppearance;

@end

NS_ASSUME_NONNULL_END
