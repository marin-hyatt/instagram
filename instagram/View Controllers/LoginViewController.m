//
//  LoginViewController.m
//  instagram
//
//  Created by Marin Hyatt on 7/6/21.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "Parse/Parse.h"

@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet LoginView *loginView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Initialize the login view
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)logInPressed:(id)sender {
    [self loginUser];
}

- (IBAction)signUpPressed:(id)sender {
    [self registerUser];
}

// Signs up a new user
- (void)registerUser {
    // Checks to see if username and/or password are empty before proceeding with login
    if ([self.loginView.usernameField.text isEqual:@""]) {
        [self showErrorMessage:@"Username cannot be empty."];
    }
    
    if ([self.loginView.passwordField.text isEqual:@""]) {
        [self showErrorMessage:@"Password cannot be empty."];
    }
    
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.loginView.usernameField.text;
    newUser.password = self.loginView.passwordField.text;
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
            [self showErrorMessage:error.localizedDescription];
        } else {
            NSLog(@"User registered successfully");
            
            // manually segue to logged in view
            [self performSegueWithIdentifier:@"HomeFeedSegue" sender:nil];
        }
    }];
}

// Logs in a registered user
- (void)loginUser {
    // Checks to see if username and/or password are empty before proceeding with login
    if ([self.loginView.usernameField.text isEqual:@""]) {
        [self showErrorMessage:@"Username cannot be empty."];
    }
    
    if ([self.loginView.passwordField.text isEqual:@""]) {
        [self showErrorMessage:@"Password cannot be empty."];
    }
    
    NSString *username = self.loginView.usernameField.text;
    NSString *password = self.loginView.passwordField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
            [self showErrorMessage:error.localizedDescription];
        } else {
            NSLog(@"User logged in successfully");
            
            // display view controller that needs to shown after successful login
            [self performSegueWithIdentifier:@"HomeFeedSegue" sender:nil];
        }
    }];
}

-(void)showErrorMessage: (NSString *)message {
    // Creates error message
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                               message:message
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];
    // create an OK action
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                             // handle response here.
                                                     }];
    // add the OK action to the alert controller
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:^{
    }];
}

@end
