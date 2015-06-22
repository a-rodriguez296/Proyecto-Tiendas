//
//  ARFInitialViewController.m
//  Tiendas
//
//  Created by Alejandro Rodriguez on 6/22/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFInitialViewController.h"
#import "ARFListCommerceViewController.h"

@interface ARFInitialViewController ()

@end

@implementation ARFInitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapAddCommerce:(id)sender {
    
    ARFListCommerceViewController *listCommerceVC = [[ARFListCommerceViewController alloc] initWithStyle:UITableViewStylePlain];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:listCommerceVC];
    [self presentViewController:navVC animated:YES completion:nil];
    
}

@end
