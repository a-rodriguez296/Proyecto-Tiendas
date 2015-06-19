//
//  Commerce.h
//  Tiendas
//
//  Created by Alejandro Rodriguez on 6/19/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//


#import <Mantle/Mantle.h>

@interface Commerce : MTLModel <MTLJSONSerializing>


@property(nonatomic, copy, readonly) NSString *commerceName;
@property(nonatomic, copy) NSString *commerceId;
@property(nonatomic, assign) BOOL isUserSignedUp;

@end
