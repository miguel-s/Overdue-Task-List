//
//  MSAddTaskViewController.m
//  Overdue Task List
//
//  Created by Miguel Serrano on 25/05/14.
//  Copyright (c) 2014 Miguel Serrano. All rights reserved.
//

#import "MSAddTaskViewController.h"

@interface MSAddTaskViewController ()

@end

@implementation MSAddTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.addTaskTextField.delegate = self;
    self.addTaskTextView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
}
 */

- (IBAction)addTaskAddTask:(UIButton *)sender {
    [self.delegate didAddTask:[self createTask]];
}

- (IBAction)addTaskCancel:(UIButton *)sender {
    [self.delegate didCancel];
}

#pragma mark - Helper methods

- (MSTask *)createTask {
    MSTask *task = [[MSTask alloc] initWithData:@{TASK_TITLE : self.addTaskTextField.text, TASK_DESC : self.addTaskTextView.text, TASK_DATE : self.addTaskDatePicker.date, TASK_COMP : @NO}];
    return task;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    else {
        return YES;
    }
}

@end