//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Sam Fisher on 9/18/15.
//  Copyright (c) 2015 Sam Fisher Apps. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

//@property (nonatomic, readwrite) NSInteger score;

@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards)
    {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (NSMutableArray *)chosenCards
{
    if (!_chosenCards)
    {
        _chosenCards = [[NSMutableArray alloc] init];
    }
    return _chosenCards;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck:(Deck *)deck
                 numberOfMatches:(NSUInteger)numberOfMatches
{
    return nil;
}

- (id)chooseCardAtIndex:(NSUInteger)index
{
    return nil;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return nil;
}


@end
