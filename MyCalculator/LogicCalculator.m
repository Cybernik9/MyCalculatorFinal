//
//  LogicCalculator.m
//  MyCalculator
//
//  Created by Yurii Huber on 08.10.15.
//  Copyright (c) 2015 Yurii Huber. All rights reserved.
//

#import "LogicCalculator.h"

@implementation LogicCalculator

typedef NS_ENUM(NSUInteger, OperationType) {
    
    OperationTypePlus   = 11,
    OperationTypeMinus,
    OperationTypeMultiply,
    OperationTypeShare,
    
    OperationTypeRootTwo = 21,
    OperationTypeRootThee,
    OperationTypeNumberToPowerTwo,
    OperationTypeNumberToPowerThree,
    OperationTypeTenToPowerNumber,
    OperationTypeNumberFactorial,
    OperationTypeOneShareToNumber,
    OperationTypeEToPowerNumber
};

static bool isClearAll = YES;
static bool isPoint;
static bool isCount;

#pragma mark - Simple operation

- (void)inputNumber:(NSString*)number {
    
    [self removeExcessSymbol];
    
    if (!self.operations) {
        
        self.firstNumber = [NSString stringWithFormat:@"%@%@", self.firstNumber, number];
        [self.logicCalculatorDelegate calculatorLogicDidChangeValue:self.firstNumber];
    }
    else {
        if (isCount) {
            
            self.secondNumber = [NSString stringWithFormat:@"%@", number];
        }
        else {
            
            self.secondNumber = [NSString stringWithFormat:@"%@%@", self.secondNumber, number];
        }
        
        [self.logicCalculatorDelegate calculatorLogicDidChangeValue:self.secondNumber];
    }
    
    isClearAll = isCount = NO;
    [self.logicCalculatorDelegate clearButtonDidChange:@"C"];
}

- (void)simpleOperation:(NSInteger) operation {
    
    if (self.operations && ![self.secondNumber isEqualToString:@""] && !isCount) {
        
        [self countTwoNumbers];
        self.secondNumber = @"";
    }
    
    self.operations = operation;
    
    isPoint = NO;
}

- (void)countTwoNumbers {
    
    switch (self.operations) {
            
        case OperationTypePlus:
            self.firstNumber = [NSString stringWithFormat:@"%.15g", self.firstNumber.doubleValue + self.secondNumber.doubleValue];
            [self.logicCalculatorDelegate calculatorLogicDidChangeValue:self.firstNumber];
            break;
            
        case OperationTypeMinus:
            self.firstNumber = [NSString stringWithFormat:@"%.15g", self.firstNumber.doubleValue - self.secondNumber.doubleValue];
            [self.logicCalculatorDelegate calculatorLogicDidChangeValue:self.firstNumber];
            break;
            
        case OperationTypeMultiply:
            self.firstNumber = [NSString stringWithFormat:@"%.15g", self.firstNumber.doubleValue * self.secondNumber.doubleValue];
            [self.logicCalculatorDelegate calculatorLogicDidChangeValue:self.firstNumber];
            break;
            
        case OperationTypeShare:
            if ([self.secondNumber isEqualToString:@"0"]) {
                
                self.firstNumber = @"∞";
            }
            else {
                
                self.firstNumber = [NSString stringWithFormat:@"%.15g", self.firstNumber.doubleValue / self.secondNumber.doubleValue];
            }
            
            [self.logicCalculatorDelegate calculatorLogicDidChangeValue:self.firstNumber];
            break;
    }
    
    isCount = YES;
    [self.logicCalculatorDelegate clearButtonDidChange:@"AC"];
    [self.logicCalculatorDelegate calculatorLogicDidChangeValue:self.firstNumber];
}

- (void)makePoint {
    
    if (isPoint) {
        return;
    }
    
    if (self.operations) {
        if ([self.secondNumber isEqualToString:@""]) {
            
            self.secondNumber = @"0.";
        }
        else {
            
            self.secondNumber = [NSString stringWithFormat:@"%@.", self.secondNumber];
        }
        
        [self.logicCalculatorDelegate calculatorLogicDidChangeValue:self.secondNumber];
    }
    else {
        if ([self.firstNumber isEqualToString:@""]) {
           
            self.firstNumber = @"0.";
        }
        else {
            
            self.firstNumber = [NSString stringWithFormat:@"%@.", self.firstNumber];
        }
        
        [self.logicCalculatorDelegate calculatorLogicDidChangeValue:self.firstNumber];
    }
    
    isPoint = YES;
}

- (void)percentageNumber {
    
    [self printSimpleNumber:0.01];
}

- (void)plusMinusNumber {
    
    [self printSimpleNumber:-1];
}

- (void)clearAll {
    
    if (!self.operations || isCount) {
        
        self.firstNumber = @"";
        self.secondNumber = @"";
        self.operations = 0;
        [self.logicCalculatorDelegate calculatorLogicDidChangeValue:@"0"];
    }
    else {
        
        self.secondNumber = @"";
        [self.logicCalculatorDelegate calculatorLogicDidChangeValue:@"0"];
    }
    
    [self.logicCalculatorDelegate clearButtonDidChange:@"AC"];
}

