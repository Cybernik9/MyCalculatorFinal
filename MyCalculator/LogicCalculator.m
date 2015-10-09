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

static NSString* firstNumber  = @"";
static NSString* secondNumber = @"";

static NSInteger operations;
static NSString* operationsSymbol;

static bool isClearAll = YES;
static bool isPoint;
static bool isCount;

#pragma mark - Simple Operation

- (void) inputNumber:(NSString*) number {
    
    if ([firstNumber isEqualToString:@"-0"]) {
        firstNumber = [firstNumber substringToIndex:firstNumber.length-1];
    } else if ([secondNumber isEqualToString:@"-0"]) {
        secondNumber = [secondNumber substringToIndex:secondNumber.length-1];
    }
    
    if (!operations) {
        firstNumber = [NSString stringWithFormat:@"%@%@",firstNumber,number];
        [self.logicCalculatorDelegate calculatorLogicDidChangeValue:firstNumber];
    } else {
        if (isCount) {
            secondNumber = [NSString stringWithFormat:@"%@",number];
        } else {
            secondNumber = [NSString stringWithFormat:@"%@%@",secondNumber,number];
        }
        [self.logicCalculatorDelegate calculatorLogicDidChangeValue:secondNumber];
    }
    
    isClearAll = isCount = NO;
    [self.logicCalculatorDelegate clearButtonDidChange:@"C"];
}

- (void) simpleOperation:(NSInteger) operation {
    
    if (operations && ![secondNumber isEqualToString:@""] && !isCount) {
        [self countTwoNumbers];
        secondNumber = @"";
    }
    
    operations = operation;
    
    switch (operation) {
        case OperationTypePlus:
            operationsSymbol = @"+";
            break;
        case OperationTypeMinus:
            operationsSymbol = @"-";
            break;
        case OperationTypeMultiply:
            operationsSymbol = @"x";
            break;
        case OperationTypeShare:
            operationsSymbol = @"/";
            break;
    }
    
    isPoint = NO;
}

- (void) countTwoNumbers {
    
    switch (operations) {
        case OperationTypePlus:
            firstNumber = [NSString stringWithFormat:@"%.20g", firstNumber.doubleValue + secondNumber.doubleValue];
            [self.logicCalculatorDelegate calculatorLogicDidChangeValue:firstNumber];
            break;
        case OperationTypeMinus:
            firstNumber = [NSString stringWithFormat:@"%.20g", firstNumber.doubleValue - secondNumber.doubleValue];
            [self.logicCalculatorDelegate calculatorLogicDidChangeValue:firstNumber];
            break;
        case OperationTypeMultiply:
            firstNumber = [NSString stringWithFormat:@"%.20g", firstNumber.doubleValue * secondNumber.doubleValue];
            [self.logicCalculatorDelegate calculatorLogicDidChangeValue:firstNumber];
            break;
        case OperationTypeShare:
            if ([secondNumber isEqualToString:@"0"]) {
                firstNumber = @"∞";
            } else {
                firstNumber = [NSString stringWithFormat:@"%.20g", firstNumber.doubleValue / secondNumber.doubleValue];
            }
            
            [self.logicCalculatorDelegate calculatorLogicDidChangeValue:firstNumber];
            break;
    }
    
    isCount = YES;
    [self.logicCalculatorDelegate clearButtonDidChange:@"AC"];
    [self.logicCalculatorDelegate calculatorLogicDidChangeValue:firstNumber];
}

- (void) makePoint {
    
    if (isPoint) {
        return;
    }
    
    if (operations) {
        if ([secondNumber isEqualToString:@""]) {
            secondNumber = @"0.";
        } else {
            secondNumber = [NSString stringWithFormat:@"%@.",secondNumber];
        }
        [self.logicCalculatorDelegate calculatorLogicDidChangeValue:secondNumber];
    } else {
        if ([firstNumber isEqualToString:@""]) {
            firstNumber = @"0.";
        } else {
            firstNumber = [NSString stringWithFormat:@"%@.",firstNumber];
        }
        [self.logicCalculatorDelegate calculatorLogicDidChangeValue:firstNumber];
    }
    
    isPoint = YES;
}

