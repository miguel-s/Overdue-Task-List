//
//  MSAddTaskViewController.h
//  Overdue Task List
//
//  Created by Miguel Serrano on 25/05/14.
//  Copyright (c) 2014 Miguel Serrano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSTask.h"
#import "MSEditTaskViewController.h"

@protocol MSAddTaskViewControllerDelegate <NSObject>

- (void)didCancel;
- (void)didAddTask: (MSTask *)task;

@end

@interface MSAddTaskViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) id <MSAddTaskViewControllerDelegate> delegate;

- (IBAction)addTaskAddTask:(UIButton *)sender;
- (IBAction)addTaskCancel:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UITextField *addTaskTextField;
@property (strong, nonatomic) IBOutlet UITextView *addTaskTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *addTaskDatePicker;

@end
