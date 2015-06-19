//
//  ARFCommerceTableViewController.m
//  Tiendas
//
//  Created by Alejandro Rodriguez on 6/19/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFCommerceTableViewController.h"
#import "ARFConstants.h"
#import "Commerce.h"
#import "ARFCommerceCell.h"

#import "Parse/Parse.h"
#import <ParseUI/ParseUI.h>
#import "MTLParseAdapter.h"


@interface ARFCommerceTableViewController()

@end

static NSString *const cellIdentifier = @"Cell";

@implementation ARFCommerceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ARFCommerceCell class]) bundle:nil] forCellReuseIdentifier:cellIdentifier];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom the table
        
        // The className to query on
        self.parseClassName = kCommerceClassName;
        
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
        
        [self setTitle:@"Lista de Tiendas"];
    }
    return self;
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

/*
 // Override to customize what kind of query to perform on the class. The default is to query for
 // all objects ordered by createdAt descending.
 - (PFQuery *)queryForTable {
 PFQuery *query = [PFQuery queryWithClassName:self.className];
 
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
 */


// Override to customize the look of a cell representing an object. The default is to display
// a UITableViewCellStyleDefault style cell with the label being the textKey in the object,
// and the imageView being the imageKey in the object.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    
    ARFCommerceCell *cell = (ARFCommerceCell *) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    PFObject *pfObject = [self objectAtIndexPath:indexPath];
    
    NSError *error;
    Commerce *commerce = (Commerce *)[MTLParseAdapter modelOfClass:Commerce.class fromParseObject:pfObject error:&error];
    [cell configureCellWithCommerce:commerce];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 84;
}

@end
