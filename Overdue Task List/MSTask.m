//
//  MSTask.m
//  Overdue Task List
//
//  Created by Miguel Serrano on 25/05/14.
//  Copyright (c) 2014 Miguel Serrano. All rights reserved.
//

#import "MSTask.h"

@implementation MSTask

- (id)init {
    self = [self initWithData:nil];
    return self;
}

- (id)initWithData: (NSDictionary *)data {
    self = [super init];
    
    if(self) {
        self.title = data[TASK_TITLE];
        self.description = data[TASK_DESC];
        self.date = data[TASK_DATE];
        self.completion = [data[TASK_COMP] boolValue];
    }
    return self;
}

@end
