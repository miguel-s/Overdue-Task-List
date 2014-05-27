//
//  MSDetailTaskViewController.h
//  Overdue Task List
//
//  Created by Miguel Serrano on 25/05/14.
//  Copyright (c) 2014 Miguel Serrano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSTask.h"
#import "MSEditTaskViewController.h"

@protocol MSDetailTaskViewControllerDelegate <NSObject>

- (void)saveEdit;

@end

@interface MSDetailTaskViewController : UIViewController <MSEditTaskViewControllerDelegate>

- (IBAction)detailEditButton:(UIBarButtonItem *)sender;

@property (weak, nonatomic) id <MSDetailTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *detailTask;
@property (strong, nonatomic) IBOutlet UILabel *detailDate;
@property (strong, nonatomic) IBOutlet UILabel *detailDetail;

@property (strong, nonatomic) MSTask *task;

@end
