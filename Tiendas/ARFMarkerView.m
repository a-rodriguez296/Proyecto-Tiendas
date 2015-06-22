//
//  ARFMarkerView.m
//  Tiendas
//
//  Created by Alejandro Rodriguez on 6/19/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFMarkerView.h"
#import "ARFCommerce.h"

@interface ARFMarkerView ()

//Propiedades Gráficas
@property (weak, nonatomic) IBOutlet UILabel *lblCommerceName;
@property (weak, nonatomic) IBOutlet UISwitch *viewSwitch;

//Propiedades



@end


@implementation ARFMarkerView

-(void) configureWithCommerce:(ARFCommerce *)commerce{
    
    self.commerce = commerce;
    [self.lblCommerceName setText:commerce.commerceName];
    [self.viewSwitch setOn:commerce.isUserSignedUp];
}


- (IBAction)switchDidChangeValue:(id)sender {
     UISwitch *viewSwitch = (UISwitch *) sender;
    if ([self.delegate respondsToSelector:@selector(ARFMarkerView:didChangeSwitchState:)]) {
        [self.delegate ARFMarkerView:self didChangeSwitchState:viewSwitch.on];
    }
    
}

@end
