//
//  ViewController.m
//  MyCalculator
//
//  Created by Yurii Huber on 08.10.15.
//  Copyright (c) 2015 Yurii Huber. All rights reserved.
//

#import "CalculatorViewController.h"
#import "LogicCalculator.h"

@interface CalculatorViewController () <LogicCalculatorProtocol>

@property LogicCalculator* logicCalculator;

@end

@implementation CalculatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.logicCalculator = [[LogicCalculator alloc] init];
    self.logicCalculator.logicCalculatorDelegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



#pragma mark - Action

- (IBAction)actionPushNumber:(id)sender {
    [self.logicCalculator inputDigit:[NSString stringWithFormat:@"%ld", (long)[sender tag]]];
}

- (IBAction)actionPushSimpleOperation:(id)sender {
    [self.logicCalculator simpleOperation:[sender tag]];
}

- (IBAction)actionPushEqual:(id)sender {
    [self.logicCalculator countTwoNumbers];
}

- (IBAction)actionPushPercentage:(id)sender {
    [self.logicCalculator percentageNumber];
}

- (IBAction)actionPushPlusMinus:(id)sender {
    [self.logicCalculator plusMinusNumber];
}

- (IBAction)actionPushPoint:(id)sender {
    [self.logicCalculator makePoint];
}

- (IBAction)actionPushAC:(id)sender {
    [self.logicCalculator clearAll];
}

- (IBAction)actionPushAdditionalOperation:(id)sender {
    [self.logicCalculator additionalOperation:[sender tag]];
}

- (IBAction)actionPuchPI:(id)sender {
    [self.logicCalculator PiNumber];
}

- (IBAction)actionPushE:(id)sender {
    [self.logicCalculator eNumber];
}




#pragma mark - LogicCalculatorProtocol

- (void) calculatorLogicDidChangeValue:(NSString*) value {
    self.mainScreenLable.text = value;
}

- (void) clearButtonDidChange:(NSString*) value {
    self.clearButton.highlighted = YES;
    [self.clearButton setTitle:value forState:UIControlStateHighlighted];
    //[self.clearButton setTitle:@"KKK" forState:UIControlStateHighlighted]
    
}

@end
