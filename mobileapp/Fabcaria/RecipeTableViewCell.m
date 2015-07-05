//
//  FoodTableViewCell.m
//  Fabcaria
//
//  Created by Thanh Pham on 7/4/15.
//  Copyright (c) 2015 Thanh Pham. All rights reserved.
//

#import "RecipeTableViewCell.h"

@implementation RecipeTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
