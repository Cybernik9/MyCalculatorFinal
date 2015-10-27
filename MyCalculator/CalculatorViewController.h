//
//  ViewController.h
//  MyCalculator
//
//  Created by Yurii Huber on 08.10.15.
//  Copyright (c) 2015 Yurii Huber. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculatorViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *mainScreenLable;
@property (weak, nonatomic) IBOutlet UIButton *clearButtonVertical;
@property (weak, nonatomic) IBOutlet UIButton *clearButtonHorizontal;

#pragma mark - Action simple operation

- (IBAction)actionPushNumber:(id)sender;
- (IBAction)actionPushSimpleOperation:(id)sender;
- (IBAction)actionPushEqual:(id)sender;
- (IBAction)actionPushPercentage:(id)sender;
- (IBAction)actionPushPlusMinus:(id)sender;
- (IBAction)actionPushPoint:(id)sender;
- (IBAction)actionPushAC:(id)sender;

#pragma mark - Action additional operation

- (IBAction)actionPushAdditionalOperation:(id)sender;
- (IBAction)actionPuchPI:(id)sender;
- (IBAction)actionPushE:(id)sender;

@end

