//
//  MSViewController.m
//  Overdue Task List
//
//  Created by Miguel Serrano on 25/05/14.
//  Copyright (c) 2014 Miguel Serrano. All rights reserved.
//

#import "MSViewController.h"

@interface MSViewController ()

@end

@implementation MSViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSArray *savedTasks = [[NSUserDefaults standardUserDefaults] arrayForKey:SAVED_TASKS];
    
    for(NSDictionary *propertyList in savedTasks) {
        [self.taskObjects addObject:[self propertyListAsTaskObject:propertyList]];
    }
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)viewControllerReorder:(UIBarButtonItem *)sender {
    if(self.tableView.editing == NO) {
        self.tableView.editing = YES;
    }
    else {
        self.tableView.editing = NO;
    }
}

- (IBAction)viewControllerAddTask:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"toAddTaskViewController" sender:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.taskObjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"taskCell" forIndexPath:indexPath];
    
    // Configure the cell...
    MSTask *task = self.taskObjects[indexPath.row];
    cell.textLabel.text = task.title;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    cell.detailTextLabel.text = [formatter stringFromDate:task.date];
    
    if(task.completion == YES) {
        cell.backgroundColor = [UIColor greenColor];
    }
    else if([self isDateGreaterThanDate:[NSDate date] and:task.date]) {
        cell.backgroundColor = [UIColor redColor];
    }
    else {
        cell.backgroundColor = [UIColor yellowColor];
    }
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.taskObjects removeObjectAtIndex:indexPath.row];
        
        NSMutableArray *savedTasks = [[NSMutableArray alloc] init];
        if([savedTasks count] != 0) {
            for(MSTask *task in savedTasks) {
                [savedTasks addObject:[self taskObjectAsAPropertyList:task]];
            }
        }
        [[NSUserDefaults standardUserDefaults] setObject:savedTasks forKey:SAVED_TASKS];
        [[NSUserDefaults standardUserDefaults] synchronize];

        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MSTask *task = self.taskObjects[indexPath.row];
    [self updateCompletionOfTask:task forIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"toDetailTaskViewController" sender:indexPath];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    MSTask *task = self.taskObjects[sourceIndexPath.row];
    [self.taskObjects removeObjectAtIndex:sourceIndexPath.row];
    [self.taskObjects insertObject:task atIndex:destinationIndexPath.row];
    [self saveTasks];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([sender isKindOfClass:[MSViewController class]] && [segue.destinationViewController isKindOfClass:[MSAddTaskViewController class]]) {
        MSAddTaskViewController *nextVC = segue.destinationViewController;
        nextVC.delegate = self;
    }
    if([sender isKindOfClass:[NSIndexPath class]] && [segue.destinationViewController isKindOfClass:[MSDetailTaskViewController class]]) {
        MSDetailTaskViewController *nextVC = segue.destinationViewController;
        nextVC.delegate = self;
        
        NSIndexPath *path = sender;
        nextVC.task = self.taskObjects[path.row];
    }
}

#pragma mark - MSAddTaskViewControllerDelegate

- (void)didCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didAddTask:(MSTask *)task {
    [self.taskObjects addObject:task];
    
    NSMutableArray *savedTasks = [[[NSUserDefaults standardUserDefaults] arrayForKey:SAVED_TASKS] mutableCopy];
    
    if(!savedTasks) {
        savedTasks = [[NSMutableArray alloc] init];
    }
    
    [savedTasks addObject:[self taskObjectAsAPropertyList:task]];
    
    [[NSUserDefaults standardUserDefaults] setObject:savedTasks forKey:SAVED_TASKS];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.tableView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - MSDetailTaskViewController

- (void)saveEdit {
    [self saveTasks];
}

#pragma mark - Helper methods

- (NSDictionary *)taskObjectAsAPropertyList:(MSTask *)taskObject {
    NSDictionary *taskAsDictionary = @{TASK_TITLE : taskObject.title, TASK_DESC : taskObject.description, TASK_DATE : taskObject.date, TASK_COMP : [NSNumber numberWithBool:taskObject.completion]};
    return taskAsDictionary;
}

- (MSTask *)propertyListAsTaskObject:(NSDictionary *)propertyList {
    MSTask *task = [[MSTask alloc] initWithData:propertyList];
    return task;
}

- (BOOL)isDateGreaterThanDate:(NSDate*)date and:(NSDate*)toDate {
    int firstDate = [date timeIntervalSince1970];
    int secondDate = [toDate timeIntervalSince1970];
    return firstDate > secondDate;
}

- (void)updateCompletionOfTask:(MSTask *)task forIndexPath:(NSIndexPath *)indexPath {
    if(task.completion == NO) {
        task.completion = YES;
    }
    else {
        task.completion = NO;
    }
    
    NSMutableArray *savedTasks = [[[NSUserDefaults standardUserDefaults] arrayForKey:SAVED_TASKS] mutableCopy];
    [savedTasks removeObjectAtIndex:indexPath.row];
    [savedTasks insertObject:[self taskObjectAsAPropertyList:task] atIndex:indexPath.row];

    NSMutableArray *savedTasksAsPropertyList = [[NSMutableArray alloc] init];
    for(NSDictionary *taskAsPropertyList in savedTasks) {
        [savedTasksAsPropertyList addObject:taskAsPropertyList];
    }

    [[NSUserDefaults standardUserDefaults] setObject:savedTasksAsPropertyList forKey:SAVED_TASKS];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.tableView reloadData];
}

- (void)saveTasks {
    NSMutableArray *savedTasksAsPropertyList = [[NSMutableArray alloc] init];
    for(MSTask *task in self.taskObjects) {
        [savedTasksAsPropertyList addObject:[self taskObjectAsAPropertyList:task]];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:savedTasksAsPropertyList forKey:SAVED_TASKS];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.tableView reloadData];
}

#pragma mark - Lazy instantiations

- (NSMutableArray *)taskObjects {
    if(!_taskObjects) {
        _taskObjects = [[NSMutableArray alloc] init];
    }
    return _taskObjects;
}

@end
