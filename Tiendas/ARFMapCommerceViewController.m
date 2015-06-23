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

@interface ARFMapCommerceViewController () <GMSMapViewDelegate,ARFMarkerViewDelegate>

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
            query.cachePolicy = kPFCachePolicyCacheThenNetwork;
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


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cerrar" style:UIBarButtonItemStylePlain target:self action:@selector(didTapCloseView:)];
}

-(void) didTapCloseView:(id) sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark GMSMapViewDelegate
-(BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker{

    if (!self.markerView) {
        
        //Caso en el que no se ha pintado ningun marker
        [self createMarkerView];
        [self initializeMarkerWithCommerce:marker.userData];
        
        @weakify(self);
        [UIView animateWithDuration:kAnimationConstant animations:^{
            @strongify(self);
            
            //Mover el mapa hacia arriba
            [self.mapViewBottomCnst setConstant:66];
            [self.view layoutIfNeeded];
        }];
    }
    else{
        //Caso en el que hay pintado un marker
        [self initializeMarkerWithCommerce:marker.userData];
    }


    return YES;
}

-(void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate{
    if (self.mapViewBottomCnst>0) {
        
        @weakify(self);
        [UIView animateWithDuration:kAnimationConstant animations:^{
            @strongify(self);
            [self.mapViewBottomCnst setConstant:0];
            
            [self.view layoutIfNeeded];
        }completion:^(BOOL finished) {
            [self.markerView removeFromSuperview];
            self.markerView = nil;
        }];
    }

}

-(void) createMarkerView{
    //Inicialización parte gráfica
    self.markerView =[[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ARFMarkerView class]) owner:self options:nil] firstObject];
    [self.markerView setDelegate:self];
    [self.markerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view insertSubview:self.markerView belowSubview:self.mapView];
    NSDictionary *viewsDictionary = @{@"markerView":self.markerView, @"mapView": self.mapView};
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[mapView]-0-[markerView]-|" options:0 metrics:nil views:viewsDictionary];
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[markerView]-0-|" options:0 metrics:nil views:viewsDictionary];
    
    [self.view addConstraints:verticalConstraints];
    [self.view addConstraints:horizontalConstraints];
    
    [self.view layoutIfNeeded];
}


-(void) initializeMarkerWithCommerce:(ARFCommerce *) commerceObject{
    [self.markerView configureWithCommerce:commerceObject];
}

#pragma mark ARFMarkerViewDelegate
-(void)ARFMarkerView:(ARFMarkerView *)markerView didChangeSwitchState:(BOOL)state{
    
    ARFCommerce *commerce =markerView.commerce;
    
    PFInstallation * currentInstalation = [PFInstallation currentInstallation];
    if (state) {
        [currentInstalation addUniqueObject:commerce.commerceId forKey:kChannels];
    }
    else{
        [currentInstalation removeObject:commerce.commerceId forKey:kChannels];
    }
    [currentInstalation saveEventually:^(BOOL succeeded, NSError *error){
        if (!succeeded) {
            
        }
    }];
    
}
@end

