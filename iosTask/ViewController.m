//
//  ViewController.m
//  iosTask
//
//  Created by Yevgeni on 07.01.17.
//  Copyright © 2017 BSUIR. All rights reserved.
//

#import "ViewController.h"
#import "ContactCollectionViewCell.h"
#import "ContactManager.h"
#import "Contact.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

static NSString* kCellIdentifier = @"Cell";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    ContactManager *cm = [ContactManager sharedManager];
    [cm requestAccess:^(NSMutableArray *contacts) {
        self.contacts = contacts;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.addressCollectionView reloadData];
        });
    }];
    
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.contacts.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ContactCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    Contact * contact = _contacts[indexPath.row];
    
    cell.name.text = contact.name;
    if(contact.image == nil) {
        cell.image.image = [UIImage imageNamed:@"DefaultContactImage"];
    } else {
        cell.image.image = contact.image;
    }
    cell.email.text = contact.email;
    
    return cell;
    
}

- (IBAction)FBlogin:(UIButton *)sender {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    
    [login logInWithReadPermissions:@[@"public_profile", @"email", @"user_friends"]
                 fromViewController:self
                            handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                if (error) {
                                    NSLog(@"error is :%@",error);
                                }
                                else if (result.isCancelled) {
                                    NSLog(@"error is :%@",error);
                                }
                                else {
                                    if ([result.grantedPermissions containsObject:@"email"]) {
                                        FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"/me/friends"
                                                                                                       parameters:@{@"fields": @"name"}
                                                                                                       HTTPMethod:@"GET"];
                                        [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                                            NSLog(@"request friend list:%@", result);
                                        }];
                                    }
                                }
                            }];
}

@end
