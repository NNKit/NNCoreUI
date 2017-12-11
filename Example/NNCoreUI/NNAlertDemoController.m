//  NNAlertDemoController.m
//  NNCoreUI
//
//  Created by  XMFraker on 2017/12/8
//  Copyright © XMFraker All rights reserved. (https://github.com/ws00801526)
//  @class      NNAlertDemoController
//  @version    <#class version#>
//  @abstract   <#class description#>
//  @discussion <#class functions#>


#import "NNAlertDemoController.h"
#import <NNCoreUI/NNCoreUI.h>

@interface NNAlertDemoController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic) NNAlertStyle demoStyle;
@property (copy, nonatomic, readonly)   NSArray<NSArray<NSDictionary *> *> *dataArray;
@property (strong, nonatomic, readonly) NNAlertConfig *alertConfig;


@end

@implementation NNAlertDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.demoStyle = NNAlertStyleAlert;
    self.tableView.rowHeight = 50.f;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - Events

- (IBAction)handleDemoStyleChanged:(UIBarButtonItem *)sender {
    self.demoStyle = sender.tag;
    [self.tableView reloadData];
}

#pragma mark - Private Methods

- (void)baseAlertDemoWithIndex:(NSUInteger)index {
    
    NSDictionary *info = [[self.dataArray safeObjectAtIndex:0] safeObjectAtIndex:index];
    switch (index) {
        case 0:
        {
            self.alertConfig.title([info safeObjectForKey:@"title"]).defaultAction(@"确定", ^(NNAlertAction *action) {
                [NNAlert dismissAlertWithCompletionHandler:nil];
            }).backgroundColor([UIColor greenColor]).contentBackgroundColor([UIColor redColor]).cancelAction(@"取消", nil).show();
        }
            break;
        case 1:
        {
            __block __weak UITextField *tmpTextField = nil;
            self.alertConfig.title([info safeObjectForKey:@"title"]).content([info safeObjectForKey:@"content"]).addTextField(^(__kindof UITextField *textField) {
                textField.placeholder = @"请输入文字";
                textField.textColor = [UIColor blueColor];
                tmpTextField = textField;
            }).cancelAction(@"取消", nil).defaultAction(@"确定", ^(NNAlertAction *tmp) {
                NNLogD(@"this is confirm action :%@",tmpTextField.text);
            }).show();
        }
            break;
            
        case 2:
        {
            __block __weak UITextField *tmpTextField = nil;
            UIView *tmpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 300)];
            tmpView.backgroundColor = [UIColor blueColor];
            
            UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleUpdateCustomViewFrame:)];
            [tmpView addGestureRecognizer:tapGes];
            
            UILabel *label = [[UILabel alloc] initWithFrame:tmpView.bounds];
            label.text = @"点我有惊喜";
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor whiteColor];
            label.userInteractionEnabled = NO;
            label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            label.center = CGPointMake(100.f, 150.f);
            [tmpView addSubview:label];
            
            self.alertConfig.contentInsets(UIEdgeInsetsZero).title([info safeObjectForKey:@"title"]).content([info safeObjectForKey:@"content"]).addCustomView(^(__kindof NNAlertCustomView *customView) {
                customView.contentView = tmpView;
                customView.autoresizingWidth = YES;
            }).addTextField(^(__kindof UITextField *textField) {
                textField.placeholder = @"请输入文字";
                textField.textColor = [UIColor blueColor];
                tmpTextField = textField;
            }).cancelAction(@"取消", nil).defaultAction(@"确定", ^(NNAlertAction *tmp) {
                NNLogD(@"this is confirm action :%@",tmpTextField.text);
            }).show();
        }
            break;
        case 3:
        {
            
            self.alertConfig.addTitle(^(__kindof UILabel *label) {
                label.text = [info safeObjectForKey:@"title"];
                label.font = [UIFont systemFontOfSize:16.f];
                label.textColor = NNColorHex(0x333333);
                label.textAlignment = NSTextAlignmentLeft;
            }).itemInsets(UIEdgeInsetsZero).addContent(^(UILabel *label) {
                label.text = [info safeObjectForKey:@"content"];
                label.font = [UIFont systemFontOfSize:14.f];
                label.textColor = NNColorHex(0xee3300);
                label.textAlignment = NSTextAlignmentLeft;
            }).itemInsets(UIEdgeInsetsMake(10, 0, 0, 0)).cancelAction(@"确定", nil).show();
        }
            break;
        case 4:
        {
            self.alertConfig.addTitle(^(__kindof UILabel *label) {
                label.text = [info safeObjectForKey:@"title"];
                label.font = [UIFont systemFontOfSize:16.f];
                label.textColor = NNColorHex(0x333333);
                label.textAlignment = NSTextAlignmentLeft;
            }).itemInsets(UIEdgeInsetsZero).addContent(^(UILabel *label) {
                label.text = [info safeObjectForKey:@"content"];
                label.font = [UIFont systemFontOfSize:14.f];
                label.textColor = NNColorHex(0xee3300);
                label.textAlignment = NSTextAlignmentLeft;
            }).itemInsets(UIEdgeInsetsMake(10, 0, 0, 0)).defaultAction(@"这是默认按钮",^(id action){
                
            }).cancelAction(@"这是取消按钮", nil).destructiveAction(@"这是销毁按钮",^(id action){
                
            }).show();
        }
            break;
        case 5:
        {
            self.alertConfig.title([info safeObjectForKey:@"title"]).addAction(^(NNAlertAction *action) {
                
                // config default
                action.text = @"  点我?";
                action.image = [UIImage imageNamed:@"success"];
                action.textColor = [UIColor greenColor];
                
                // config highlight
                action.highlightText = @"  点错了";
                action.highlightImage = [UIImage imageNamed:@"failed"];
                action.highlightTextColor = [UIColor redColor];
                
                // config other
                action.height = 80.f;
                action.dismissAlertWhenTriggered = YES;
                
                action.handler = ^(NNAlertAction *action) {
                    NNLogD(@"点击了action : %@", action);
                };
            }).show();
        }
            break;
        case 6:
        {
            __weak __block NNAlertAction *tmpAction = nil;
            self.alertConfig.title([info safeObjectForKey:@"title"]).addAction(^(NNAlertAction *action) {
                action.text = @"点我改变高度";
                action.dismissAlertWhenTriggered = NO;
                action.handler = ^(NNAlertAction *action) {
                    tmpAction.height += 45.f;
                    [tmpAction setNeedsUpdate];
                };
                tmpAction = action;
            }).addAction(^(NNAlertAction *action) {
                action.text = @"重置";
                action.dismissAlertWhenTriggered = NO;
                action.handler = ^(NNAlertAction *action) {
                    tmpAction.height = 45.f;
                    [tmpAction setNeedsUpdate];
                };
            }).cancelAction(@"关闭", nil).show();
        }
            break;
        case 7:
        {
            __weak __block UILabel *titleLabel = nil;
            __weak __block UILabel *contentLabel = nil;
            self.alertConfig.addTitle(^(__kindof UILabel *label) {
                
                label.text = @"这是一个默认标题";
                label.textColor = [UIColor darkTextColor];
                titleLabel = label;
            }).addContent(^(__kindof UILabel *label) {
                
                label.text = @"这是一个默认内容";
                label.textColor = [UIColor lightGrayColor];
                contentLabel = label;
            }).addAction(^(NNAlertAction *action) {
                action.text = @"确定改变标题么?";
                action.dismissAlertWhenTriggered = NO;
                action.handler = ^(NNAlertAction *action) {
                    titleLabel.text = @"改变了标题?";
                    contentLabel.text  = @"是的内容改变了\n附加内容很长\n附加内容很长\n附加内容很长\n附加内容很长\n附加内容很长\n附加内容很长\n附加内容很长\n附加内容很长\n附加内容很长\n附加内容很长\n附加内容很长\n附加内容很长";
                    titleLabel.textColor = [UIColor redColor];
                    contentLabel.textColor = [UIColor greenColor];
                };
            }).cancelAction(@"关闭", nil).show();
        }
            break;
        case 8:
        {
            self.alertConfig.title(@"标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题").content(@"内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容").maxWidthHandler(^CGFloat(NNAlertScreenOrientation orientation) {
                if (orientation == NNAlertScreenOrientationHorizontal) {
                    return [UIScreen mainScreen].bounds.size.width * .7f;
                } else { return [UIScreen mainScreen].bounds.size.width * .9f; }
            }).show();
        }
            break;
        case 9:
        {
         
            self.alertConfig.title(@"显示一个自定义动画的Alert").cancelAction(@"关闭", nil).showAnimationHandler(^(NNEmptyHandler animatingHandler, NNEmptyHandler animatedHandler) {
                
                [UIView animateWithDuration:1.f delay:.0f usingSpringWithDamping:.4f initialSpringVelocity:.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    animatingHandler ? animatingHandler() : nil;
                } completion:^(BOOL finished) {
                    animatedHandler ? animatedHandler() : nil;
                }];
            }).dismissAnimationHandler(^(NNEmptyHandler animatingHandler, NNEmptyHandler animatedHandler) {
                [UIView animateWithDuration:.15f animations:^{
                    animatingHandler ? animatingHandler() : nil;
                } completion:^(BOOL finished) {
                    animatedHandler ? animatedHandler() : nil;
                }];
            }).show();
        }
            break;
        case 10:
        {
            NSArray *tmpArray = @[@1,@2,@4,@8];
            int value = arc4random() % 4;
            NNAlertAnimationStyle style = [[tmpArray safeObjectAtIndex:value] intValue];
            self.alertConfig.title(@"显示一个自定义动画样式的Alert").cancelAction(@"关闭", nil).showAnimationStyle(style).dismissAnimationStyle(NNAlertAnimationStyleFromBottom | NNAlertAnimationStyleFade).show();
        }
            break;
        case 11:
        {
            // 与上一个即将显示的AlertConfig 比较, 加入队列之后队列按照优先级顺序排列
            self.alertConfig.queue(YES).priority(10).title(@"我的优先级低,早加入,晚显示").cancelAction(@"关闭", nil).show();
            // 与上一个即将显示的AlertConfig 比较, 加入队列之后队列按照优先级顺序排列
            self.alertConfig.queue(YES).priority(200).title(@"我的优先级高,晚加入,早显示").defaultAction(@"关闭所有", ^(NNAlertAction *action) {
                [NNAlert dismissAndClearQueue];
            }).cancelAction(@"下一个", nil).show();
            // 与上一个即将显示的AlertConfig 比较, 加入队列之后队列按照优先级顺序排列
            self.alertConfig.queue(YES).priority(100).title(@"我的优先级一般,晚加入,看优先级显示").cancelAction(@"下一个", nil).show();
            // 与上一个即将显示的AlertConfig 比较, 尽管不加入队列, 但是其优先级很高, 优先显示
            self.alertConfig.queue(NO).priority(300).title(@"我的优先级很高,但是不加入队列显示").cancelAction(@"下一个", nil).show();
            // 与上一个即将要显示的AlertConfig 比较, 如果优先级低, 则不加入队列不显示
            self.alertConfig.queue(NO).priority(120).title(@"我的优先级不高,也不加入队列显示").cancelAction(@"下一个", nil).show();
        }
            break;
        case 12:
            self.alertConfig.title([info safeObjectForKey:@"title"]).backgroundBlurEffectStyle(UIBlurEffectStyleDark).show();
            break;
        default:
            break;
    }
}

