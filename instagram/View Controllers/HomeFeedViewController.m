//
//  HomeFeedViewController.m
//  instagram
//
//  Created by Marin Hyatt on 7/6/21.
//

#import "HomeFeedViewController.h"
#import "Parse/Parse.h"
#import "LoginViewController.h"
#import "ProfileViewController.h"
#import "AppDelegate.h"
#import "SceneDelegate.h"
#import "FeedViewCell.h"
#import "Post.h"

@interface HomeFeedViewController () <UITableViewDelegate, UITableViewDataSource, FeedViewCellDelegate>
@property (nonatomic, strong) NSArray *feed;
- (IBAction)logOut:(id)sender;
- (IBAction)postPhoto:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *feedTableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (assign, nonatomic) BOOL isMoreDataLoading;
@property int numDataToLoad;
@end

@implementation HomeFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.feedTableView.delegate = self;
    self.feedTableView.dataSource = self;
    
    // Gets posts from Parse
    self.numDataToLoad = 20;
    [self loadPosts:self.numDataToLoad];
    
    // Initializes refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(loadPosts:) forControlEvents:UIControlEventValueChanged];
    [self.feedTableView insertSubview:self.refreshControl atIndex:0];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row + 1 == [self.feed count] && !self.isMoreDataLoading){
        self.isMoreDataLoading = true;
        self.numDataToLoad++;
        [self loadPosts:self.numDataToLoad];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FeedViewCell *cell = [self.feedTableView dequeueReusableCellWithIdentifier:@"FeedViewCell"];
    
    cell.delegate = self;
    
    // Passes Post object to cell
    cell.post = self.feed[indexPath.row];
    [cell updateAppearance];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.feed count];
}

-(void)loadPosts:(int)limit {
    NSLog(@"Load posts");
    //Querys Parse for instagram posts
    
    // construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = limit;

    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            self.isMoreDataLoading = false;
            // do something with the data fetched
            NSLog(@"Feed successfully loaded");
            self.feed = posts;
            [self.feedTableView reloadData];
            [self.refreshControl endRefreshing];
        }
        else {
            // handle error
            NSLog(@"Error: %@", error.localizedDescription);
        }
    }];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ProfileViewController"]) {
        // Passes the user to the profile view controller
        UINavigationController *navigationController = [segue destinationViewController];
        ProfileViewController *vc = (ProfileViewController*)navigationController.topViewController;
        vc.user = sender;
    }
}


// Segues to camera view controller
- (IBAction)postPhoto:(id)sender {
    [self performSegueWithIdentifier:@"ComposeViewController" sender:nil];
}

// Logs out user and exits to login screen
- (IBAction)logOut:(id)sender {
    //Creates app delegate, Main storyboard, and Login view controller. Then sets the root view controller (the one the user sees) to the Login view controller
    SceneDelegate *myDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    myDelegate.window.rootViewController = loginViewController;
    
    // Logs out user
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
}

- (void)feedCell:(FeedViewCell *)feedCell didTap:(PFUser *)user {
    [self performSegueWithIdentifier:@"ProfileViewController" sender:user];
}

@end
