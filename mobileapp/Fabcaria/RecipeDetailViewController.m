//
//  RecipeDetailViewController.m
//  Fabcaria
//
//  Created by Thanh Pham on 7/4/15.
//  Copyright (c) 2015 Thanh Pham. All rights reserved.
//

#import "RecipeDetailViewController.h"
#import "RecipeDetailCellTableViewCell.h"
#import "AFNetworking.h"

@interface RecipeDetailViewController ()

@end

@implementation RecipeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if(self.image != nil) {
        [self.recipeImageView setImage:self.image];
    }
    [self.nameLabel setText:self.recipe.name];

}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView  numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecipeDetailCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecipeDetailCell" forIndexPath:indexPath];
    
    // Configure the cell...
    if(indexPath.row == 0){
        [cell.textLabel setText:@"Tomatos"];
        [cell.detailTextLabel setText:@"200 gram"];
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
    }
    else if (indexPath.row == 1)
    {
        [cell.textLabel setText:@"Potato"];
        [cell.detailTextLabel setText:@"400 gram"];
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
    }
    
    return cell;
}

@end
