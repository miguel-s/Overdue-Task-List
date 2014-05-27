//
//  MSViewController.h
//  Overdue Task List
//
//  Created by Miguel Serrano on 25/05/14.
//  Copyright (c) 2014 Miguel Serrano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSAddTaskViewController.h"
#import "MSTask.h"
#import "MSDetailTaskViewController.h"

@interface MSViewController : UITableViewController <MSAddTaskViewControllerDelegate, MSDetailTaskViewControllerDelegate>

- (IBAction)viewControllerReorder:(UIBarButtonItem *)sender;
- (IBAction)viewControllerAddTask:(UIBarButtonItem *)sender;

- (void)saveTasks;

@property (strong, nonatomic) NSMutableArray *taskObjects;

@end
