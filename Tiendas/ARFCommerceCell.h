//
//  ARFCommerceCell.h
//  Tiendas
//
//  Created by Alejandro Rodriguez on 6/19/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ARFCommerce;

@interface ARFCommerceCell : UITableViewCell

-(void) configureCellWithCommerce:(ARFCommerce *) commerceObject;

@end
