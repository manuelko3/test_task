//
//  Contact.h
//  iosTask
//
//  Created by Yevgeni on 07.01.17.
//  Copyright © 2017 BSUIR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <Contacts/Contacts.h>

@interface Contact : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) UIImage*  image;
@property (nonatomic, strong) NSString* email;

- (instancetype)init:(CNContact*)contact;

@end
