//
//  ARFCommerceCell.h
//  Tiendas
//
//  Created by Alejandro Rodriguez on 6/19/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ARFCommerce;

@protocol ARFCommerceCellDelegate;

@interface ARFCommerceCell : UITableViewCell

@property(nonatomic, weak) id<ARFCommerceCellDelegate> delegate;

-(void) configureCellWithCommerce:(ARFCommerce *) commerceObject;

@end


@protocol ARFCommerceCellDelegate <NSObject>

-(void) ARFCommerceCell:(ARFCommerceCell *) cell didChangeSwitchState:(BOOL) state;

@end