//
//  FoodTableViewCell.h
//  Fabcaria
//
//  Created by Thanh Pham on 7/4/15.
//  Copyright (c) 2015 Thanh Pham. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *weight;
@property (weak, nonatomic) IBOutlet UILabel *time;
@end