- (void)basicActionSheetDemoWithIndex:(NSInteger)index {
    
    NSDictionary *info = [[self.dataArray safeObjectAtIndex:0] safeObjectAtIndex:index];
    switch (index) {
        case 0:
        {
            self.alertConfig.title([info safeObjectForKey:@"title"]).actionSheetMarginBottom(20).actionSheetCancelActionSpaceHeight(20.f).actionSheetCancelActionSpaceColor([UIColor greenColor]).defaultAction(@"确定", ^(NNAlertAction *action) {
                [NNAlert dismissAlertWithCompletionHandler:nil];
            }).backgroundColor([UIColor greenColor]).contentBackgroundColor([UIColor redColor]).cancelAction(@"取消", nil).show();
        }
            break;
        case 1:
        {
            __block __weak UITextField *tmpTextField = nil;
            UIView *tmpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 300)];
            tmpView.backgroundColor = [UIColor blueColor];
            
            UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleUpdateCustomViewFrame:)];
            [tmpView addGestureRecognizer:tapGes];
            
            UILabel *label = [[UILabel alloc] initWithFrame:tmpView.bounds];
            label.text = @"点我有惊喜";
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor whiteColor];
            label.userInteractionEnabled = NO;
            label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            label.center = CGPointMake(100.f, 150.f);
            [tmpView addSubview:label];
            
            self.alertConfig.contentInsets(UIEdgeInsetsZero).title([info safeObjectForKey:@"title"]).content([info safeObjectForKey:@"content"]).addCustomView(^(__kindof NNAlertCustomView *customView) {
                customView.contentView = tmpView;
                customView.autoresizingWidth = YES;
            }).cancelAction(@"取消", nil).defaultAction(@"确定", ^(NNAlertAction *tmp) {
                NNLogD(@"this is confirm action :%@",tmpTextField.text);
            }).show();
        }
            break;
        case 2:
        {
            
            self.alertConfig.addTitle(^(__kindof UILabel *label) {
                label.text = [info safeObjectForKey:@"title"];
                label.font = [UIFont systemFontOfSize:16.f];
                label.textColor = NNColorHex(0x333333);
                label.textAlignment = NSTextAlignmentLeft;
            }).itemInsets(UIEdgeInsetsZero).addContent(^(UILabel *label) {
                label.text = [info safeObjectForKey:@"content"];
                label.font = [UIFont systemFontOfSize:14.f];
                label.textColor = NNColorHex(0xee3300);
                label.textAlignment = NSTextAlignmentLeft;
            }).itemInsets(UIEdgeInsetsMake(10, 0, 0, 0)).cancelAction(@"确定", nil).show();
        }
            break;
        case 3:
        {
            self.alertConfig.addTitle(^(__kindof UILabel *label) {
                label.text = [info safeObjectForKey:@"title"];
                label.font = [UIFont systemFontOfSize:16.f];
                label.textColor = NNColorHex(0x333333);
                label.textAlignment = NSTextAlignmentLeft;
            }).itemInsets(UIEdgeInsetsZero).addContent(^(UILabel *label) {
                label.text = [info safeObjectForKey:@"content"];
                label.font = [UIFont systemFontOfSize:14.f];
                label.textColor = NNColorHex(0xee3300);
                label.textAlignment = NSTextAlignmentLeft;
            }).itemInsets(UIEdgeInsetsMake(10, 0, 0, 0)).defaultAction(@"这是默认按钮",^(id action){
                
            }).cancelAction(@"这是取消按钮", nil).destructiveAction(@"这是销毁按钮",^(id action){
                
            }).show();
        }
            break;
        case 4:
        {
            self.alertConfig.title([info safeObjectForKey:@"title"]).addAction(^(NNAlertAction *action) {
                
                // config default
                action.text = @"  点我?";
                action.image = [UIImage imageNamed:@"success"];
                action.textColor = [UIColor greenColor];
                
                // config highlight
                action.highlightText = @"  点错了";
                action.highlightImage = [UIImage imageNamed:@"failed"];
                action.highlightTextColor = [UIColor redColor];
                
                // config other
                action.height = 80.f;
                action.dismissAlertWhenTriggered = YES;
                
                action.handler = ^(NNAlertAction *action) {
                    NNLogD(@"点击了action : %@", action);
                };
            }).show();
        }
            break;
        case 5:
        {
            __weak __block NNAlertAction *tmpAction = nil;
            self.alertConfig.title([info safeObjectForKey:@"title"]).addAction(^(NNAlertAction *action) {
                action.text = @"点我改变高度";
                action.dismissAlertWhenTriggered = NO;
                action.handler = ^(NNAlertAction *action) {
                    tmpAction.height += 45.f;
                    [tmpAction setNeedsUpdate];
                };
                tmpAction = action;
            }).addAction(^(NNAlertAction *action) {
                action.text = @"重置";
                action.dismissAlertWhenTriggered = NO;
                action.handler = ^(NNAlertAction *action) {
                    tmpAction.height = 45.f;
                    [tmpAction setNeedsUpdate];
                };
            }).cancelAction(@"关闭", nil).show();
        }
            break;
        case 6:
        {
            __weak __block UILabel *titleLabel = nil;
            __weak __block UILabel *contentLabel = nil;
            self.alertConfig.addTitle(^(__kindof UILabel *label) {
                
                label.text = @"这是一个默认标题";
                label.textColor = [UIColor darkTextColor];
                titleLabel = label;
            }).addContent(^(__kindof UILabel *label) {
                
                label.text = @"这是一个默认内容";
                label.textColor = [UIColor lightGrayColor];
                contentLabel = label;
            }).addAction(^(NNAlertAction *action) {
                action.text = @"确定改变标题么?";
                action.dismissAlertWhenTriggered = NO;
                action.handler = ^(NNAlertAction *action) {
                    titleLabel.text = @"改变了标题?";
                    contentLabel.text  = @"是的内容改变了\n附加内容很长\n附加内容很长\n附加内容很长\n附加内容很长\n附加内容很长\n附加内容很长\n附加内容很长\n附加内容很长\n附加内容很长\n附加内容很长\n附加内容很长\n附加内容很长";
                    titleLabel.textColor = [UIColor redColor];
                    contentLabel.textColor = [UIColor greenColor];
                };
            }).cancelAction(@"关闭", nil).show();
        }
            break;
        case 7:
        {
            self.alertConfig.title(@"标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题").content(@"内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容").maxWidthHandler(^CGFloat(NNAlertScreenOrientation orientation) {
                if (orientation == NNAlertScreenOrientationHorizontal) {
                    return [UIScreen mainScreen].bounds.size.width * .7f;
                } else { return [UIScreen mainScreen].bounds.size.width * .9f; }
            }).show();
        }
            break;
        case 8:
        {
            
            self.alertConfig.title(@"显示一个自定义动画的Alert").cancelAction(@"关闭", nil).showAnimationHandler(^(NNEmptyHandler animatingHandler, NNEmptyHandler animatedHandler) {
                
                [UIView animateWithDuration:1.f delay:.0f usingSpringWithDamping:.4f initialSpringVelocity:.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    animatingHandler ? animatingHandler() : nil;
                } completion:^(BOOL finished) {
                    animatedHandler ? animatedHandler() : nil;
                }];
            }).dismissAnimationHandler(^(NNEmptyHandler animatingHandler, NNEmptyHandler animatedHandler) {
                [UIView animateWithDuration:.15f animations:^{
                    animatingHandler ? animatingHandler() : nil;
                } completion:^(BOOL finished) {
                    animatedHandler ? animatedHandler() : nil;
                }];
            }).show();
        }
            break;
        case 9:
        {
            NSArray *tmpArray = @[@1,@2,@4,@8];
            int value = arc4random() % 4;
            NNAlertAnimationStyle style = [[tmpArray safeObjectAtIndex:value] intValue];
            self.alertConfig.title(@"显示一个自定义动画样式的Alert").cancelAction(@"关闭", nil).showAnimationStyle(style).dismissAnimationStyle(NNAlertAnimationStyleFromBottom | NNAlertAnimationStyleFade).show();
        }
            break;
        case 10:
        {
            // 与上一个即将显示的AlertConfig 比较, 加入队列之后队列按照优先级顺序排列
            self.alertConfig.queue(YES).priority(10).title(@"我的优先级低,早加入,晚显示").cancelAction(@"关闭", nil).show();
            // 与上一个即将显示的AlertConfig 比较, 加入队列之后队列按照优先级顺序排列
            self.alertConfig.queue(YES).priority(200).title(@"我的优先级高,晚加入,早显示").defaultAction(@"关闭所有", ^(NNAlertAction *action) {
                [NNAlert dismissAndClearQueue];
            }).cancelAction(@"下一个", nil).show();
            // 与上一个即将显示的AlertConfig 比较, 加入队列之后队列按照优先级顺序排列
            self.alertConfig.queue(YES).priority(100).title(@"我的优先级一般,晚加入,看优先级显示").cancelAction(@"下一个", nil).show();
            // 与上一个即将显示的AlertConfig 比较, 尽管不加入队列, 但是其优先级很高, 优先显示
            self.alertConfig.queue(NO).priority(300).title(@"我的优先级很高,但是不加入队列显示").cancelAction(@"下一个", nil).show();
            // 与上一个即将要显示的AlertConfig 比较, 如果优先级低, 则不加入队列不显示
            self.alertConfig.queue(NO).priority(120).title(@"我的优先级不高,也不加入队列显示").cancelAction(@"下一个", nil).show();
        }
            break;
        case 11:
            self.alertConfig.title([info safeObjectForKey:@"title"]).backgroundBlurEffectStyle(UIBlurEffectStyleDark).show();
            break;
        default:
            break;
    }
}

