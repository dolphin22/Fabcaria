//
//  RecipeDetailViewController.h
//  Fabcaria
//
//  Created by Thanh Pham on 7/4/15.
//  Copyright (c) 2015 Thanh Pham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

@interface RecipeDetailViewController : UIViewController <UITableViewDelegate ,UITableViewDataSource>
@property (nonatomic, retain) Recipe *recipe;
@property (strong, nonatomic) IBOutlet UIImageView *recipeImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImage *image;
@end
