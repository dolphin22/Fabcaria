//
//  FridgeTableViewController.m
//  Fabcaria
//
//  Created by Thanh Pham on 7/4/15.
//  Copyright (c) 2015 Thanh Pham. All rights reserved.
//

#import "FridgeTableViewController.h"
#import "RecipeTableViewCell.h"
#import "Box.h"
#import "AFNetworking.h"
#define BOX_URL @"http://45.63.71.76:2204/api/boxes"

@interface FridgeTableViewController ()

@end

@implementation FridgeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    foodies = [[NSMutableArray alloc] init];
    
    NSURL *blogURL = [NSURL URLWithString:BOX_URL];
    NSData *jsonData = [NSData dataWithContentsOfURL:blogURL];
            
    NSDictionary *json = [ NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    for (NSDictionary *box in json) {
        Box *tempBox = [[Box alloc] init];
        tempBox.foodName = box[@"foodName"];
        tempBox.createDate = box[@"date"];
        tempBox.weight = box[@"weight"];
        tempBox.rfidTag = box[@"rfidTag"];
        [foodies addObject:tempBox];
    }
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    
    
    
    [refresh addTarget:self action:@selector(crunchNumbers)
     
      forControlEvents:UIControlEventValueChanged];
    
    
    
    self.refreshControl = refresh;

}

- (void)crunchNumbers

{
    [foodies removeAllObjects];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:BOX_URL
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSDictionary *json = responseObject;
             for (NSDictionary *box in json) {
                 Box *tempBox = [[Box alloc] init];
                 tempBox.foodName = box[@"foodName"];
                 tempBox.createDate = box[@"date"];
                 tempBox.weight = box[@"weight"];
                 tempBox.rfidTag = box[@"rfidTag"];
                 [foodies addObject:tempBox];
                 [self.tableView reloadData];
             }

         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
         }];
    //
    [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:2.5];
    
}

- (void)stopRefresh

{
    
    [self.refreshControl endRefreshing];
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [foodies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecipeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FoodCell" forIndexPath:indexPath];
    
     //Configure the cell...

    Box *tempBox = [foodies objectAtIndex:indexPath.row];
    
    
    NSURL *blogURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://45.63.71.76:2204/api/foods/%@",tempBox.foodName]];
    NSData *jsonData = [NSData dataWithContentsOfURL:blogURL];
    NSDictionary *json = [ NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    
    NSString *imageStr = [json objectForKey:@"image"];
    
    NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://45.63.71.76:2204/%@",imageStr]];
    NSMutableURLRequest *requestWithBodyParams = [NSMutableURLRequest requestWithURL:imageURL];
    NSData *imageData = [NSURLConnection sendSynchronousRequest:requestWithBodyParams returningResponse:nil error:nil];
    UIImage *image = [UIImage imageWithData:imageData];

    //NSString *pictureName = [NSString stringWithFormat:@"%@.png",tempBox.pictureURL];
    [cell.imageView setImage:[UIImage imageNamed:@"loading_image.png"]];
    [cell.textLabel setText:tempBox.foodName];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@ gam", tempBox.weight]];
    [cell.imageView setImage:image];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
//        klViewController *detailViewController = [segue destinationViewController];
//        
//        detailViewController.treeData = [self.ds objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        
    }
}





@end
