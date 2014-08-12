//
//  ViewController.m
//  SampleCalender
//
//  Created by Eriko Ichinohe on 2014/07/31.
//  Copyright (c) 2014年 Eriko Ichinohe. All rights reserved.
//

#import "ViewController.h"
#import "Day.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Calendar";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self.navigationController navigationBar] setTranslucent:NO];
    
    [[self calendarView] registerDayCellClass:[Day class]];
    
    UIBarButtonItem *todayButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Today", nil)
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:[self calendarView]
                                                                   action:@selector(showCurrentMonth)];
    [self.navigationItem setRightBarButtonItem:todayButton];
}

- (void)calendarView:(RDVCalendarView *)calendarView configureDayCell:(RDVCalendarDayCell *)dayCell
             atIndex:(NSInteger)index {
    
    Day *exampleDayCell = (Day *)dayCell;
    
    //データが既にある所に青い小さな■を表示する
    NSString *DayStringForKey = [self setDayStringForKey:calendarView didSelectCellAtIndex:index];
    
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *DiaryDictionary = [userdefault objectForKey:@"DiaryDictionary"];
    
    NSMutableDictionary *setDictionary = [DiaryDictionary objectForKey:DayStringForKey];
    
    if (setDictionary != nil){
        [[exampleDayCell notificationView] setHidden:NO];
    }
    
//        if (index % 5 == 0) {
//            [[exampleDayCell notificationView] setHidden:NO];
//        }
}

- (void)calendarView:(RDVCalendarView *)calendarView didSelectCellAtIndex:(NSInteger)index{
    
    
    UIStoryboard *myStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NSLog(@"%@",myStoryboard);
    
    NSLog(@"index: %d",index+1);//日付の取得
    NSLog(@"month: %@",calendarView.month);//月の取得
    
    DayViewController *detailDay = [myStoryboard
                                    instantiateViewControllerWithIdentifier:@"DayViewController"];
    NSLog(@"%@",detailDay);
    
    //NSLog(@"%@",calendarView.monthLabel.text);
    
    detailDay.DayString = [self setDayString:calendarView didSelectCellAtIndex:index];
    
    detailDay.DayStringForKey = [self setDayStringForKey:calendarView didSelectCellAtIndex:index];
    
    [self presentViewController:detailDay animated:YES completion:nil];
    
}

-(NSString*)setDayStringForKey:(RDVCalendarView *)calendarView didSelectCellAtIndex:(NSInteger)index{
    
    NSInteger year = calendarView.month.year;
    NSInteger month = calendarView.month.month;
    NSInteger day = index+1;
    
    NSInteger modMonth = month % 12;
    NSInteger addYear = month /12;
    
    if (addYear > 0) {
        month = modMonth;
        year = year + addYear;
    }
    
    NSString *strReturn = [NSString stringWithFormat:@"%ld%ld%ld",(long)year,(long)month,(long)day];
    return strReturn;
}

-(NSString*)setDayString:(RDVCalendarView *)calendarView didSelectCellAtIndex:(NSInteger)index{
    
    NSInteger year = calendarView.month.year;
    NSInteger month = calendarView.month.month;
    NSInteger day = index+1;
    
    NSInteger modMonth = month % 12;
    NSInteger addYear = month /12;
    
    if (addYear > 0) {
        month = modMonth;
        year = year + addYear;
    }
    
    return [NSString stringWithFormat:@"%ld年%ld月%ld日",(long)year,(long)month,(long)day];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
