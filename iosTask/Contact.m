//
//  Contact.m
//  iosTask
//
//  Created by Yevgeni on 07.01.17.
//  Copyright © 2017 BSUIR. All rights reserved.
//

#import "Contact.h"

@implementation Contact

- (instancetype)init:(CNContact*)contact {
    
    if([contact isKeyAvailable:CNContactEmailAddressesKey]){
        self.email = [contact.emailAddresses.firstObject value];
    }
    
    if([contact isKeyAvailable:CNContactGivenNameKey] && [contact isKeyAvailable:CNContactFamilyNameKey]) {
        self.name = [NSString stringWithFormat:@"%@ %@", contact.givenName, contact.familyName];
    }
    
    if([contact isKeyAvailable:CNContactImageDataKey] && [contact imageDataAvailable]){
        self.image = [UIImage imageWithData:contact.imageData];
    }
    
    return self;
}

@end
