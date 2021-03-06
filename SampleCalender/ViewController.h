//
//  ViewController.h
//  SampleCalender
//
//  Created by Eriko Ichinohe on 2014/07/31.
//  Copyright (c) 2014年 Eriko Ichinohe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RDVCalendarViewController.h"
#import "DayViewController.h"

@interface ViewController : RDVCalendarViewController

@property (nonatomic, strong) RDVCalendarView *calendarView;

@property (nonatomic) BOOL clearSelectionViewWillAppear;

@end
