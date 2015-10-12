//
//  SetCardView.h
//  Matchismo
//
//  Created by Sam Fisher on 10/12/15.
//  Copyright © 2015 Sam Fisher Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetCardView : UIView


@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *shape;
@property (strong, nonatomic) NSString *shading;
@property (nonatomic) NSUInteger number;

@property (nonatomic) BOOL chosen;

@end
