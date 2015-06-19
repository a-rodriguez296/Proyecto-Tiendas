//
//  ARFCommerceCell.h
//  Tiendas
//
//  Created by Alejandro Rodriguez on 6/19/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ARFCommerce;

@protocol ARFCommerCellDelegate;

@interface ARFCommerceCell : UITableViewCell

@property(nonatomic, weak) id<ARFCommerCellDelegate> delegate;

-(void) configureCellWithCommerce:(ARFCommerce *) commerceObject;

@end


@protocol ARFCommerCellDelegate <NSObject>

-(void) ARFCommerceCell:(ARFCommerceCell *) cell didChangeSwitchState:(BOOL) state;

@end