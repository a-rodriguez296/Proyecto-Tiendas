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
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    [self setTitle:@"Tiendas"];
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Agregar Tiendas" style:UIBarButtonItemStylePlain target:self action:@selector(didTapAddCommerce:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapAddCommerce:(id)sender {
//    ARFListCommerceViewController *listCommerceVC = [[ARFListCommerceViewController alloc] initWithStyle:UITableViewStylePlain];
//    UINavigationController *listNavVC = [[UINavigationController alloc] initWithRootViewController:listCommerceVC];
    
    ARFMapCommerceViewController *mapVC = [[ARFMapCommerceViewController alloc] init];
    UINavigationController *mapNavVC = [[UINavigationController alloc] initWithRootViewController:mapVC];
    

    
    [self presentViewController:mapNavVC animated:YES completion:nil];
    
}

@end
