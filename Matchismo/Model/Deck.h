//
//  Deck.h
//  Matchismo
//
//  Created by Sam Fisher on 9/18/15.
//  Copyright (c) 2015 Sam Fisher Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"


@interface Deck : NSObject

- (void) addCard:(Card *)card atTop:(BOOL)atTop;
- (void) addCard:(Card *)card;
- (Card *)drawRandomCard;

@end
