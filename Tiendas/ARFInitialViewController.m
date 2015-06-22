//
//  ARFInitialViewController.m
//  Tiendas
//
//  Created by Alejandro Rodriguez on 6/22/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFInitialViewController.h"
#import "ARFListCommerceViewController.h"
#import "ARFMapCommerceViewController.h"

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
    UINavigationController *listNavVC = [[UINavigationController alloc] initWithRootViewController:listCommerceVC];
    
    ARFMapCommerceViewController *mapVC = [[ARFMapCommerceViewController alloc] init];
    UINavigationController *mapNavVC = [[UINavigationController alloc] initWithRootViewController:mapVC];
    
    UITabBarController *tabBar = [UITabBarController new];
    [tabBar setViewControllers:@[listNavVC, mapNavVC]];
    
    [self presentViewController:tabBar animated:YES completion:nil];
    
}

@end
