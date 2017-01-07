//
//  ContactCollectionViewCell.h
//  iosTask
//
//  Created by Yevgeni on 07.01.17.
//  Copyright © 2017 BSUIR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *name;

@end