- (void)advancedDemoWithIndex:(NSUInteger)index {
    
    switch (index) {
        case 0:
        {
            
            self.alertConfig.maxWidth(280.f).contentInsets(UIEdgeInsetsMake(10, 10, 10, 10)).title(@"评个分吧").itemInsets(UIEdgeInsetsMake(0, 10, 0, 10)).content(@"如果您感觉不错\n给个五星好评呗亲~").itemInsets(UIEdgeInsetsMake(5, 10, 0, 10)).addAction(^(NNAlertAction *action) {
                action.backgroundColor = NNColorHex(0xf1f1f1);
                action.borderColor = NNColorHex(0xe1e1e1);
                action.textColor = NNColorHex(0x999999);
                action.borderWidth = .5f;
                action.cornerRadius = 4.f;
                action.text = @"果断拒绝";
                action.insets = UIEdgeInsetsMake(0, 10, 5, 10);
            }).addAction(^(NNAlertAction *action) {
                action.backgroundColor = NNColorHex(0xf1f1f1);
                action.textColor = NNColorHex(0x999999);
                action.borderColor = NNColorHex(0xe1e1e1);
                action.borderWidth = .5f;
                action.cornerRadius = 4.f;
                action.text = @"立即吐槽";
                action.insets = UIEdgeInsetsMake(0, 10, 5, 10);
            }).addAction(^(NNAlertAction *action) {
                action.backgroundColor = [UIColor redColor];
                action.highlightBackgroundColor = [[UIColor redColor] colorWithAlphaComponent:.8f];
                action.textColor = [UIColor whiteColor];
                action.cornerRadius = 4.f;
                action.text = @"五星好评";
                action.insets = UIEdgeInsetsMake(0, 10, 5, 10);
            }).show();
            
        }
            break;
            
        default:
            break;
    }
}

