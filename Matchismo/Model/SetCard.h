//
//  SetCard.h
//  Matchismo
//
//  Created by Sam Fisher on 9/25/15.
//  Copyright © 2015 Sam Fisher Apps. All rights reserved.
//

#import "Card.h"
#import <UIKit/UIKit.h>

@interface SetCard : Card

@property (strong, nonatomic) NSString *shape;
@property (strong, nonatomic) NSString *shading;
@property (strong, nonatomic) NSString *color;
@property (nonatomic) NSUInteger number; //make string-compare

- (int)match:(NSArray *)otherCards;
- (NSAttributedString *)newContents;

+ (NSUInteger)maxNumber;

+ (NSArray *)validShapes;
+ (NSArray *)validShading;
+ (NSArray *)validColors;
+ (NSArray *)validNumbers;
@end



//match each characteristic, all or nothing, loop through each characteristic
