//
//  ARFMapCommerceViewController.m
//  Tiendas
//
//  Created by Alejandro Rodriguez on 6/19/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFMapCommerceViewController.h"
#import "ARFConstants.h"
#import "ARFCommerce.h"
#import "ARFMarkerView.h"

#import <GoogleMaps/GoogleMaps.h>
#import <Parse/Parse.h>
#import "MTLParseAdapter.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ARFMapCommerceViewController () <GMSMapViewDelegate>

@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mapViewBottomCnst;


@end

@implementation ARFMapCommerceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Mapas";
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:4.596274
                                                            longitude:-74.077785
                                                                 zoom:6];
    [self.mapView setCamera:camera];
    self.mapView.myLocationEnabled = YES;
    [self.mapView setDelegate:self];

    
    
    
    @weakify(self);
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        if (!error) {
            @strongify(self);
            [self.mapView moveCamera:[GMSCameraUpdate setCamera:[GMSCameraPosition cameraWithLatitude:geoPoint.latitude longitude:geoPoint.longitude zoom:17.0]]];
            
            
            PFQuery *query = [PFQuery queryWithClassName:kCommerceClassName];
            // Interested in locations near user.
            [query whereKey:@"location" nearGeoPoint:geoPoint withinKilometers:20.0];
            // Limit what could be a lot of points.
            query.limit = 10;
            // Final list of objects
            
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
                
                
                for (PFObject *currentObject in objects) {
                    
                    PFGeoPoint *objectLocation = [currentObject objectForKey:@"location"];
                    
                    NSError *error;
                    ARFCommerce *commerceObject = (ARFCommerce *)[MTLParseAdapter modelOfClass:ARFCommerce.class fromParseObject:currentObject error:&error];
                    
                    
                    GMSMarker *marker = [[GMSMarker alloc] init];
                    marker.position = CLLocationCoordinate2DMake(objectLocation.latitude, objectLocation.longitude);
                    
                    @strongify(self);
                    marker.map = self.mapView;
                    [marker setUserData:commerceObject];
                }
            }];
        }
    }];
    
}

-(BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker{
    @weakify(self);
    [UIView animateWithDuration:kAnimationConstant animations:^{
        @strongify(self);
        [self.mapViewBottomCnst setConstant:50];
        [self.view layoutIfNeeded];
    }];
    
    
    
    return YES;
}

-(void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate{
    if (self.mapViewBottomCnst>0) {
        
        @weakify(self);
        [UIView animateWithDuration:kAnimationConstant animations:^{
            @strongify(self);
            [self.mapViewBottomCnst setConstant:0];
            [self.view layoutIfNeeded];
        }];
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

