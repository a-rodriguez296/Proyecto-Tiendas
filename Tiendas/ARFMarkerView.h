//
//  ARFMarkerView.h
//  Tiendas
//
//  Created by Alejandro Rodriguez on 6/19/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARFCommerceCell.h"

@protocol ARFMarkerViewDelegate;

@interface ARFMarkerView : UIView

@property(nonatomic, weak) id<ARFMarkerViewDelegate> delegate;
@property (nonatomic, strong) ARFCommerce *commerce;

-(ARFCommerce *) commerce;
-(void) configureWithCommerce:(ARFCommerce *)commerce;

@end


@protocol ARFMarkerViewDelegate <NSObject>

-(void) ARFMarkerView:(ARFMarkerView *) markerView didChangeSwitchState:(BOOL) state;

@end