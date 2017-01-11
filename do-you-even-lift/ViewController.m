//
//  ViewController.m
//  do-you-even-lift
//
//  Created by Alex Burley on 07/01/2017.
//  Copyright © 2017 Alex Burley. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <CoreData/CoreData.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "MenuViewController.h"

//Test Commit

@interface ViewController () <FBSDKLoginButtonDelegate>

@end

@implementation ViewController {
    
    NSString *_name;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.center = self.view.center;
    loginButton.readPermissions = @[@"public_profile"];
    [loginButton setDelegate:self];
    [self.view addSubview:loginButton];
    
    usersButton = [UIButton buttonWithType:UIButtonTypeCustom];
    usersButton.backgroundColor = [UIColor redColor];
    [usersButton addTarget:self action:NSSelectorFromString(@"usersButtonPressed") forControlEvents:UIControlEventTouchUpInside];
    [usersButton setTitle:@"Users" forState:UIControlStateNormal];
    usersButton.frame = CGRectMake(self.view.frame.size.width*0.4, self.view.frame.size.height*0.2, self.view.frame.size.width*0.20, self.view.frame.size.height*0.10);
   
    if ([FBSDKAccessToken currentAccessToken]){
        [self.view addSubview:usersButton];
        NSLog(@"User ID: %@", [FBSDKAccessToken currentAccessToken].userID);
        [self performSegueWithIdentifier:@"showMenu" sender:self];
    }
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
    [usersButton removeFromSuperview];
}

-(void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error{
    [self.view addSubview:usersButton];
  
    
    NSDictionary *parameters = @{@"fields":@"email,name"};
    FBSDKGraphRequest *graphRequest = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters];
    
    
    [graphRequest startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error){
        _name = [result objectForKey:@"name"];
        NSLog(@"fetched username is:%@", _name);
        [self performSegueWithIdentifier:@"showMenu" sender:self];
    }];
    
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if ([segue.identifier isEqualToString:@"showMenu"]){
        MenuViewController *controller = [segue destinationViewController];
        controller.name = _name;
       
    }
}

-(void)usersButtonPressed{
    [self performSegueWithIdentifier:@"showMenu" sender:self];
    
}

@end
