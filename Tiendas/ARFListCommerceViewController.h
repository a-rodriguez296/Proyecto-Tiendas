//
//  ARFListCommerceViewController.h
//  Tiendas
//
//  Created by Alejandro Rodriguez on 6/22/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>
#import "ARFCommerceCell.h"

@interface ARFListCommerceViewController  : PFQueryTableViewController <ARFCommerceCellDelegate>

@end
