//
//  MSDetailTaskViewController.m
//  Overdue Task List
//
//  Created by Miguel Serrano on 25/05/14.
//  Copyright (c) 2014 Miguel Serrano. All rights reserved.
//

#import "MSDetailTaskViewController.h"

@interface MSDetailTaskViewController ()

@end

@implementation MSDetailTaskViewController

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
    
    [self updateDetailViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)detailEditButton:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"toEditTaskViewController" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([sender isKindOfClass:[MSDetailTaskViewController class]] && [segue.destinationViewController isKindOfClass:[MSEditTaskViewController class]]) {
        MSEditTaskViewController *nextVC = segue.destinationViewController;
        nextVC.task = self.task;
        nextVC.delegate = self;
    }
}

#pragma mark - MSEditTaskViewControllerDelegate

- (void)didSave {
    [self updateDetailViewController];
    [self.delegate saveEdit];
}

#pragma mark - Helper methods

- (void)updateDetailViewController {
    self.detailTask.text = self.task.title;
    self.detailDetail.text = self.task.description;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    self.detailDate.text = [formatter stringFromDate:self.task.date];
}

@end
