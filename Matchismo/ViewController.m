//
//  ViewController.m
//  Matchismo
//
//  Created by Sam Fisher on 9/18/15.
//  Copyright (c) 2015 Sam Fisher Apps. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()

//@property (strong, nonatomic) IBOutlet UISwitch *threeCardGame;
@property (weak, nonatomic) IBOutlet UIButton *addCardsButton;

@end

@implementation ViewController

#pragma mark - Lifecycle
// -----------------------------------------------------------------------------

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self updateUI];
}

#pragma mark - add cards button


- (IBAction)touchAddCardsButton:(UIButton *)sender
{
    for (int i = 0; i < 3; i++)
    {
        [self.game drawNewCard];
    }
    
    if (self.game.deckIsEmpty)
    {
        sender.enabled = NO;
        sender.alpha = 0.5;
    }
    [self updateUI];
}

#pragma mark - New Grid stuff
- (NSMutableArray *)cardViews
{
    if (!_cardViews) _cardViews = [NSMutableArray arrayWithCapacity:self.numberOfStartingCards];
    return _cardViews;
}

- (Grid *)grid
{
    if (!_grid)
    {
        _grid = [[Grid alloc] init];
        _grid.cellAspectRatio = self.maxCardSize.width / self.maxCardSize.height;
        _grid.minimumNumberOfCells = self.numberOfStartingCards;
        _grid.maxCellWidth = self.maxCardSize.width;
        _grid.maxCellHeight = self.maxCardSize.height;
        _grid.size = self.gridView.frame.size;
    }
    return _grid;
}

#define CARDSPACINGINPERCENT 0.08
- (void)updateUI
{
    for (NSUInteger cardIndex = 0;
         cardIndex < self.game.numberOfDealtCards;
         cardIndex++)
    {
        Card *card = [self.game cardAtIndex:cardIndex];
        
        NSUInteger viewIndex = [self.cardViews indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop)
                                {
                                    if ([obj isKindOfClass:[UIView class]])
                                    {
                                        if (((UIView *)obj).tag == cardIndex)
                                        {
                                            return YES;
                                        }
                                    }
                                    return NO;
                                    
                                }];
        
        UIView *cardView;
        if (viewIndex == NSNotFound)
        {
            if (!card.matched)
            {
                cardView = [self createViewForCard:card];
                cardView.tag = cardIndex;
                
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(touchCard:)];
                [cardView addGestureRecognizer:tap];
                
                [self.cardViews addObject:cardView];
                viewIndex = [self.cardViews indexOfObject:cardView];
                [self.gridView addSubview:cardView];
            }
            
        }
        else
        {
            cardView = self.cardViews[viewIndex];
            if (!card.matched)
            {
                [self updateView:cardView forCard:card];
            }
            else
            {
                [cardView removeFromSuperview];
                [self.cardViews removeObject:cardView];
            }
        }
        
        
        self.grid.minimumNumberOfCells = [self.cardViews count];
        
        for (NSUInteger viewIndex = 0; viewIndex < [self.cardViews count]; viewIndex++)
        {
            CGRect frame = [self.grid frameOfCellAtRow:viewIndex / self.grid.columnCount
                                              inColumn:viewIndex % self.grid.columnCount];
            frame = CGRectInset(frame, frame.size.width * CARDSPACINGINPERCENT, frame.size.height * CARDSPACINGINPERCENT);
            ((UIView *)self.cardViews[viewIndex]).frame = frame;
        }
        
    }
    
    
    
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
}

- (UIView *)createViewForCard:(Card *)card
{
    UIView *view = [[UIView alloc] init];
    [self updateView:view forCard:card];
    return view;
}

- (void)updateView:(UIView *)view forCard:(Card *)card
{
    view.backgroundColor = [UIColor blueColor];
}

- (void)touchCard:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateEnded)
    {
        [self.game chooseCardAtIndex:gesture.view.tag];
        [self updateUI];
    }
}


- (void)startNewGame
{
    self.cardViews = nil;
    self.game = [self createGame];
    [self updateUI];
}

- (Deck *)createDeck //abstract
{
    return nil;
}

- (NSUInteger)numberOfMatches
{
    return 2;
}

- (CardMatchingGame *)game
{
    if (! _game)
    {
        _game = [self createGame];
    }
    return _game;
}

- (CardMatchingGame *)createGame
{
    return nil; //abstract
}

- (IBAction)touchResetButton:(UIButton *)sender
{
    self.cardViews = nil;
    [self startNewGame];
}







@end
