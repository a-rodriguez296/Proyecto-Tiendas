//
//  Commerce.m
//  Tiendas
//
//  Created by Alejandro Rodriguez on 6/19/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFCommerce.h"
#import "ARFConstants.h"

#import <Parse/Parse.h>
@implementation ARFCommerce


#pragma mark MTLJSONSerializing
+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{kCommerceName:kCommerceName,
             kCommerceId:kCommerceId};
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error{
    self = [super initWithDictionary:dictionaryValue error:error];
    
    PFInstallation * currentInstalation = [PFInstallation currentInstallation];
    NSArray * channels = [currentInstalation objectForKey:kChannels];
    if (channels.count) {
        BOOL contains = [channels containsObject:self.commerceId];
        self.isUserSignedUp = contains;
    }

    return self;
}



@end
