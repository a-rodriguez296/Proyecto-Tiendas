//
//  ARFCommerceCell.m
//  Tiendas
//
//  Created by Alejandro Rodriguez on 6/19/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFCommerceCell.h"
#import "ARFCommerce.h"

@interface ARFCommerceCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblCommerceName;
@property (weak, nonatomic) IBOutlet UISwitch *cellSwitch;

@end


@implementation ARFCommerceCell


-(void) configureCellWithCommerce:(ARFCommerce *) commerceObject{
    [self.lblCommerceName setText:commerceObject.commerceName];
    [self.cellSwitch setOn:commerceObject.isUserSignedUp];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)switchDidChangeValue:(id)sender {
    UISwitch *cellSwitch = (UISwitch *) sender;
    if ([self.delegate respondsToSelector:@selector(ARFCommerceCell:didChangeSwitchState:)]) {
        [self.delegate ARFCommerceCell:self didChangeSwitchState:cellSwitch.on];
    }
}

@end
