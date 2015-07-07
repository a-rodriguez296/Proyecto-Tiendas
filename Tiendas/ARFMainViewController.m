//
//  ARFMainViewController.m
//  Tiendas
//
//  Created by Alejandro Rodriguez on 6/19/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFMainViewController.h"
#import "ARFCommerceTableViewController.h"
#import "UAirship.h"
#import "UACustomEvent.h"
#import "UAAnalytics.h"
#import "UALocationService.h"



@interface ARFMainViewController ()

@end

@implementation ARFMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UACustomEvent *event = [UACustomEvent eventWithName:@"Controller"];
    
    // Record the event
    [[UAirship shared].analytics addEvent:event];
    
    //Report Location
    [[UAirship shared].locationService reportCurrentLocation];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)didTapAddCommerce:(id)sender {
    
    ARFCommerceTableViewController *commerceTableVC = [[ARFCommerceTableViewController alloc] initWithStyle:UITableViewStylePlain];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:commerceTableVC];
    
    [self presentViewController:navVC animated:YES completion:nil];
}

@end
