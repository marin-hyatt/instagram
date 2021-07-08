//
//  ProfileViewController.m
//  instagram
//
//  Created by Marin Hyatt on 7/8/21.
//

#import "ProfileViewController.h"
#import "ProfileView.h"
#import "Parse/Parse.h"
#import "ProfileCollectionViewCell.h"

@interface ProfileViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) IBOutlet ProfileView *profileView;
@property (weak, nonatomic) IBOutlet UICollectionView *postCollectionView;
@property (strong, nonatomic) NSArray *feed;
@property CGFloat inset;
@property CGFloat minimumLineSpacing;
@property CGFloat minimumInteritemSpacing;
@property CGFloat cellsPerRow;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.postCollectionView.delegate = self;
    self.postCollectionView.dataSource = self;
    
    // Sets the user for the profile page to the current user, then updates the view with the relevant information
    self.profileView.user = [PFUser currentUser];
    [self.profileView updateAppearance];
    
    self.inset = 0;
    self.minimumLineSpacing = 5;
    self.minimumInteritemSpacing = 5;
    self.cellsPerRow = 3;

}

- (nonnull __kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProfileCollectionViewCell *cell = [self.postCollectionView dequeueReusableCellWithReuseIdentifier:@"ProfileCollectionViewCell" forIndexPath:indexPath];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return [self.feed count];
    return 20;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    let marginsAndInsets = inset * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
//    let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
//    return CGSize(width: itemWidth, height: itemWidth)
    CGFloat marginsAndInsets = self.inset * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + self.minimumInteritemSpacing * (CGFloat)(self.cellsPerRow - 1);

    //Accounting for the spaces in between the movie posters
    CGFloat itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / (CGFloat)self.cellsPerRow);
    return CGSizeMake(itemWidth, itemWidth);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return self.minimumLineSpacing;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end



