//
//  LogicCalculator.h
//  MyCalculator
//
//  Created by Yurii Huber on 08.10.15.
//  Copyright (c) 2015 Yurii Huber. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LogicCalculatorProtocol <NSObject>

- (void) calculatorLogicDidChangeValue:(NSString *)value;
- (void) clearButtonDidChange:(NSString*)value;

@end

@interface LogicCalculator : NSObject

@property (nonatomic, weak) NSObject <LogicCalculatorProtocol> *logicCalculatorDelegate;

@property (strong, nonatomic) NSString* firstNumber;
@property (strong, nonatomic) NSString* secondNumber;
@property (assign, nonatomic) NSInteger operations;

#pragma mark - Simple Operation

- (void) inputNumber:(NSString*)number;
- (void) simpleOperation:(NSInteger)operation;
- (void) countTwoNumbers;
- (void) plusMinusNumber;
- (void) makePoint;
- (void) percentageNumber;
- (void) clearAll;

#pragma mark - Additional Operation

- (void) piNumber;
- (void) eNumber;
- (void) additionalOperation:(NSInteger)operation;

#pragma mark - Print

- (void)printChangeOrientation:(BOOL)isPortrait;

@end
