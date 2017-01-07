//
//  ContactManager.h
//  iosTask
//
//  Created by Yevgeni on 07.01.17.
//  Copyright © 2017 BSUIR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Contacts/Contacts.h>

@interface ContactManager : NSObject

+ (id)sharedManager;
- (void)requestAccess:(void (^)(NSMutableArray *contacts))retrievedContacts;

@end