- (void)handleUpdateCustomViewFrame:(UITapGestureRecognizer *)tap {

    CGFloat randomWidth = arc4random() % 240 + 10;
    CGFloat randomHeight = arc4random() % 400 + 10;
    CGRect viewFrame = tap.view.frame;
    viewFrame.size.width = randomWidth;
    viewFrame.size.height = randomHeight;
    tap.view.frame = viewFrame;
}

#pragma mark - UITableViewDelegate & UITableViewSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { return self.dataArray.count; }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { return  [self.dataArray safeObjectAtIndex:section].count; }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [[[self.dataArray safeObjectAtIndex:indexPath.section] safeObjectAtIndex:indexPath.row] safeObjectForKey:@"title"];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return section == 0 ? @"Basic Usage" : @"Advanced Usage";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) { self.demoStyle == NNAlertStyleAlert ? [self baseAlertDemoWithIndex:indexPath.row] : [self basicActionSheetDemoWithIndex:indexPath.row]; }
    else if (indexPath.section == 1) { [self advancedDemoWithIndex:indexPath.row]; }
}

#pragma mark - Getter

- (NSArray<NSArray<NSDictionary *> *> *)dataArray { return self.demoStyle == NNAlertStyleAlert ? self.alertDataArray : self.actionSheetDataArray; }

