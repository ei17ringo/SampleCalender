//
//  Day.m
//  カレンダーアプリ
//
//  Created by YorifumiKawai on 2014/05/15.
//  Copyright (c) 2014年 YorifumiKawai. All rights reserved.
//

#import "Day.h"

@implementation Day

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        _notificationView = [[UIView alloc] init];
        [_notificationView setBackgroundColor:[UIColor blueColor]];
        [_notificationView setHidden:YES];
        [self.contentView addSubview:_notificationView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize viewSize = self.contentView.frame.size;
    
    [[self notificationView] setFrame:CGRectMake(viewSize.width - 10, 0, 10, 10)];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    [[self notificationView] setHidden:YES];
}

@end
