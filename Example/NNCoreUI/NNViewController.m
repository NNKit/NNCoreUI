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

@property (strong, nonatomic) NNImageButton *imageButton;
@property (weak, nonatomic) IBOutlet NNImageButton *leftButton;
@property (weak, nonatomic) IBOutlet NNImageButton *rightButton;
@property (weak, nonatomic) IBOutlet NNImageButton *topButton;
@property (weak, nonatomic) IBOutlet NNImageButton *bottomButton;


@end

@implementation NNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.imageButton = [[NNImageButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    self.imageButton.backgroundColor = [UIColor redColor];
    [self.imageButton setTitle:@"测试" forState:UIControlStateNormal];
    [self.imageButton setImage:[UIImage imageNamed:@"success"] forState:UIControlStateNormal];
    [self.imageButton setTitle:@"测试1" forState:UIControlStateHighlighted];
    [self.imageButton setImage:[UIImage imageNamed:@"failed"] forState:UIControlStateHighlighted];
    self.imageButton.imageSide = NNImageButtonImageSideBottom;
    [self.view addSubview:self.imageButton];

    self.leftButton.imageSide = NNImageButtonImageSideLeft;
    [self updateButtonStyle:self.leftButton title:@"LeftButton"];

    self.rightButton.imageSide = NNImageButtonImageSideRight;
    [self updateButtonStyle:self.rightButton title:@"RightButton"];
   
    self.topButton.imageSide = NNImageButtonImageSideTop;
    [self updateButtonStyle:self.topButton title:@"TopButton"];
   
    self.bottomButton.imageSide = NNImageButtonImageSideBottom;
    [self updateButtonStyle:self.bottomButton title:@"BottomButton"];
}

- (void)updateButtonStyle:(NNImageButton *)button title:(NSString *)title {
    
    [button setTitle:title ? : @"Button" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"success"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:[NSString stringWithFormat:@"%@-highlight",title ? : @"Button"] forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:@"failed"] forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor magentaColor] forState:UIControlStateHighlighted];
}
@end
