//
//  ComposeViewController.m
//  instagram
//
//  Created by Marin Hyatt on 7/6/21.
//

#import "ComposeViewController.h"
#import "ComposeView.h"

@interface ComposeViewController ()
@property (strong, nonatomic) IBOutlet ComposeView *composeView;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.composeView.caption setText:@"Placeholder"];
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
