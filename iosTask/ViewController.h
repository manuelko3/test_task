//
//  ViewController.h
//  iosTask
//
//  Created by Yevgeni on 07.01.17.
//  Copyright © 2017 BSUIR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UICollectionView *addressCollectionView;
@property (strong, nonatomic) NSMutableArray* contacts;

- (IBAction)FBlogin:(UIButton *)sender;

@end

