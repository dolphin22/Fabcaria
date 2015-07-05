//
//  RecipeTableViewController.m
//  Fabcaria
//
//  Created by Thanh Pham on 7/4/15.
//  Copyright (c) 2015 Thanh Pham. All rights reserved.
//

#import "RecipeTableViewController.h"
#import "RecipeTableViewCell.h"
#import "RecipeDetailViewController.h"
#import "Recipe.h"
#import "AFNetworking.h"
#import "Food.h"

#define RECIPE_URL @"http://45.63.71.76:2204/api/recipes"

@interface RecipeTableViewController ()
{
    UIImage *image;
}
@end

@implementation RecipeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    recipes = [[NSMutableArray alloc] init];
    
    NSURL *blogURL = [NSURL URLWithString:RECIPE_URL];
    NSData *jsonData = [NSData dataWithContentsOfURL:blogURL];
    
    NSDictionary *json = [ NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    for (NSDictionary *recipe in json) {
        Recipe *temprep = [[Recipe alloc] init];
        temprep.name = recipe[@"name"];
        temprep.image = recipe[@"image"];
        Food *food = [[Food alloc] init];
//        for (NSDictionary *ingredient in json[@"ingredients"]) {
//            food.name = ingredient[@"ingredients"][@"name"];
//            food.weight = ingredient[@"ingredients"][@"weight"];
//        }
        [recipes addObject:temprep];
    }
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
    return [recipes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecipeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecipeCell" forIndexPath:indexPath];
    
    // Configure the cell...
        Recipe *recipe = [recipes objectAtIndex:indexPath.row];
        [cell.title setText:recipe.name];
    
        NSURL *blogURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://45.63.71.76:2204/%@", recipe.image]];
        NSURLRequest *request = [NSURLRequest requestWithURL:blogURL];
        AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
        [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Response: %@", responseObject);
            image = responseObject;
            [cell.image setImage:responseObject];;
        
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Image error: %@", error);
        }];
        [requestOperation start];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 280;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [self performSegueWithIdentifier:@"showRecipeDetail" sender:self];
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showRecipeDetail"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
         RecipeDetailViewController *recipeViewController = segue.destinationViewController;
          Recipe *recipe = [recipes objectAtIndex:indexPath.row];
        recipeViewController.recipe = [[Recipe alloc] init];
        recipeViewController.recipe = recipe;
        recipeViewController.image = image;
//        destViewController.getString = [getArray objectAtIndex:indexPath.row];
    }
}

@end
