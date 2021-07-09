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
#import "Post.h"
#import "EditProfileViewController.h"

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
    self.profileView.user = self.user;
    [self.profileView updateAppearance];
    
    self.inset = 0;
    self.minimumLineSpacing = 5;
    self.minimumInteritemSpacing = 5;
    self.cellsPerRow = 3;
    
    // Add gesture recognizer for showing user profile
    UITapGestureRecognizer *profileTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onProfileTapped:)];
    [self.profileView.profilePicture addGestureRecognizer:profileTapGestureRecognizer];
    [self.profileView.profilePicture setUserInteractionEnabled:YES];
    
    [self loadPosts];

}


- (nonnull __kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProfileCollectionViewCell *cell = [self.postCollectionView dequeueReusableCellWithReuseIdentifier:@"ProfileCollectionViewCell" forIndexPath:indexPath];
    
    cell.post = self.feed[indexPath.row];
    
    [cell updateAppearance];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.feed count];
//    return 20;
}

-(void)loadPosts {
    NSLog(@"Load posts");
    //Querys Parse for instagram posts
    
    // construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    [postQuery whereKey:@"author" equalTo:self.user];
    postQuery.limit = 20;

    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            // do something with the data fetched
            NSLog(@"Feed successfully loaded");
            self.feed = posts;
            [self.postCollectionView reloadData];
        }
        else {
            // handle error
            NSLog(@"Error: %@", error.localizedDescription);
        }
    }];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat marginsAndInsets = self.inset * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + self.minimumInteritemSpacing * (CGFloat)(self.cellsPerRow - 1);

    //Accounting for the spaces in between the movie posters
    CGFloat itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / (CGFloat)self.cellsPerRow);
    return CGSizeMake(itemWidth, itemWidth);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return self.minimumLineSpacing;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    EditProfileViewController *vc = [segue destinationViewController];
    vc.user = self.user;

}


-(void)onProfileTapped:(UITapGestureRecognizer *)sender {
    PFUser *user = [PFUser currentUser];
    if ([self.user.username isEqual: user.username]) {
        NSLog(@"Profile picture tapped");
        [self performSegueWithIdentifier:@"EditProfileViewController" sender:nil];
    }
}

@end



