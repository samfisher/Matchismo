//
//  SetCard.m
//  Matchismo
//
//  Created by Sam Fisher on 9/25/15.
//  Copyright © 2015 Sam Fisher Apps. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

#pragma mark - match
- (int)match:(NSArray *)otherCards
{
    if ([otherCards count] !=2)
    {
        return 0;
    }
    
    SetCard *a = self;
    SetCard *b = [otherCards objectAtIndex:0];
    SetCard *c = [otherCards objectAtIndex:1];
    BOOL potentialSet = YES;
    
    if(potentialSet && [a.shape isEqualToString:b.shape] && [a.shape isEqualToString:c.shape])
    {
        potentialSet = YES;
    }
    else if (potentialSet && ![a.shape isEqualToString:b.shape] && ![a.shape isEqualToString:c.shape] && ![b.shape isEqualToString:c.shape])
    {
        potentialSet = YES;
    }
    else
    {
        return 0;
    }
    
    if (potentialSet && [a.shading isEqualToString:b.shading] && [a.shading isEqualToString:c.shading])
    {
        potentialSet = YES;
    }
    else if (potentialSet && ![a.shading isEqualToString:b.shading] && ![a.shading isEqualToString:c.shading] && ![b.shading isEqualToString:c.shading])
    {
        potentialSet = YES;
    }
    else
    {
        return 0;
    }
    
    if(potentialSet && [a.color isEqualToString:b.color] && [a.color isEqualToString:c.color])
    {
        potentialSet = YES;
    }
    else if (potentialSet && ![a.color isEqualToString:b.color] && ![a.color isEqualToString:c.color] && ![b.color isEqualToString:c.color])
    {
        potentialSet = YES;
    }
    else
    {
        return 0;
    }
    
    if (potentialSet && (a.number == b.number) && (a.number ==c.number))
    {
        potentialSet = YES;
    }
    else if (potentialSet && !(a.number == b.number) && !(a.number == c.number) && !(b.number == c.number))
    {
        potentialSet = YES;
    }
    else
    {
        return 0;
    }
    
    
    return potentialSet;
}

#pragma mark - Contents (TOAttributedString)

- (NSAttributedString *)newContents //TOAttributedString Method
{
    
    //Shape
    NSMutableAttributedString *x = [[NSMutableAttributedString alloc ] initWithString:self.shape];
    
    //Number
    for (int i = 1;i < self.number; i++)
    {
        [x appendAttributedString:[[NSAttributedString alloc ] initWithString:self.shape]];
    }
    
    //Shading
    float shade = 1;
    
    if ([self.shading isEqualToString:@"shaded"])
    {
        shade = 0.5;
    }
    else if ([self.shading isEqualToString:@"open"])
    {
        shade = 0;
    }
    
    //Color
    if ([self.color isEqualToString:@"red"])
    {
        [x addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:1 green:0 blue:0 alpha:shade] range:NSMakeRange(0, (self.number) )];
        [x addAttribute:NSStrokeColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, (self.number) )];
    }
    else if ([self.color isEqualToString:@"green"])
    {
        [x addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0 green:1 blue:0 alpha:shade] range:NSMakeRange(0, (self.number) )];
        [x addAttribute:NSStrokeColorAttributeName value:[UIColor greenColor] range:NSMakeRange(0, (self.number) )];
    }
    else if ([self.color isEqualToString:@"purple"])
    {
        [x addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.4 green:0 blue:0.4 alpha:shade] range:NSMakeRange(0, (self.number) )];
        [x addAttribute:NSStrokeColorAttributeName value:[UIColor purpleColor] range:NSMakeRange(0, (self.number) )];
    }
    
    [x addAttribute:NSStrokeWidthAttributeName value:@-15 range:NSMakeRange(0, (self.number) )];
    

    return [x copy];
}

#pragma mark - Shapes

+ (NSArray *)validShapes
{
    return @[@"oval",@"squiggle",@"diamond"];
}

@synthesize shape = _shape;

- (void)setShape:(NSString *)shape
{
    if ([[SetCard validShapes] containsObject:shape])
    {
        _shape = shape;
    }
}

- (NSString *)shape
{
    return _shape ? _shape : @"?";
}

#pragma mark - Shading

+ (NSArray *)validShading
{
    return @[@"solid",@"shaded",@"open"];
}

@synthesize shading = _shading;

- (void)setShading:(NSString *)shading
{
    if ([[SetCard validShading] containsObject:shading])
    {
        _shading = shading;
    }
}

- (NSString *)shading
{
    return _shading ? _shading : @"?";
}

#pragma mark - Colors

+ (NSArray *)validColors
{
    return @[@"red",@"green",@"purple"];
}

@synthesize color = _color;

- (void)setColor:(NSString *)color
{
    if ([[SetCard validColors] containsObject:color])
    {
        _color = color;
    }
}

- (NSString *)color
{
    return _color ? _color : @"?";
}

#pragma mark - Number

+ (NSArray *)validNumbers
{
    return @[@"?",@"1",@"2",@"3"];
}

+ (NSUInteger)maxNumber
{
    return [[self validNumbers] count]-1;
}

- (void)setNumber:(NSUInteger)number
{
    if (number <= [SetCard maxNumber])
    {
        _number = number;
    }
}


@end
