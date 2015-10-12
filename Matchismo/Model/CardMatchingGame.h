//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Sam Fisher on 9/18/15.
//  Copyright (c) 2015 Sam Fisher Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject


//main init
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
                  numberOfMatches:(NSUInteger)numberOfMatches;

- (id)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

@property (nonatomic) NSInteger score;

@property (nonatomic) NSUInteger numberOfCardsToMatch;

@property (nonatomic, strong) NSMutableArray *cards; //Array of all the cards on the screen
@property (nonatomic, strong) NSMutableArray *chosenCards; //Array of the cards chosen (up to 3 for 3 card match game)
@property (nonatomic, readwrite) NSMutableArray *messages;//match messages

@property (nonatomic, readonly) NSUInteger numberOfDealtCards;

@end
