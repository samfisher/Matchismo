//
//  PlayingCardGame.m
//  Matchismo
//
//  Created by Sam Fisher on 9/28/15.
//  Copyright © 2015 Sam Fisher Apps. All rights reserved.
//

#import "PlayingCardGame.h"

@interface PlayingCardGame()
//@property (nonatomic, readwrite) NSInteger score;
@end

@implementation PlayingCardGame

-(instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck:(Deck *)deck
                 numberOfMatches:(NSUInteger)numberOfMatches
{
    self = [super init];
    self.numberOfCardsToMatch = numberOfMatches;
    self.deck = deck;
    if (self)
    {
        for(int i = 0; i< count; i++)
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
//#define MISMATCH_PENALTY 2
//static const int MISMATCH_PENALTY = 2;
//static const int MATCH_BONUS = 4;
//static const int COST_TO_CHOOSE = 1;
//static const int TRIPPLE_BONUS = 10;

- (id)chooseCardAtIndex:(NSUInteger)index
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSInteger MATCH_BONUS = [prefs integerForKey:@"matchBonus"];
    NSInteger TRIPPLE_BONUS = [prefs integerForKey:@"tripleBonus"];
    NSInteger MISMATCH_PENALTY = [prefs integerForKey:@"mismatch"];
    NSInteger COST_TO_CHOOSE = [prefs integerForKey:@"costToChoose"];
    
    if(MATCH_BONUS == 0)
        MATCH_BONUS = 1;
    
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched)
    {
        if (card.isChosen) //Flip card back over
        {
            card.chosen = NO;
            [self.chosenCards removeObject:card];
            self.score -= COST_TO_CHOOSE;
        }
        else if([self.chosenCards count]+1 == self.numberOfCardsToMatch)
        {
            //all cards have been chosen, will now check for matches
            NSMutableArray *messages = [[NSMutableArray alloc] init];
            int points = [card match:self.chosenCards];
            points *= MATCH_BONUS;
            
            if (points && self.numberOfCardsToMatch > 2) //tripple card match
            {
                [messages addObject: [NSString stringWithFormat:@"Matched %@ & %@ for %d points",card,[self.chosenCards componentsJoinedByString:@" & "], points]];
                [messages addObject:[NSString stringWithFormat:@"%lu Card Match! %ld point Bonus!", (unsigned long)self.numberOfCardsToMatch, (long)TRIPPLE_BONUS]];
                points += TRIPPLE_BONUS;
            }
            
            else // Checking for a 2 card match
            {
                points = 0;
                
                Card *currentCard = card;
                NSMutableArray *otherCards = [self.chosenCards mutableCopy];
                while([otherCards count] >= 1)
                {
                    for (Card *otherCard in otherCards)//takes each card and checks it against the others
                    {
                        int matchPoints = [currentCard match:@[otherCard]];
                        if (matchPoints)
                        {
                            [messages addObject:[NSString stringWithFormat:@"Matched %@ & %@ for %d points.", currentCard, otherCard, matchPoints]];
                            matchPoints *= MATCH_BONUS;
                            points += matchPoints;
                        }
                    }
                    currentCard = [otherCards objectAtIndex:0];
                    [otherCards removeObjectAtIndex:0];
                }
            }
            
            if (points) //Match!!
            {
                //All 3 cards are now matched (disabled) and left faceside up
                card.chosen = YES;
                card.matched = YES;
                for(Card *chosenCard in self.chosenCards)
                {
                    chosenCard.matched = YES;
                }
                [self.chosenCards removeAllObjects];
                self.score += points;
                return [messages componentsJoinedByString:@"\n"];
            }
            else //No match
            {
                //Cards are fliped back over
                NSString *message = [NSString stringWithFormat:@"%@ & %@ Don't Match",card,[self.chosenCards componentsJoinedByString:@" & "]];
                card.chosen = NO;
                for(Card *chosenCard in self.chosenCards)
                {
                    chosenCard.chosen = NO;
                }
                [self.chosenCards removeAllObjects];
                self.score -= MISMATCH_PENALTY;
                return message;
            }
            
        }
        else //User still has more cards to choose
        {
            card.chosen = YES;
            [self.chosenCards addObject:card];
        }
        
    }
    return nil;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end