- (void)removeExcessSymbol {
    
    if (self.secondNumber == nil) {
        
        self.firstNumber = self.secondNumber = @"";
    }
    else if ([self.firstNumber isEqualToString:@"-0"]) {
        
        self.firstNumber = [self.firstNumber substringToIndex:self.firstNumber.length-1];
    }
    else if ([self.secondNumber isEqualToString:@"-0"]) {
        
        self.secondNumber = [self.secondNumber substringToIndex:self.secondNumber.length-1];
    }
    else if ([self.firstNumber isEqualToString:@"inf"]) {
        
        self.firstNumber = @"";
    }
    else if ([self.secondNumber isEqualToString:@"inf"]) {
        
        self.secondNumber = @"";
    }
    else if ([self.secondNumber isEqualToString:@"00"]) {
        
        self.secondNumber = [self.secondNumber substringToIndex:self.secondNumber.length-1];
    }
    else if ([self.firstNumber isEqualToString:@"00"]){
        
        self.firstNumber = [self.firstNumber substringToIndex:self.firstNumber.length-1];
    }
}

#pragma mark - Additional operation

- (void)piNumber {
    
    [self printAdditionalNumber:M_PI];
}

- (void)eNumber {
    
    [self printAdditionalNumber:M_E];
}

- (void)additionalOperation:(NSInteger)operation {
    
    NSString* string;
    
    if (self.operations && !isCount) {
        
        string = self.secondNumber;
    }
    else {
        
        string = self.firstNumber;
    }
    
    switch (operation) {
            
        case OperationTypeRootTwo:
            string = [NSString stringWithFormat:@"%.15g",pow(string.doubleValue, 1./2)];
            break;
            
        case OperationTypeRootThee:
            string = [NSString stringWithFormat:@"%.15g",pow(string.doubleValue, 1./3)];
            break;
            
        case OperationTypeNumberToPowerTwo:
            string = [NSString stringWithFormat:@"%.15g",pow(string.doubleValue, 2)];
            break;
            
        case OperationTypeNumberToPowerThree:
            string = [NSString stringWithFormat:@"%.15g",pow(string.doubleValue, 3)];
            break;
            
        case OperationTypeTenToPowerNumber:
            string = [NSString stringWithFormat:@"%.15g",pow(10, string.doubleValue)];
            break;
            
        case OperationTypeNumberFactorial:
            string = [NSString stringWithFormat:@"%.15g", [self factorial:string.doubleValue]];
            break;
            
        case OperationTypeOneShareToNumber:
            string = [NSString stringWithFormat:@"%.10g", 1.f / string.doubleValue];
            break;
            
        case OperationTypeEToPowerNumber:
            string = [NSString stringWithFormat:@"%.15g",pow(M_E, string.doubleValue)];
            break;
    }
    
    if (self.operations && !isCount) {
        
        self.secondNumber = string;
        [self.logicCalculatorDelegate calculatorLogicDidChangeValue:self.secondNumber];
    }
    else {
        
        self.firstNumber = string;
        [self.logicCalculatorDelegate calculatorLogicDidChangeValue:self.firstNumber];
    }
}

#pragma mark - Print number

- (void)printSimpleNumber:(double) operationNumber {

    if (self.operations && !isCount) {
        
        self.secondNumber = [NSString stringWithFormat:@"%.10g",self.secondNumber.doubleValue * operationNumber];
        [self.logicCalculatorDelegate calculatorLogicDidChangeValue:self.secondNumber];
    }
    else {
        
        self.firstNumber = [NSString stringWithFormat:@"%.10g",self.firstNumber.doubleValue * operationNumber];
        [self.logicCalculatorDelegate calculatorLogicDidChangeValue:self.firstNumber];
    }
}

- (void)printAdditionalNumber:(double) number {

    if (self.operations && !isCount) {
        
        self.secondNumber = [NSString stringWithFormat:@"%.20g",number];
        [self.logicCalculatorDelegate calculatorLogicDidChangeValue:self.secondNumber];
    }
    else {
        
        self.firstNumber = [NSString stringWithFormat:@"%.20g",number];
        [self.logicCalculatorDelegate calculatorLogicDidChangeValue:self.firstNumber];
    }
}

- (void)printChangeOrientation:(BOOL)isPortrait {
    
    if (isPortrait) {
        [self.logicCalculatorDelegate calculatorLogicDidChangeValue:[NSString stringWithFormat:@"%.10g", self.firstNumber.doubleValue]];
    } else {
        [self.logicCalculatorDelegate calculatorLogicDidChangeValue:[NSString stringWithFormat:@"%.20g", self.firstNumber.doubleValue]];
    }
}

#pragma mark - Factorial

- (float)factorial:(float)number1 {
    
    return tgammaf(++number1);
}

@end

