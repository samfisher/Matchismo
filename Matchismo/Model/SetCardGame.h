//
//  SetCardGame.h
//  Matchismo
//
//  Created by Sam Fisher on 9/25/15.
//  Copyright © 2015 Sam Fisher Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "SetCard.h"
#import "CardMatchingGame.h"

@interface SetCardGame : CardMatchingGame

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck numberOfMatches:(NSUInteger)numberOfMatches;

- (SetCard *)cardAtIndex:(NSUInteger)index;


@end
