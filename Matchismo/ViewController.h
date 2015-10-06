//
//  ViewController.h
//  Matchismo
//
//  Created by Sam Fisher on 9/18/15.
//  Copyright (c) 2015 Sam Fisher Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"
#import "HistoryViewController.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) Deck *deck;
@property (nonatomic, strong) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (nonatomic, strong) NSMutableArray *messages;
@property (strong, nonatomic) IBOutlet UILabel *matchResults;

@property (nonatomic) NSUInteger numberOfMatches;

@end

