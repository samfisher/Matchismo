//
//  PlayingCard.m
//  Matchismo
//
//  Created by Sam Fisher on 9/18/15.
//  Copyright (c) 2015 Sam Fisher Apps. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int)match:(NSArray *)otherCards
{
    if ([otherCards count] == 0)
    {
        return 0;
    }
    int score = 4;
    for (id card in otherCards)
    {
        if ([card isKindOfClass:[PlayingCard class]])
        {
            PlayingCard *playingCard = (PlayingCard *)card;
            if (playingCard.rank != self.rank)
            {
                score = 0;
                break;
            }
        }
    }
    if (score > 0)
    {
        return score;
    }
    score = 1;
    for (id card in otherCards)
    {
        if ([card isKindOfClass:[PlayingCard class]])
        {
            PlayingCard *playingCard = (PlayingCard *)card;
            if (playingCard.suit != self.suit)
            {
                score = 0;
                break;
            }
        }
    }
    return score;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@%@", [[[self class] rankStrings] objectAtIndex:self.rank], self.suit];
}

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

+ (NSArray *)validSuits
{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit])
    {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank
{
    return [[self rankStrings] count]-1;
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank])
    {
        _rank = rank;
    }
}

@end
