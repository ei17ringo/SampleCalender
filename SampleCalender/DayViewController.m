//
//  DayViewController.m
//  SampleCalender
//
//  Created by Eriko Ichinohe on 2014/08/12.
//  Copyright (c) 2014年 Eriko Ichinohe. All rights reserved.
//

#import "DayViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface DayViewController ()

@end

@implementation DayViewController
NSString * const DefaultStr = @"スケボー記録をご記入下さい。";

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
    //初期値の設定
    
    self.diaryDate.text = self.DayString;
    
    
    _library = [[ALAssetsLibrary alloc]init];
    
    self.Diary.delegate = self;
    self.btnClose.alpha = 0.0;
    
    self.Diary.text = DefaultStr;
}

- (void)viewWillAppear:(BOOL)animated{
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *DiaryDictionary = [userdefault objectForKey:@"DiaryDictionary"];
    
    NSString *setKey = self.DayStringForKey;
    
    NSMutableDictionary *setDictionary = [DiaryDictionary objectForKey:setKey];
    
    if (setDictionary == nil){
        self.myLabel.text = @"YES";
        
        _ratingFlag1 = NO;
        _ratingFlag2 = NO;
        _ratingFlag3 = NO;
        _assetsUrl = @"noimage.gif";
        
    }else{
        self.myLabel.text = [setDictionary objectForKey:@"RainyStatus"];
        if ([self.myLabel.text isEqualToString:@"YES"]) {
            self.mySwitch.on = YES;
        }else{
            self.mySwitch.on = NO;
        }
        
        _assetsUrl = [setDictionary objectForKey:@"ImageURL"];
        
        self.Diary.text = [setDictionary objectForKey:@"Diary"];
        
        NSString *rating = [setDictionary objectForKey:@"Rating"];
        
        NSInteger intRating = [rating intValue];
        
        _ratingFlag1 = NO;
        _ratingFlag2 = NO;
        _ratingFlag3 = NO;
        
        switch (intRating) {
            case 1:
                _ratingFlag1 = [self setRating:self.rating1 tag:10 ratingFlag:_ratingFlag1];
                
                break;
            case 2:
                _ratingFlag1 = [self setRating:self.rating1 tag:10 ratingFlag:_ratingFlag1];
                _ratingFlag2 = [self setRating:self.rating2 tag:20 ratingFlag:_ratingFlag2];
                
                break;
            case 3:
                _ratingFlag1 = [self setRating:self.rating1 tag:10 ratingFlag:_ratingFlag1];
                _ratingFlag2 = [self setRating:self.rating2 tag:20 ratingFlag:_ratingFlag2];
                _ratingFlag3 = [self setRating:self.rating3 tag:30 ratingFlag:_ratingFlag3];
                
                break;
                
            default:
                break;
        }
        
    }
    
    
    
    
    [self showPhoto:_assetsUrl];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//画面がタッチされたときのメソッド
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //タッチされたオブジェクトを取得
    UITouch *touch = [[event allTouches] anyObject];
    
    //タッチされたオブジェクトとImageViewのtag値が一致した場合、カメラロールを実装、呼出
    if(touch.view.tag == self.sukeboPic.tag)
    {
        NSLog(@"Touch");
        
        //実装用カメラロールをカプセル化、呼び出し
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }
    
    
    //星１を変化させる
    _ratingFlag1 = [self setRating:self.rating1 tag:touch.view.tag ratingFlag:_ratingFlag1];
    
    //星２を変化させる
    _ratingFlag2 = [self setRating:self.rating2 tag:touch.view.tag ratingFlag:_ratingFlag2];
    
    //星３を変化させる
    _ratingFlag3 = [self setRating:self.rating3 tag:touch.view.tag ratingFlag:_ratingFlag3];
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSLog(@"didFinishPickingMediaWithInfo");
    
    UIImage *fromCamera = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self.sukeboPic setImage:fromCamera];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    //カメラライブラリから選んだ写真のURLを取得。
    _assetsUrl = [(NSURL *)[info objectForKey:@"UIImagePickerControllerReferenceURL"] absoluteString];
    
    
    
}

- (BOOL)setRating:(UIImageView *)ratingImage tag:(NSInteger)tag ratingFlag:(BOOL)ratingflag{
    
    NSString static *NoRatingImg = @"norating.png";
    NSString static *RatingImg = @"rating.png";
    
    BOOL returnValue;
    
    if (tag == ratingImage.tag) {
        if (ratingflag) {
            ratingImage.image = [UIImage imageNamed:NoRatingImg];
            returnValue = NO;
            
        }else{
            ratingImage.image = [UIImage imageNamed:RatingImg];
            returnValue = YES;
            
        }
    }
    
    return returnValue;
}

