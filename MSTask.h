//
//  MSTask.h
//  Overdue Task List
//
//  Created by Miguel Serrano on 25/05/14.
//  Copyright (c) 2014 Miguel Serrano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSTask : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSDate *date;
@property (nonatomic) BOOL completion;

- (id)initWithData: (NSDictionary *)data;

@end
