//
//  DayViewController.h
//  SampleCalender
//
//  Created by Eriko Ichinohe on 2014/08/12.
//  Copyright (c) 2014年 Eriko Ichinohe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface DayViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextViewDelegate>{
    NSString *_assetsUrl;    //assetsUrlを格納するインスタンス
    ALAssetsLibrary *_library;  //ALAssetsLibraryのインスタンス
    BOOL _ratingFlag1;
    BOOL _ratingFlag2;
    BOOL _ratingFlag3;
}


//カレンダーから移動してきた際にyyyy年mm月dd日で日付を保存するためのプロパティ
@property (strong,nonatomic)NSString *DayString;

//カレンダーから移動してきた際にyyyymmddで日付を保存するためのプロパティ
@property (strong,nonatomic)NSString *DayStringForKey;

@property (weak, nonatomic) IBOutlet UILabel *myLabel;
@property (weak, nonatomic) IBOutlet UISwitch *mySwitch;
@property (weak, nonatomic) IBOutlet UIButton *myButton;
@property (weak, nonatomic) IBOutlet UIImageView *sukeboPic;
@property (weak, nonatomic) IBOutlet UILabel *diaryDate;
@property (weak, nonatomic) IBOutlet UITextView *Diary;
@property (weak, nonatomic) IBOutlet UIImageView *rating1;
@property (weak, nonatomic) IBOutlet UIImageView *rating2;
@property (weak, nonatomic) IBOutlet UIImageView *rating3;
@property (weak, nonatomic) IBOutlet UIView *upperView;
@property (weak, nonatomic) IBOutlet UIButton *btnClose;
- (IBAction)myButton:(id)sender;
- (IBAction)closeKeyboard:(id)sender;
- (IBAction)changeSwitch:(id)sender;
- (IBAction)saveDiary:(id)sender;

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;

-(BOOL)textViewShouldBeginEditing:
(UITextView*)textView;

@end
