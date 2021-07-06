//
//  CameraViewController.h
//  instagram
//
//  Created by Marin Hyatt on 7/6/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CameraViewControllerDelegate <NSObject>

- (void)passBackImage:(UIImage *) image;

@end

@interface CameraViewController : UIViewController
@property (nonatomic, weak) id<CameraViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
