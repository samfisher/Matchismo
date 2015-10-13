//
//  SetCardGame.m
//  Matchismo
//
//  Created by Sam Fisher on 9/25/15.
//  Copyright © 2015 Sam Fisher Apps. All rights reserved.
//

#import "SetCardGame.h"

@interface SetCardGame()

@end

@implementation SetCardGame

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
                  numberOfMatches:(NSUInteger)numberOfMatches
{
    self = [super init];
    self.numberOfCardsToMatch = numberOfMatches;
    self.deck = deck;
    if (self)
    {
        for (int i = 0; i < count; i++)
        {
            Card *card = deck.drawRandomCard;
            if(card)
            {
                self.cards[i] = card;
            }
            else
            {
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (NSAttributedString *)chooseCardAtIndex:(NSUInteger)index
{
    SetCard *card = [self cardAtIndex:index];
    
    if (card.isChosen)
    {
        card.chosen = NO;
        [self.chosenCards removeObject:card];
    }
    else if ([self.chosenCards count]+1 == self.numberOfCardsToMatch)
    {
        //all cards have been chosen, will now check for matches
        NSMutableAttributedString *matchMessage = [[NSMutableAttributedString alloc] init];
        [matchMessage appendAttributedString:[card newContents]];
        
        for (SetCard *chosenCard in self.chosenCards)
        {
            [matchMessage appendAttributedString:
             [[NSAttributedString alloc] initWithString:@" & " attributes:nil ]];
            
            [matchMessage appendAttributedString:
             [chosenCard newContents]];
        }
        
        if ([card match:self.chosenCards])
        {
            //SET!!
            self.score += 10;
            [matchMessage appendAttributedString:[[NSAttributedString alloc ]initWithString:@" are a set! 10 Points!" attributes:nil]];
            
            
            card.matched = YES;
            for (SetCard *chosenCard in self.chosenCards)
            {
                chosenCard.matched = YES;
            }
            
        }
        else
        {
            self.score -= 5;
            [matchMessage appendAttributedString:[[NSAttributedString alloc ]initWithString:@" are not a set. -5 Points" attributes:nil]];
        }
        
        card.chosen = NO;
        for (Card *chosenCard in self.chosenCards)
        {
            chosenCard.chosen = NO;
        }
        
        [self.chosenCards removeAllObjects];
        return [matchMessage copy];
        
    }
    else
    {
        [self.chosenCards addObject:card];
        card.chosen = YES;
    }
    
    return [[NSAttributedString alloc] initWithString:@""];
    
}

- (SetCard *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}




@end
