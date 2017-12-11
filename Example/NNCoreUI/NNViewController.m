//
//  NNViewController.m
//  NNCoreUI
//
//  Created by ws00801526 on 11/20/2017.
//  Copyright (c) 2017 ws00801526. All rights reserved.
//

#import "NNViewController.h"
#import <NNCoreUI/NNCoreUI.h>

@interface NNViewController ()

@property (weak, nonatomic) IBOutlet NNImageButton *leftButton;
@property (weak, nonatomic) IBOutlet NNImageButton *rightButton;
@property (weak, nonatomic) IBOutlet NNImageButton *topButton;
@property (weak, nonatomic) IBOutlet NNImageButton *bottomButton;

@end

@implementation NNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
        
//    [LEEAlert alert].config
//    .LeeTitle(@"标题")
//    .LeeContent(@"内容")
//    .LeeCancelAction(@"取消", ^{
//
//        // 取消点击事件Block
//    })
//    .LeeAction(@"确认", ^{
//
//        // 确认点击事件Block
//    })
//    .LeeShow(); // 设置完成后 别忘记调用Show来显示


    self.leftButton.imageSide = NNImageButtonImageSideLeft;
    [self updateButtonStyle:self.leftButton title:@"LeftButton"];

    self.rightButton.imageSide = NNImageButtonImageSideRight;
    [self updateButtonStyle:self.rightButton title:@"RightButton"];
   
    self.topButton.imageSide = NNImageButtonImageSideTop;
    [self updateButtonStyle:self.topButton title:@"TopButton"];
   
    self.bottomButton.contentInsets = UIEdgeInsetsMake(10, 20, 10, 20);
    self.bottomButton.imageSide = NNImageButtonImageSideBottom;
    [self updateButtonStyle:self.bottomButton title:@"BottomButton"];
    
    
    {   // 测试attrs title
        
        NNImageButton *imageButton = [[NNImageButton alloc] initWithFrame:CGRectMake(0, 100, 150, 50)];
        {
            NSMutableAttributedString *attrs = [[NSMutableAttributedString alloc] initWithString:@"AttrsWithEmoji  "];
            NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
            attachment.image = [UIImage imageNamed:@"success"];
            [attrs appendAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
            [imageButton setAttributedTitle:attrs.copy forState:UIControlStateNormal];
        }
        
        {
            NSMutableAttributedString *attrs = [[NSMutableAttributedString alloc] initWithString:@"AttrsWithEmoji  "];
            NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
            attachment.image = [UIImage imageNamed:@"failed"];
            [attrs appendAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
            [imageButton setAttributedTitle:attrs.copy forState:UIControlStateHighlighted];
        }
        [imageButton addTarget:self action:@selector(handleImageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:imageButton];
    }
}

- (void)updateButtonStyle:(NNImageButton *)button title:(NSString *)title {
    
    [button setTitle:title ? : @"Button" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"success"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:[NSString stringWithFormat:@"%@-highlight",title ? : @"Button"] forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:@"failed"] forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor magentaColor] forState:UIControlStateHighlighted];
}

- (void)handleImageButtonAction:(NNImageButton *)button {
    NNLogD(@"touch up inside :%@", button);
    [self performSegueWithIdentifier:@"alertDemo" sender:self];

//    __weak typeof(self) wSelf = self;
//    [NNAlert alert].title(@"开启AlertDemo").addAction(^(NNAlertAction *action) {
//        action.text = @"开始吧";
//        action.dismissAlertWhenTriggered = YES;
//        action.highlightText = @"Go";
//        action.handler = ^(NNAlertAction *action2) {
//            __strong typeof(wSelf) self = wSelf;
//            [self performSegueWithIdentifier:@"alertDemo" sender:self];
//        };
//    }).defaultAction(@"开始", ^(NNAlertAction *action) {
//        __strong typeof(wSelf) self = wSelf;
//        [self performSegueWithIdentifier:@"alertDemo" sender:self];
//    }).cancelAction(@"再等等", ^(NNAlertAction * action) {
//        NNLogD(@"还不想看demo");
//    }).show();
    
//    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 200)];
//    customView.backgroundColor = [UIColor blueColor];
//    [NNAlert alert].cancelAction(@"取消", ^(NNAlertAction *cancelAction) {
//        NNLogD(@"i need cancel");
//    }).defaultAction(@"改变下高度", ^(NNAlertAction *cancelAction) {
//        customView.frame = CGRectMake(0, 0, 200, 100);
//    }).customView(customView).title(@"测试标题").content(@"测试内容").show();
}

@end