//assetsから取得した画像を表示する
-(void)showPhoto:(NSString *)url
{
    //URLからALAssetを取得
    [_library assetForURL:[NSURL URLWithString:url]
              resultBlock:^(ALAsset *asset) {
                  
                  //画像があればYES、無ければNOを返す
                  if(asset){
                      NSLog(@"データがあります");
                      //ALAssetRepresentationクラスのインスタンスの作成
                      ALAssetRepresentation *assetRepresentation = [asset defaultRepresentation];
                      
                      //ALAssetRepresentationを使用して、フルスクリーン用の画像をUIImageに変換
                      //fullScreenImageで元画像と同じ解像度の写真を取得する。
                      UIImage *fullscreenImage = [UIImage imageWithCGImage:[assetRepresentation fullScreenImage]];
                      
                      UIImage *thumbnailImage = [UIImage imageWithCGImage:[asset thumbnail]];
                      
                      //self.sukeboPic.image = fullscreenImage; //イメージをセット
                      self.sukeboPic.image = thumbnailImage; //イメージをセット
                  }else{
                      NSLog(@"データがありません");
                  }
                  
              } failureBlock: nil];
}

//日記編集時に全体を上げる
-(BOOL)textViewShouldBeginEditing:(UITextView*)textView{
    
    NSLog(@"textViewShouldBeginEditing");
    
    NSInteger up_y = -200;
    
    if ([self.Diary.text isEqualToString:DefaultStr]) {
        self.Diary.text = @"";
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    self.upperView.frame = CGRectMake(10, up_y, self.upperView.bounds.size.width, self.upperView.bounds.size.height);
    
    self.btnClose.frame = CGRectMake(260, 10, self.btnClose.bounds.size.width, self.btnClose.bounds.size.height);
    
    self.Diary.frame = CGRectMake(15, 45, self.Diary.bounds.size.width, self.Diary.bounds.size.height);
    
    self.btnClose.alpha = 1.0;
    
    [UIView commitAnimations];
    return true;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//戻るボタン
- (IBAction)myButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)closeKeyboard:(id)sender {
    self.btnClose.alpha = 0.0;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    self.upperView.frame = CGRectMake(10, 20, self.upperView.bounds.size.width, self.upperView.bounds.size.height);
    
    self.btnClose.frame = CGRectMake(260, 215, self.btnClose.bounds.size.width, self.btnClose.bounds.size.height);
    
    self.Diary.frame = CGRectMake(15, 225, self.Diary.bounds.size.width, self.Diary.bounds.size.height);
    [UIView commitAnimations];
    
    [self.Diary resignFirstResponder];

}

- (IBAction)changeSwitch:(id)sender {
    if (self.mySwitch.on == YES) {
        self.myLabel.text = @"YES";
    }else{
        self.myLabel.text = @"NO";
        
    }

}

- (IBAction)saveDiary:(id)sender {
    NSMutableDictionary *DiaryDictionary=[[NSMutableDictionary alloc] init];
    
    //UserDefaultから読み出し
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    DiaryDictionary = [[defaults objectForKey:@"DiaryDictionary"] mutableCopy];
    
    if (DiaryDictionary == nil){
        DiaryDictionary=[[NSMutableDictionary alloc] init];
    }
    
    NSInteger rating = 0;
    
    //評価数を数える
    if (_ratingFlag1) {
        rating++;
    }
    
    if (_ratingFlag2) {
        rating++;
    }
    
    if (_ratingFlag3) {
        rating++;
    }
    
    BOOL rainystatus = self.mySwitch.on;
    NSString *rainystatusString = @"YES";
    
    if (rainystatus){
        rainystatusString = @"YES";
    }else{
        rainystatusString = @"NO";
    }
    
    
    NSString *diary = self.Diary.text;
    NSString *ratingString = [NSString stringWithFormat:@"%ld",(long)rating];
    
    if(_assetsUrl == nil){
        _assetsUrl = @"noimage.gif";
    }
    
    NSMutableDictionary *sukeboData =[NSMutableDictionary dictionaryWithObjectsAndKeys:ratingString,@"Rating",rainystatusString,@"RainyStatus",diary,@"Diary", _assetsUrl,@"ImageURL",nil];
    
    
    //日付ごとにデータを保存するためにキーをyyyymmddに設定
    [DiaryDictionary setObject:sukeboData forKey:self.DayStringForKey];
    
    [defaults setObject:DiaryDictionary forKey:@"DiaryDictionary"];
    [defaults synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];

}
@end
