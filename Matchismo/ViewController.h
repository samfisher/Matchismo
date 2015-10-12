//
//  ViewController.h
//  Matchismo
//
//  Created by Sam Fisher on 9/18/15.
//  Copyright (c) 2015 Sam Fisher Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"
#import "Grid.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) Deck *deck;
@property (nonatomic, strong) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (nonatomic) NSUInteger numberOfMatches;

@property (weak, nonatomic) IBOutlet UIView *gridView;
@property (nonatomic) NSUInteger numberOfStartingCards;
@property (strong, nonatomic) NSMutableArray *cardViews;
@property (nonatomic) CGSize maxCardSize;
@property (strong, nonatomic) Grid *grid;

- (UIView *)createViewForCard:(Card *)card;
- (void)updateView:(UIView *)view forCard:(Card *)card;
- (void)touchCard:(UITapGestureRecognizer *)gesture;
- (void)startNewGame;
- (void)updateUI;

//TODO add arraw of views

@end

