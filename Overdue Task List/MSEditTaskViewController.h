//
//  MSEditTaskViewController.h
//  Overdue Task List
//
//  Created by Miguel Serrano on 25/05/14.
//  Copyright (c) 2014 Miguel Serrano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSTask.h"

@protocol MSEditTaskViewControllerDelegate <NSObject>

- (void)didSave;

@end

@interface MSEditTaskViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) id <MSEditTaskViewControllerDelegate> delegate;

- (IBAction)editSaveButton:(UIBarButtonItem *)sender;

@property (strong, nonatomic) IBOutlet UITextField *editTextField;
@property (strong, nonatomic) IBOutlet UITextView *editTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *editDatePicker;

@property (strong, nonatomic) MSTask *task;

@end
