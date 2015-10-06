//
//  HistoryViewController.m
//  Matchismo
//
//  Created by Sam Fisher on 9/28/15.
//  Copyright © 2015 Sam Fisher Apps. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()

@property (strong, nonatomic) IBOutlet UITextView *historyText;

@end

@implementation HistoryViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    BOOL hasAttributedStrings = NO;
    
    NSMutableAttributedString *attributedHistoryText = [[NSMutableAttributedString alloc] init];
    
    for (NSAttributedString *i in self.messages)
    {
        if ( [i isKindOfClass:[NSAttributedString class]])
        {
            [attributedHistoryText appendAttributedString:i];
            [attributedHistoryText appendAttributedString:
             [[NSAttributedString alloc] initWithString:@"\n"]];
            hasAttributedStrings = YES;
        }
    }
    if (hasAttributedStrings)
    {
        [self.historyText setAttributedText: attributedHistoryText];
    }
    else
    {
        self.historyText.text = [self.messages componentsJoinedByString:@"\n"];
    }
}

@end
