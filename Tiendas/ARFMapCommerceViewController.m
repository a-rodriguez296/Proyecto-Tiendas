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
#import "PureLayout.h"

@interface ARFMapCommerceViewController () <GMSMapViewDelegate>

@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mapViewBottomCnst;
@property (nonatomic, strong) ARFMarkerView *markerView;


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


#pragma mark GMSMapViewDelegate
-(BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker{
    @weakify(self);
    

    [UIView animateWithDuration:kAnimationConstant animations:^{
        @strongify(self);
        

        

        
//        //Mover el mapa hacia arriba
        [self.mapViewBottomCnst setConstant:66];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        @strongify(self);
        self.markerView =[[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ARFMarkerView class]) owner:self options:nil] firstObject];
        [self.view addSubview:self.markerView];
        
        NSDictionary *dict = @{@"markerView": self.markerView, @"mapView": self.mapView};
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[mapView]-[markerView]" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:dict]];
//
//        NSLog(@"%f", self.view.frame.size.height);
//        [self.markerView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.mapView];
//        [self.markerView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.mapView];
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

@end

