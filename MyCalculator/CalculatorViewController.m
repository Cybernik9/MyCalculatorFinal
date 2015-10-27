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

static CGFloat mainScreen;

#pragma mark - Standard method

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

- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        
        mainScreen = self.mainScreenLable.text.doubleValue;
        self.mainScreenLable.text = [NSString stringWithFormat:@"%.10g", self.mainScreenLable.text.doubleValue];
    }
    else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
             toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        
        self.mainScreenLable.text = [NSString stringWithFormat:@"%.15g", mainScreen];
    }
}

#pragma mark - Action simple operation

- (IBAction)actionPushNumber:(id)sender {
    
    [self.logicCalculator inputNumber:[NSString stringWithFormat:@"%ld", (long)[sender tag]]];
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

#pragma mark - Action additional operation

- (IBAction)actionPushAdditionalOperation:(id)sender {
    
    [self.logicCalculator additionalOperation:[sender tag]];
}

- (IBAction)actionPuchPI:(id)sender {
    
    [self.logicCalculator piNumber];
}

- (IBAction)actionPushE:(id)sender {
    
    [self.logicCalculator eNumber];
}

#pragma mark - LogicCalculatorProtocol

- (void) calculatorLogicDidChangeValue:(NSString*)value {
    
    self.mainScreenLable.text = value;
}

- (void) clearButtonDidChange:(NSString*)value {

    [self.clearButtonVertical setTitle:value forState:UIControlStateNormal];
    [self.clearButtonHorizontal setTitle:value forState:UIControlStateNormal];

}

@end