- (void) percentageNumber {
    
    [self printSimpleNumber:0.01];
}

- (void) plusMinusNumber {
    
    [self printSimpleNumber:-1];
}

- (void) clearAll {
    
    if (!operations || isCount) {
        firstNumber = @"";
        secondNumber = @"";
        operations = 0;
        [self.logicCalculatorDelegate calculatorLogicDidChangeValue:@"0"];
    } else {
        secondNumber = @"";
        [self.logicCalculatorDelegate calculatorLogicDidChangeValue:@"0"];
    }
    
    [self.logicCalculatorDelegate clearButtonDidChange:@"AC"];
}

#pragma mark - Additional operation

- (void) piNumber {
    
    [self printAdditionalNumber:M_PI];
}

- (void) eNumber {
    
    [self printAdditionalNumber:M_E];
}

- (void) additionalOperation:(NSInteger) operation {
    
    NSString* string = [[NSString alloc] init];
    
    if (operations) {
        string = secondNumber;
    } else {
        string = firstNumber;
    }
    
    switch (operation) {
        case OperationTypeRootTwo:
            string = [NSString stringWithFormat:@"%.20g",pow(string.doubleValue, 0.5)];
            break;
        case OperationTypeRootThee:
            string = [NSString stringWithFormat:@"%.20g",pow(string.doubleValue, 1./3)];
            break;
        case OperationTypeNumberToPowerTwo:
            string = [NSString stringWithFormat:@"%.20g",pow(string.doubleValue, 2)];
            break;
        case OperationTypeNumberToPowerThree:
            string = [NSString stringWithFormat:@"%.20g",pow(string.doubleValue, 1.3)];
            break;
        case OperationTypeTenToPowerNumber:
            string = [NSString stringWithFormat:@"%.20g",pow(10, string.doubleValue)];
            break;
        case OperationTypeNumberFactorial:
            string = [NSString stringWithFormat:@"%.20g", [self factorial:string.doubleValue]];
            break;
        case OperationTypeOneShareToNumber:
            string = [NSString stringWithFormat:@"%.20g",1 / string.doubleValue];
            break;
        case OperationTypeEToPowerNumber:
            string = [NSString stringWithFormat:@"%.20g",pow(M_E, string.doubleValue)];
            break;
    }
    
    if (operations) {
        secondNumber = string;
        [self.logicCalculatorDelegate calculatorLogicDidChangeValue:secondNumber];
    } else {
        firstNumber = string;
        [self.logicCalculatorDelegate calculatorLogicDidChangeValue:firstNumber];
    }
}

#pragma mark - Print Number

- (void) printSimpleNumber:(double) operationNumber {
    
    if (operations) {
        secondNumber = [NSString stringWithFormat:@"%.20g",secondNumber.doubleValue * operationNumber];
        [self.logicCalculatorDelegate calculatorLogicDidChangeValue:secondNumber];
    } else {
        firstNumber = [NSString stringWithFormat:@"%.20g",firstNumber.doubleValue * operationNumber];
        [self.logicCalculatorDelegate calculatorLogicDidChangeValue:firstNumber];
    }
}

- (void) printAdditionalNumber:(double) number {

    if (operations) {
        secondNumber = [NSString stringWithFormat:@"%.20g",number];
        [self.logicCalculatorDelegate calculatorLogicDidChangeValue:secondNumber];
    } else {
        firstNumber = [NSString stringWithFormat:@"%.20g",number];
        [self.logicCalculatorDelegate calculatorLogicDidChangeValue:firstNumber];
    }
}

#pragma mark - Factorial

- (float)factorial:(float)number1 {
    
    return tgammaf(++number1);
}

@end

