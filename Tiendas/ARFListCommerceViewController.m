//
//  ARFListCommerceViewController.m
//  Tiendas
//
//  Created by Alejandro Rodriguez on 6/22/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARFListCommerceViewController.h"
#import "ARFConstants.h"
#import "ARFCommerce.h"

#import "MTLParseAdapter.h"
#import "Parse/Parse.h"

static NSString *const cellIdentifier = @"Cell";

@implementation ARFListCommerceViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom the table
        
        // The className to query on
        [self setParseClassName:kCommerceClassName];
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = kCommerceName;
        
        // Uncomment the following line to specify the key of a PFFile on the PFObject to display in the imageView of the default cell style
        // self.imageKey = @"image";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 25;
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Lista Tiendas"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ARFCommerceCell class]) bundle:nil] forCellReuseIdentifier:cellIdentifier];
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - PFQueryTableViewController

- (void)objectsWillLoad {
    [super objectsWillLoad];
    
    // This method is called before a PFQuery is fired to get more objects
}

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    
    // This method is called every time objects are loaded from Parse via the PFQuery
}

 // Override to customize what kind of query to perform on the class. The default is to query for
 // all objects ordered by createdAt descending.
 - (PFQuery *)queryForTable {
     PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
     
     // If Pull To Refresh is enabled, query against the network by default.
     if (self.pullToRefreshEnabled) {
         query.cachePolicy = kPFCachePolicyNetworkOnly;
     }
     
     // If no objects are loaded in memory, we look to the cache first to fill the table
     // and then subsequently do a query against the network.
     if (self.objects.count == 0) {
         query.cachePolicy = kPFCachePolicyCacheThenNetwork;
     }
     
     [query orderByDescending:@"createdAt"];
     
     return query;
 }
 


 // Override to customize the look of a cell representing an object. The default is to display
 // a UITableViewCellStyleDefault style cell with the label being the textKey in the object,
 // and the imageView being the imageKey in the object.
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
 
     ARFCommerceCell *cell = (ARFCommerceCell *) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
     [cell setDelegate:self];
     [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
     PFObject *pfObject = [self objectAtIndexPath:indexPath];
     
     NSError *error;
     ARFCommerce *commerce = (ARFCommerce *)[MTLParseAdapter modelOfClass:ARFCommerce.class fromParseObject:pfObject error:&error];
     [cell configureCellWithCommerce:commerce];
     
     return cell;
 }
 

/*
 // Override if you need to change the ordering of objects in the table.
 - (PFObject *)objectAtIndex:(NSIndexPath *)indexPath {
 return [self.objects objectAtIndex:indexPath.row];
 }
 */

/*
 // Override to customize the look of the cell that allows the user to load the next page of objects.
 // The default implementation is a UITableViewCellStyleDefault cell with simple labels.
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForNextPageAtIndexPath:(NSIndexPath *)indexPath {
 static NSString *CellIdentifier = @"NextPage";
 
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
 
 if (cell == nil) {
 cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
 }
 
 cell.selectionStyle = UITableViewCellSelectionStyleNone;
 cell.textLabel.text = @"Load more...";
 
 return cell;
 }
 */

#pragma mark - UITableViewDataSource

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 84;
}

-(void)ARFCommerceCell:(ARFCommerceCell *)cell didChangeSwitchState:(BOOL)state{
    
    NSIndexPath *currentIndexPath = [self.tableView indexPathForCell:cell];
    PFObject *pfObject = [self objectAtIndexPath:currentIndexPath];
    NSError *error;
    ARFCommerce *commerce = (ARFCommerce *)[MTLParseAdapter modelOfClass:ARFCommerce.class fromParseObject:pfObject error:&error];
    
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
