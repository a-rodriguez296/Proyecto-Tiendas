//
//  ARFMainViewController.m
//  Tiendas
//
//  Created by Alejandro Rodriguez on 6/19/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFMainViewController.h"
#import "ARFCommerceTableViewController.h"

@interface ARFMainViewController ()

@end

@implementation ARFMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)didTapAddCommerce:(id)sender {
    
    ARFCommerceTableViewController *commerceTableVC = [ARFCommerceTableViewController new];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:commerceTableVC];
    
    [self presentViewController:navVC animated:YES completion:nil];
}

@end
