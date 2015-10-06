//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Sam Fisher on 9/25/15.
//  Copyright © 2015 Sam Fisher Apps. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        for (NSString *shape in [SetCard validShapes])
        {
            for (NSString *shading in [SetCard validShading])
            {
                for (NSString *color in [SetCard validColors])
                {
                    for (NSUInteger number = 1; number <= [SetCard maxNumber]; number++)
                    {
                        SetCard *card = [[SetCard alloc] init];
                        card.shape = shape;
                        card.shading = shading;
                        card.color = color;
                        card.number = number;
                        [self addCard:card];
                    }
                }
            }
        }
        
    }
    return self;
}


@end