- (NSArray<NSArray<NSDictionary *> *> *)alertDataArray {
    
    return @[
             @[
                 @{ @"title" : @"显示一个基础Alert" },
                 @{ @"title" : @"显示一个输入框Alert", @"content" : @"添加一个带有输入框的Alert" },
                 @{ @"title" : @"显示一个自定义CustomView.Alert" },
                 @{ @"title" : @"显示一个退出群组通知", @"content" : @"您已退出群组,将不再接收新消息" },
                 @{ @"title" : @"显示一个拥有三种Action的Alert", @"content" : @"Alert拥有三种Action" },
                 @{ @"title" : @"显示一个自定义Action的Alert" },
                 @{ @"title" : @"显示一个动态改变Action高度的Alert" },
                 @{ @"title" : @"显示一个动态改变Title,Content的Alert" },
                 @{ @"title" : @"显示一个横竖屏自适应屏幕宽度的Alert" },
                 @{ @"title" : @"显示一个自定义显示隐藏动画的Alert" },
                 @{ @"title" : @"显示一个自定义显示隐藏动画样式的Alert" },
                 @{ @"title" : @"显示多个自定义显示顺序的Alert" },
                 @{ @"title" : @"显示一个毛玻璃背景的Alert" },
                 ],
             @[
                 @{@"title" : @"显示一个评分Alert"}
                ]
             ];
}

