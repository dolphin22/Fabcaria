//
//  Recipe.h
//  Fabcaria
//
//  Created by Thanh Pham on 7/5/15.
//  Copyright (c) 2015 Thanh Pham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recipe : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSMutableArray *ingredients;
@end