- (NSArray<NSArray<NSDictionary *> *> *)actionSheetDataArray {
    
    return @[
             @[
                 @{ @"title" : @"显示一个基础ActionSheet" },
                 @{ @"title" : @"显示一个自定义CustomView.ActionSheet" },
                 @{ @"title" : @"显示一个退出群组通知ActionSheet", @"content" : @"您已退出群组,将不再接收新消息" },
                 @{ @"title" : @"显示一个拥有三种Action的ActionSheet", @"content" : @"Alert拥有三种Action" },
                 @{ @"title" : @"显示一个自定义Action的ActionSheet" },
                 @{ @"title" : @"显示一个动态改变Action高度的ActionSheet" },
                 @{ @"title" : @"显示一个动态改变Title,Content的ActionSheet" },
                 @{ @"title" : @"显示一个横竖屏自适应屏幕宽度的ActionSheet" },
                 @{ @"title" : @"显示一个自定义显示隐藏动画的ActionSheet" },
                 @{ @"title" : @"显示一个自定义显示隐藏动画样式的ActionSheet" },
                 @{ @"title" : @"显示多个自定义显示顺序的ActionSheet" },
                 @{ @"title" : @"显示一个毛玻璃背景的ActionSheet" },
                 ],
             @[]
             ];
}

- (NNAlertConfig *)alertConfig { return self.demoStyle == NNAlertStyleAlert ? [NNAlert alert] : [NNAlert actionSheet]; }

@end
