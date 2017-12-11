//  NNAlert.m
//  Pods
//
//  Created by  XMFraker on 2017/12/6
//  Copyright © XMFraker All rights reserved. (https://github.com/ws00801526)
//  @class      NNAlert
//  @version    <#class version#>
//  @abstract   <#class description#>
//  @discussion <#class functions#>

#import "NNAlert.h"
#import <NNCore/NNCore.h>

#define kNNAlertSafeAreaInsets UIEdgeInsetsMake(20, 20, 20, 20)

@implementation UIImage (NNAlertPrivate)

+ (instancetype)nn_imageWithColor:(UIColor *)color {

    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end

@implementation UIView (NNAlertPrivate)

- (__kindof UIView *)nn_firstResponder {
    
    if (self.isFirstResponder) return self;
    
    for (UIView *subView in self.subviews) {
        UIView *firstResponder = [subView nn_firstResponder];
        if (firstResponder) return firstResponder;
    }
    return nil;
}

@end

@interface NNAlert ()

@property (strong, nonatomic) UIWindow *mainWindow;
@property (strong, nonatomic) NNAlertWindow *window;
@property (strong, nonatomic) NSMutableArray<NNAlertConfig *> *queues;
@property (strong, nonatomic) __kindof NNAlertBaseController *viewController;

@end

@interface NNAlertConfig ()

@property (assign, nonatomic) NNAlertStyle style;

@property (strong, nonatomic) NSMutableArray<NNAlertActionHandler> *actions;
@property (strong, nonatomic) NSMutableArray<NNAlertItemHandler> *items;
@property (strong, nonatomic) NSMutableDictionary<NNAlertItemHandler,NSValue *> *itemInsetsInfos;

@property (assign, nonatomic) CGFloat modelCornerRadius;
@property (assign, nonatomic) CGFloat modelShadowOpacity;
@property (assign, nonatomic) CGFloat modelShadowRadius;
@property (assign, nonatomic) CGFloat modelShowAnimationDuration;
@property (assign, nonatomic) CGFloat modelDismissAnimationDuration;
@property (assign, nonatomic) CGFloat modelBackgroundAlpha;
@property (assign, nonatomic) CGFloat modelWindowLevel;
@property (assign, nonatomic) CGFloat modelQueuePriority;

@property (assign, nonatomic) BOOL modelDismissWhenTouchedContent;
@property (assign, nonatomic) BOOL modelDismissWhenTouchedBackground;
@property (assign, nonatomic) BOOL modelShouldAutoRotate;
@property (assign, nonatomic) BOOL modelIsQueue;
@property (assign, nonatomic) BOOL modelIsContinueQueueDisplay;
@property (assign, nonatomic) BOOL modelIsAvoidKeyboard;

@property (assign, nonatomic) CGSize modelShadowOffset;
@property (assign, nonatomic) UIEdgeInsets modelContentInsets;

@property (strong, nonatomic) UIColor *modelShadowColor;
@property (strong, nonatomic) UIColor *modelBackgroundColor;
@property (strong, nonatomic) UIColor *modelContentBackgroundColor;

@property (copy, nonatomic)   CGFloat(^modelMaxWidthHandler)(NNAlertScreenOrientation);
@property (copy, nonatomic)   CGFloat(^modelMaxHeightHandler)(NNAlertScreenOrientation);

@property (copy, nonatomic)   void(^modelShowingAnimationHandler)(NNEmptyHandler, NNEmptyHandler);
@property (copy, nonatomic)   void(^modelDismissingAnimationHandler)(NNEmptyHandler, NNEmptyHandler);
@property (copy, nonatomic)   NNEmptyHandler modelCompletedHandler;
@property (copy, nonatomic)   NNEmptyHandler modelConfigCompletedHandler;

@property (assign, nonatomic) NNAlertBackgroundStyle modelBackgroundStyle;
@property (assign, nonatomic) NNAlertAnimationStyle modelShowingAnimationStyle;
@property (assign, nonatomic) NNAlertAnimationStyle modelDismissingAnimationStyle;

@property (assign, nonatomic) UIBlurEffectStyle modelBlurEffectStyle;
@property (assign, nonatomic) UIInterfaceOrientationMask modelInterfaceOrientationMask;

@property (strong, nonatomic) UIColor *modelActionSheetCancelActionSpaceColor;
@property (assign, nonatomic) CGFloat modelActionSheetCancelActionSpaceHeight;
@property (assign, nonatomic) CGFloat modelActionSheetCanncelActionBottomMargin;

@end

@interface NNAlertAction ()
@property (strong, nonatomic) void(^updateHandler)(NNAlertAction *);
@end

@interface NNAlertCustomView ()
@property (strong, nonatomic) NNAlertItem *item;
@property (assign, nonatomic) CGSize storedViewSize;
@property (assign, nonatomic, getter=isFrameObserved) BOOL frameObserved;

@property (copy, nonatomic)   void(^sizeChangedHandler)(void);
@end

@interface NNAlertActionButton : UIButton
@property (strong, nonatomic) NNAlertAction *action;
@property (strong, nonatomic) CALayer *topLayer;
@property (strong, nonatomic) CALayer *bottomLayer;
@property (strong, nonatomic) CALayer *leftLayer;
@property (strong, nonatomic) CALayer *rightLayer;
@property (strong, nonatomic) void(^heightChangedHandler)(void);
+ (NNAlertActionButton *)buttonWithAction:(NNAlertAction *)action;
@end

@interface NNAlertBaseController ()

@property (strong, nonatomic) NNAlertConfig *config;
@property (strong, nonatomic) UIWindow *keywindow;
@property (strong, nonatomic) UIVisualEffectView *backgroundEffectView;
@property (strong, nonatomic) NNAlertCustomView *customView;

@property (assign, nonatomic) NNAlertScreenOrientation orientationStyle;

@property (assign, nonatomic, getter=isShowing) BOOL showing;
@property (assign, nonatomic, getter=isDismissing) BOOL dismissing;

@property (copy, nonatomic)   NNEmptyHandler showedHandler;
@property (copy, nonatomic)   NNEmptyHandler dismissedHandler;

@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) NSMutableArray *items;
@property (strong, nonatomic) NSMutableArray<NNAlertActionButton *> *actionButtons;
@property (assign, nonatomic) CGFloat viewHeight;

- (void)setupAlertConfig;
- (void)updateViewLayout;
- (void)updateViewItemsLayout;
- (void)handleButtonAction:(NNAlertActionButton *)button;
- (void)showAnimationsWithCompletionHandler:(NNEmptyHandler)handler;
- (void)dismissAnimationsWithCompletionHandler:(NNEmptyHandler)hander;
@end

@interface NNAlertController ()

@property (assign, nonatomic, getter=isKeyboardShowing) BOOL keyboardShowing;
@property (assign, nonatomic) CGRect keyboardFrame;

@end

@interface NNActionSheetController ()

@property (strong, nonatomic) NNAlertActionButton *cancelActionButton;
@property (strong, nonatomic) UIView *cancelActionSpaceView;
@property (assign, nonatomic, getter=isShowed) BOOL showed;

@end

@implementation NNAlert

+ (instancetype)sharedManager {
    
    static NNAlert *alert;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        alert = [[NNAlert alloc] init];
    });
    return alert;
}

+ (NNAlertConfig *)alert {
    
    NNAlertConfig *config = [[NNAlertConfig alloc] init];
    config.style = NNAlertStyleAlert;
    return config;
}

+ (NNAlertConfig *)actionSheet {
    
    NNAlertConfig *config = [[NNAlertConfig alloc] init];
    config.style = NNAlertStyleActionSheet;
    config.modelShadowColor = [UIColor clearColor];
    config.modelShadowOpacity = .0f;
    return config;
}

+ (void)configAlertMainWindow:(UIWindow *)window {
    if (window) { [NNAlert sharedManager].mainWindow = window; }
}

+ (void)continueQueueDisplay {
    
    if ([NNAlert sharedManager].queues.count) {
        NNAlertConfig *lastObject = [[NNAlert sharedManager].queues lastObject];
        if (lastObject) { lastObject.modelConfigCompletedHandler(); }
    }
}

+ (void)dismissAndClearQueue {
    
    if ([NNAlert sharedManager].queues.count) {
        
        if ([NNAlert sharedManager].viewController && [NNAlert sharedManager].viewController.config) {
            [[[NNAlert sharedManager] queues] removeObjectsInArray:[[NNAlert sharedManager].queues filter:^BOOL(NNAlertConfig * _Nonnull obj) {
                return obj == [NNAlert sharedManager].viewController.config;
            }]];
        } else {
            [[[NNAlert sharedManager] queues] removeAllObjects];
        }
    }
}

+ (void)dismissAlertWithCompletionHandler:(NNEmptyHandler)handler {
    
    if ([NNAlert sharedManager].queues.count) {
        NNAlertConfig *lastObject = [[NNAlert sharedManager].queues lastObject];
        [lastObject dismissWithCompletionHandler:handler];
    }
}

- (NSMutableArray<NNAlertConfig *> *)queues {
    
    if (!_queues) { _queues = [NSMutableArray array]; };
    return _queues;
}

- (NNAlertWindow *)window {
    
    if (!_window) {
        _window = [[NNAlertWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _window.rootViewController = [[UIViewController alloc] init];
        _window.backgroundColor = [UIColor clearColor];
        _window.windowLevel = UIWindowLevelAlert;
        _window.hidden = YES;
    }
    return _window;
}

@end

@implementation NNAlertConfig

#pragma mark - Life Cycle

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.items = [NSMutableArray array];
        self.actions = [NSMutableArray array];
        self.itemInsetsInfos = [NSMutableDictionary dictionary];
        
        self.modelCornerRadius = 8.f;
        
        self.modelShadowRadius = 4.f;
        self.modelShadowOpacity = .3f;
        self.modelShadowOffset = CGSizeMake(.0f, 2.f);
        self.modelShadowColor = [UIColor blackColor];
        
        self.modelContentInsets = UIEdgeInsetsMake(20.f, 20.f, 20.f, 20.f);
        self.modelShowAnimationDuration = .3f;
        self.modelDismissAnimationDuration = .2f;
        self.modelBackgroundAlpha = .45f;
        self.modelWindowLevel = UIWindowLevelAlert;
        self.modelQueuePriority = 0;
        
        self.modelActionSheetCancelActionSpaceColor = [UIColor clearColor];
        self.modelActionSheetCancelActionSpaceHeight = 10.f;
        self.modelActionSheetCanncelActionBottomMargin = 10.f;
        
        self.modelContentBackgroundColor = [UIColor whiteColor];
        self.modelBackgroundColor = [UIColor blackColor];
        
        self.modelDismissWhenTouchedContent = NO;
        self.modelDismissWhenTouchedBackground = YES;
        
        self.modelShouldAutoRotate = YES;
        self.modelInterfaceOrientationMask = UIInterfaceOrientationMaskAllButUpsideDown;
        
        self.modelIsQueue = NO;
        self.modelIsContinueQueueDisplay = YES;
        self.modelIsAvoidKeyboard = YES;

        self.modelBackgroundStyle = NNAlertBackgroundStyleTranslucent;
        self.modelBlurEffectStyle = UIBlurEffectStyleLight;
        
        __weak typeof(self) wSelf = self;
        self.modelShowingAnimationHandler = ^(NNEmptyHandler animatingHandler,NNEmptyHandler animatedHandler) {
            __strong typeof(wSelf) self = wSelf;
            
            [UIView animateWithDuration:self.modelShowAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                animatingHandler ? animatingHandler() : nil;
            } completion:^(BOOL finished) {
                animatedHandler ? animatedHandler() : nil;
            }];
        };
        
        self.modelDismissingAnimationHandler = ^(NNEmptyHandler animatingHandler, NNEmptyHandler animatedHandler) {
            __strong typeof(wSelf) self = wSelf;
            [UIView animateWithDuration:self.modelDismissAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                animatingHandler ? animatingHandler() : nil;
            } completion:^(BOOL finished) {
                animatedHandler ? animatedHandler() : nil;
            }];
        };
        
        self.modelConfigCompletedHandler = ^{
          __strong typeof(wSelf) self = wSelf;
            if ([NNAlert sharedManager].queues.count) {
                
                NNAlertConfig *lastObject = [[NNAlert sharedManager].queues lastObject];
                
                // 忽略不需要队列显示, 并且优先级较低的alert
                if (!self.modelIsQueue && lastObject.modelQueuePriority > self.modelQueuePriority) { return ; }
                if (!lastObject.modelIsQueue && lastObject.modelQueuePriority <= self.modelQueuePriority) { [[NNAlert sharedManager].queues removeLastObject]; }

                if (![[NNAlert sharedManager].queues containsObject:self]) {
                    
                    [[NNAlert sharedManager].queues addObject:self];
                    [[NNAlert sharedManager].queues sortUsingComparator:^NSComparisonResult(NNAlertConfig *obj1, NNAlertConfig *obj2) {
                        return [@(obj1.modelQueuePriority) compare:@(obj2.modelQueuePriority)];
                    }];
                }
                if ([NNAlert sharedManager].queues.lastObject == self) { [self internalShow]; }
            } else {
                [self internalShow];
                [[NNAlert sharedManager].queues addObject:self];
            }
        };
    }
    return self;
}

- (void)dealloc {
    
#if DEBUG
    NSLog(@"%@ is %@ing", self, NSStringFromSelector(_cmd));
#endif
    [self.items removeAllObjects];
    [self.actions removeAllObjects];
}

#pragma mark - Public Methods

- (void)dismissWithCompletionHandler:(nullable NNEmptyHandler)handler {
    if ([NNAlert sharedManager].viewController) {
        [[NNAlert sharedManager].viewController dismissAnimationsWithCompletionHandler:handler];
    }
}

#pragma mark - Private Methods

- (void)internalShow {
    switch (self.style) {
        case NNAlertStyleAlert:
            [NNAlert sharedManager].viewController = [[NNAlertController alloc] init];
            break;
        case NNAlertStyleActionSheet:
            [NNAlert sharedManager].viewController = [[NNActionSheetController alloc] init];
            break;
        default:
            NNLogD(@"unsupport alert style :%d",(int)self.style);
            break;
    }
    if (![NNAlert sharedManager].viewController) { return; }
    [NNAlert sharedManager].viewController.config = self;
    [NNAlert sharedManager].window.rootViewController = [NNAlert sharedManager].viewController;
    [NNAlert sharedManager].window.windowLevel = self.modelWindowLevel;
    [NNAlert sharedManager].window.hidden = NO;
    [[NNAlert sharedManager].window makeKeyAndVisible];
    __weak typeof(self) wSelf = self;
    [NNAlert sharedManager].viewController.showedHandler = ^{
        NNLogD(@"alertView is showed");
    };
    [NNAlert sharedManager].viewController.dismissedHandler = ^{
        __strong typeof(wSelf) self = wSelf;
        if ([NNAlert sharedManager].queues.lastObject == self) {
            [NNAlert sharedManager].window.hidden = YES;
            [[NNAlert sharedManager].window resignKeyWindow];
            [NNAlert sharedManager].window.rootViewController = nil;
            [NNAlert sharedManager].viewController = nil;
            [[NNAlert sharedManager].queues removeObject:self];
            if (self.modelIsContinueQueueDisplay) { [NNAlert continueQueueDisplay]; }
        } else {
            [[NNAlert sharedManager].queues removeObject:self];
        }
        if (self.modelCompletedHandler) { self.modelCompletedHandler(); }
    };
}

#pragma mark - Setter

- (void)setStyle:(NNAlertStyle)style {
    _style = style;
    switch (style) {
        case NNAlertStyleActionSheet:
        {
            self.maxWidthHandler(^CGFloat(NNAlertScreenOrientation style) {

                if (style == NNAlertScreenOrientationHorizontal) {
                    return SCREEN_HEIGHT - kNNAlertSafeAreaInsets.top - kNNAlertSafeAreaInsets.bottom;
                } else {
                    return (SCREEN_WIDTH - kNNAlertSafeAreaInsets.top - kNNAlertSafeAreaInsets.bottom);
                }
            }).maxHeightHandler(^CGFloat(NNAlertScreenOrientation style) {
                return SCREEN_HEIGHT - kNNAlertSafeAreaInsets.top - kNNAlertSafeAreaInsets.bottom;
            }).showAnimationStyle(NNAlertAnimationStyleFromBottom).dismissAnimationStyle(NNAlertAnimationStyleFromBottom);
        }
            break;
        case NNAlertStyleAlert:
        default:
        {
            self.maxWidthHandler(^CGFloat(NNAlertScreenOrientation style) {
                return (SCREEN_WIDTH - kNNAlertSafeAreaInsets.top - kNNAlertSafeAreaInsets.bottom);
            }).maxHeightHandler(^CGFloat(NNAlertScreenOrientation style) {
                return SCREEN_HEIGHT - kNNAlertSafeAreaInsets.top - kNNAlertSafeAreaInsets.bottom;
            }).showAnimationStyle(NNAlertAnimationStyleNone | NNAlertAnimationStyleFade | NNAlertAnimationStyleShrink)
            .dismissAnimationStyle(NNAlertAnimationStyleNone | NNAlertAnimationStyleFade | NNAlertAnimationStyleShrink);
        }
            break;
    }
}

#pragma mark - Getter

- (NNConfigStringHandler)title {
    
    __weak typeof(self) wSelf = self;
    return ^(NSString *value) {
        __strong typeof(wSelf) self = wSelf;
        return self.addTitle(^(UILabel * label) {
            label.text = value;
        });
    };
}

- (NNConfigBlockLabelHandler)addTitle {
    
    __weak typeof(self) wSelf = self;
    return ^(NNAlertLabelHandler handler) {
        __strong typeof(wSelf) self = wSelf;
        return self.addItem(^(NNAlertItem *item) {
            item.mode = NNAlertItemModeTitle;
            item.insets = UIEdgeInsetsMake(10, 0, 10, 0);
            item.handler = handler;
        });
    };
}

- (NNConfigStringHandler)content {
    __weak typeof(self) wSelf = self;
    return ^(NSString *value) {
        __strong typeof(wSelf) self = wSelf;
        return self.addContent(^(UILabel * label) {
            label.text = value;
        });
    };
}

- (NNConfigBlockLabelHandler)addContent {
    
    __weak typeof(self) wSelf = self;
    return ^(NNAlertLabelHandler handler) {
        __strong typeof(wSelf) self = wSelf;
        return self.addItem(^(NNAlertItem *item) {
            item.mode = NNAlertItemModeContent;
            item.insets = UIEdgeInsetsMake(10, 0, 10, 0);
            item.handler = handler;
        });
    };
}

- (NNConfigViewHandler)customView {
    
    __weak typeof(self) wSelf = self;
    return ^(UIView *value) {
        __strong typeof(wSelf) self = wSelf;
        return self.addCustomView(^(NNAlertCustomView * customView) {
            customView.contentView = value;
            customView.position = NNAlertCustomViewPositionCenter;
        });
    };
}

- (NNConfigBlockCustomViewHandler)addCustomView {
    
    __weak typeof(self) wSelf = self;
    return ^(NNAlertCustomViewHandler handler) {
        
        __strong typeof(wSelf) self = wSelf;
        return self.addItem(^(NNAlertItem *item) {
            item.mode = NNAlertItemModeCustomView;
            item.handler = handler;
        });
    };
}

- (NNConfigBlockItemHandler)addItem {
    __weak typeof(self) wSelf = self;
    return ^(NNAlertItemHandler handler) {
        __strong typeof(wSelf) self = wSelf;
        if (self && handler) { [self.items addObject:handler]; }
        return self;
    };
}


- (NNConfigStringAndBlockHandler)defaultAction {
    
    __weak typeof(self) wSelf = self;
    return ^(NSString *title, NNAlertActionHandler handler) {
        __strong typeof(wSelf) self = wSelf;
        return self.addAction(^(NNAlertAction * action) {
            action.text = title;
            action.handler = handler;
            action.style = NNAlertActionStyleDefault;
            action.dismissAlertWhenTriggered = YES;
        });
    };
}

- (NNConfigStringAndBlockHandler)cancelAction {
    
    __weak typeof(self) wSelf = self;
    return ^(NSString *title, NNAlertActionHandler handler) {
        __strong typeof(wSelf) self = wSelf;
        return self.addAction(^(NNAlertAction * action) {
            action.text = title;
            action.handler = handler;
            action.font = [UIFont boldSystemFontOfSize:18.f];
            action.style = NNAlertActionStyleCancel;
        });
    };
}


- (NNConfigStringAndBlockHandler)destructiveAction {
    
    __weak typeof(self) wSelf = self;
    return ^(NSString *title, NNAlertActionHandler handler) {
        __strong typeof(wSelf) self = wSelf;
        return self.addAction(^(NNAlertAction * action) {
            action.text = title;
            action.handler = handler;
            action.textColor = [UIColor redColor];
            action.style = NNAlertActionStyleDestructive;
        });
    };
}

- (NNConfigBlockActionHandler)addAction {
    __weak typeof(self) wSelf = self;
    return ^(NNAlertActionHandler handler) {
        __strong typeof(wSelf) self = wSelf;
        if (self && handler) { [self.actions addObject:handler]; }
        return self;
    };
}

- (NNConfigEdgeInsetsHandler)contentInsets {
    
    __weak typeof(self) wSelf = self;
    return ^(UIEdgeInsets insets) {
        __strong typeof(wSelf) self = wSelf;
        self.modelContentInsets = insets;
        return self;
    };
}

- (NNConfigEdgeInsetsHandler)itemInsets {
    __weak typeof(self) wSelf = self;
    return ^(UIEdgeInsets insets) {
        __strong typeof(wSelf) self = wSelf;
        NSAssert((self.items.count), @"you should config item first");
        if (self.items.count) {
            NNAlertItemHandler handler = [self.items lastObject];
            [self.itemInsetsInfos setObject:[NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(MAX(0, insets.top), MAX(0, insets.left), MAX(0, insets.bottom), MAX(0, insets.right))] forKey:handler];
        }
        return self;
    };
}

- (NNConfigFloatHandler)maxWidth {
    
    __weak typeof(self) wSelf = self;
    return ^(CGFloat width) {
        __strong typeof(wSelf) self = wSelf;
        return self.maxWidthHandler(^CGFloat(NNAlertScreenOrientation style) {
            return width;
        });
    };
}

- (NNConfigFloatHandler)maxHeight {
    
    __weak typeof(self) wSelf = self;
    return ^(CGFloat height) {
        __strong typeof(wSelf) self = wSelf;
        return self.maxHeightHandler(^CGFloat(NNAlertScreenOrientation style) {
            return height;
        });
    };
}

- (NNAlertConfig *(^)(CGFloat(^)(NNAlertScreenOrientation)))maxWidthHandler {
    
    __weak typeof(self) wSelf = self;
    return ^(CGFloat(^handler)(NNAlertScreenOrientation style)) {
        __strong typeof(wSelf) self = wSelf;
        if (handler) { self.modelMaxWidthHandler = handler; };
        return self;
    };
}

- (NNAlertConfig *(^)(CGFloat(^)(NNAlertScreenOrientation)))maxHeightHandler {
    
    __weak typeof(self) wSelf = self;
    return ^(CGFloat(^handler)(NNAlertScreenOrientation style)) {
        __strong typeof(wSelf) self = wSelf;
        if (handler) self.modelMaxHeightHandler  = handler;
        return self;
    };
}

- (NNConfigFloatHandler)cornerRadius {
    
    __weak typeof(self) wSelf = self;
    return ^(CGFloat cornerRadius) {
        __strong typeof(wSelf) self = wSelf;
        self.modelCornerRadius = cornerRadius;
        return self;
    };
}

- (NNConfigFloatHandler)showAnimationDuration {
    
    __weak typeof(self) wSelf = self;
    return ^(CGFloat duration) {
        __strong typeof(wSelf) self = wSelf;
        self.modelShowAnimationDuration = duration;
        return self;
    };
}

- (NNConfigFloatHandler)dismissAnimationDuration {
    
    __weak typeof(self) wSelf = self;
    return ^(CGFloat duration) {
        __strong typeof(wSelf) self = wSelf;
        self.modelDismissAnimationDuration = duration;
        return self;
    };
}

- (NNConfigColorHandler)contentBackgroundColor {
    
    __weak typeof(self) wSelf = self;
    return ^(UIColor *color) {
        __strong typeof(wSelf) self = wSelf;
        self.modelContentBackgroundColor = color;
        return self;
    };
}

- (NNConfigColorHandler)backgroundColor {
    
    __weak typeof(self) wSelf = self;
    return ^(UIColor *color) {
        __strong typeof(wSelf) self = wSelf;
        self.modelBackgroundColor = color;
        return self;
    };
}

- (NNConfigFloatHandler)backgroundTranslucent {
    
    __weak typeof(self) wSelf = self;
    return ^(CGFloat alpha) {
        __strong typeof(wSelf) self = wSelf;
        self.modelBackgroundAlpha = alpha;
        self.modelBackgroundStyle = NNAlertBackgroundStyleTranslucent;
        return self;
    };
}

- (NNConfigBlurEffectStyleHandler)backgroundBlurEffectStyle {
    
    __weak typeof(self) wSelf = self;
    return ^(UIBlurEffectStyle style) {
        __strong typeof(wSelf) self = wSelf;
        self.modelBlurEffectStyle = style;
        self.modelBackgroundStyle = NNAlertBackgroundStyleBlurEffect;
        return self;
    };
}

- (NNConfigBOOLHandler)dismissWhenTouchedContent {
    
    __weak typeof(self) wSelf = self;
    return ^(BOOL dismiss) {
        __strong typeof(wSelf) self = wSelf;
        self.modelDismissWhenTouchedContent = dismiss;
        return self;
    };
}

- (NNConfigBOOLHandler)dismissWhenTouchedBackground {
    
    __weak typeof(self) wSelf = self;
    return ^(BOOL dismiss) {
        __strong typeof(wSelf) self = wSelf;
        self.modelDismissWhenTouchedBackground = dismiss;
        return self;
    };
}

- (NNConfigFloatHandler)shadowRadius {
    
    __weak typeof(self) wSelf = self;
    return ^(CGFloat value) {
        __strong typeof(wSelf) self = wSelf;
        self.modelShadowRadius = value;
        return self;
    };
}

- (NNConfigFloatHandler)shadowOpacity {
    
    __weak typeof(self) wSelf = self;
    return ^(CGFloat value) {
        __strong typeof(wSelf) self = wSelf;
        self.modelShadowOpacity = value;
        return self;
    };
}

- (NNConfigSizeHandler)shadowOffset {
    
    __weak typeof(self) wSelf = self;
    return ^(CGSize offset) {
        __strong typeof(wSelf) self = wSelf;
        self.modelShadowOffset = offset;
        return self;
    };
}

- (NNConfigColorHandler)shadowColor {
    
    __weak typeof(self) wSelf = self;
    return ^(UIColor *value) {
        __strong typeof(wSelf) self = wSelf;
        self.modelShadowColor = value;
        return self;
    };
}

- (NNConfigBOOLHandler)queue {
    
    __weak typeof(self) wSelf = self;
    return ^(BOOL value) {
        __strong typeof(wSelf) self = wSelf;
        self.modelIsQueue = value;
        return self;
    };
}

- (NNConfigBOOLHandler)continueQueueDisplay {
    
    __weak typeof(self) wSelf = self;
    return ^(BOOL value) {
        __strong typeof(wSelf) self = wSelf;
        self.modelIsContinueQueueDisplay = value;
        return self;
    };
}

- (NNConfigIntegerHandler)priority {
    
    __weak typeof(self) wSelf = self;
    return ^(NSInteger value) {
        __strong typeof(wSelf) self = wSelf;
        self.modelQueuePriority = MAX(value, 0);
        return self;
    };
}

- (NNConfigIntegerHandler)windowLevel {
    
    __weak typeof(self) wSelf = self;
    return ^(NSInteger value) {
        __strong typeof(wSelf) self = wSelf;
        self.modelWindowLevel = value;
        return self;
    };
}

- (NNConfigBOOLHandler)shouldAutoRotate {
    
    __weak typeof(self) wSelf = self;
    return ^(BOOL value) {
        __strong typeof(wSelf) self = wSelf;
        self.modelShouldAutoRotate = value;
        return self;
    };
}

- (NNConfigInterfaceOrientationMaskHandler)supportedInterfaceOrientationMask {
    
    __weak typeof(self) wSelf = self;
    return ^(UIInterfaceOrientationMask value) {
        __strong typeof(wSelf) self = wSelf;
        self.modelInterfaceOrientationMask = value;
        return self;
    };
}

- (NNAlertConfig *(^)(void(^)(NNEmptyHandler, NNEmptyHandler)))showAnimationHandler {
    
    __weak typeof(self) wSelf = self;
    return ^(void(^handler)(NNEmptyHandler, NNEmptyHandler)) {
        __strong typeof(wSelf) self = wSelf;
        if (handler) { self.modelShowingAnimationHandler = handler; }
        return self;
    };
}

- (NNAlertConfig *(^)(void(^)(NNEmptyHandler, NNEmptyHandler)))dismissAnimationHandler {
    
    __weak typeof(self) wSelf = self;
    return ^(void(^handler)(NNEmptyHandler, NNEmptyHandler)) {
        __strong typeof(wSelf) self = wSelf;
        if (handler) { self.modelDismissingAnimationHandler = handler; }
        return self;
    };
}

- (NNAlertConfig *(^)(NNAlertAnimationStyle))showAnimationStyle {
    
    __weak typeof(self) wSelf = self;
    return ^(NNAlertAnimationStyle style) {
        __strong typeof(wSelf) self = wSelf;
        self.modelShowingAnimationStyle = style;
        return self;
    };
}

- (NNAlertConfig *(^)(NNAlertAnimationStyle))dismissAnimationStyle {
    
    __weak typeof(self) wSelf = self;
    return ^(NNAlertAnimationStyle style) {
        __strong typeof(wSelf) self = wSelf;
        self.modelDismissingAnimationStyle = style;
        return self;
    };
}

- (NNConfigBlockHandler)completedHandler {
    
    __weak typeof(self) wSelf = self;
    return ^(NNEmptyHandler handler) {
        __strong typeof(wSelf) self = wSelf;
        if (handler) { self.modelCompletedHandler = handler; }
        return self;
    };
}

- (NNAlertConfig *(^)(void))show {
    __weak typeof(self) wSelf = self;
    return ^{
        __strong typeof(wSelf) self = wSelf;
        self.modelConfigCompletedHandler ? self.modelConfigCompletedHandler() : nil;
        return self;
    };
}

/// ========================================
/// @name   ⚠️ alert 相关特殊设置
/// ========================================

- (NNConfigBlockTextFieldHandler)addTextField {
    
    __weak typeof(self) wSelf = self;
    return ^(void (^handler)(UITextField *)) {
        __strong typeof(wSelf) self = wSelf;
        return self.addItem(^(NNAlertItem *item) {
            NSAssert((self.style == NNAlertStyleAlert), @"should only used in [NNAlert alert]");
            item.mode = NNAlertItemModeTextField;
            item.handler = handler;
        });
    };
}

- (NNConfigBOOLHandler)avoidKeyboard {
    
    __weak typeof(self) wSelf = self;
    return ^(BOOL value) {
        __strong typeof(wSelf) self = wSelf;
        NSAssert((self.style == NNAlertStyleAlert), @"should only used in [NNAlert alert]");
        self.modelIsAvoidKeyboard = value;
        return self;
    };
}

/// ========================================
/// @name   ⚠️ actionSheet 相关特殊设置
/// ========================================

- (NNConfigFloatHandler)actionSheetCancelActionSpaceHeight {
    
    __weak typeof(self) wSelf = self;
    return ^(CGFloat value) {
        __strong typeof(wSelf) self = wSelf;
        NSAssert((self.style == NNAlertStyleActionSheet), @"should only used in [NNAlert actionSheet]");
        self.modelActionSheetCancelActionSpaceHeight = value;
        return self;
    };
}

- (NNConfigFloatHandler)actionSheetMarginBottom {
    
    __weak typeof(self) wSelf = self;
    return ^(CGFloat value) {
        __strong typeof(wSelf) self = wSelf;
        NSAssert((self.style == NNAlertStyleActionSheet), @"should only used in [NNAlert actionSheet]");
        self.modelActionSheetCanncelActionBottomMargin = value;
        return self;
    };
}


- (NNConfigColorHandler)actionSheetCancelActionSpaceColor {
    
    __weak typeof(self) wSelf = self;
    return ^(UIColor *value) {
        __strong typeof(wSelf) self = wSelf;
        NSAssert((self.style == NNAlertStyleActionSheet), @"should only used in [NNAlert actionSheet]");
        self.modelActionSheetCancelActionSpaceColor = value;
        return self;
    };
}

@end

@implementation NNAlertAction

- (instancetype)init {
    
    if (self = [super init]) {
        self.font = [UIFont systemFontOfSize:18.f];
        self.text = @"按钮";
        self.textColor = [UIColor colorWithRed:21/255.0f green:123/255.0f blue:245/255.0f alpha:1.0f];
        self.backgroundColor = [UIColor clearColor];
        self.highlightBackgroundColor = [UIColor colorWithWhite:0.97 alpha:1.0f];
        
        self.borderColor = [UIColor colorWithWhite:.84f alpha:1.0f];
        self.borderWidth = (1.f/[UIScreen mainScreen].scale + .02f);
        self.borderPosition = 0;
        self.height = 45.f;
        self.dismissAlertWhenTriggered = YES;
        self.style = NNAlertActionStyleDefault;
    }
    return self;
}

- (void)setNeedsUpdate { if (self.updateHandler) { self.updateHandler(self); } }
@end

@interface NNAlertItem ()
@property (strong, nonatomic) void(^updateHandler)(NNAlertItem *);
@end

@implementation NNAlertItem
- (void)setNeedsUpdate { if (self.updateHandler) { self.updateHandler(self); } }
@end

@interface NNAlertItemView : UIView
@property (strong, nonatomic) NNAlertItem *item;
+ (NNAlertItemView *)itemView;
@end

@implementation NNAlertItemView
+ (NNAlertItemView *)itemView { return [[NNAlertItemView alloc] init]; }
@end

@interface NNAlertItemLabel : UILabel
@property (strong, nonatomic) NNAlertItem *item;
@property (strong, nonatomic) void(^textChangedHandler)(void);
+ (NNAlertItemLabel *)itemLabel;
@end

@implementation NNAlertItemLabel

#pragma mark - Life Cycle
+ (NNAlertItemLabel *)itemLabel {
    
    NNAlertItemLabel *itemLabel = [[NNAlertItemLabel alloc] init];
    itemLabel.textAlignment = NSTextAlignmentCenter;
    itemLabel.font = [UIFont systemFontOfSize:18.f];
    itemLabel.textColor = [UIColor blackColor];
    itemLabel.numberOfLines = 0;
    return itemLabel;
}

#pragma mark - Setter
- (void)setText:(NSString *)text {
    [super setText:text];
    self.textChangedHandler ? self.textChangedHandler() : nil;
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    self.textChangedHandler ? self.textChangedHandler() : nil;
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    self.textChangedHandler ? self.textChangedHandler() : nil;
}

- (void)setNumberOfLines:(NSInteger)numberOfLines {
    [super setNumberOfLines:numberOfLines];
    self.textChangedHandler ? self.textChangedHandler() : nil;
}

@end

@interface NNAlertItemTextField : UITextField
@property (strong, nonatomic) NNAlertItem *item;
+ (NNAlertItemTextField *)alertTextField;
@end

@implementation NNAlertItemTextField
+ (NNAlertItemTextField *)alertTextField {
    
    NNAlertItemTextField *textField = [[NNAlertItemTextField alloc] init];
    textField.frame = CGRectMake(0, 0, 0, 40.f);
    textField.borderStyle = UITextBorderStyleRoundedRect;
    return textField;
}
@end

@implementation NNAlertActionButton

#pragma mark - Life Cycle
+ (NNAlertActionButton *)buttonWithAction:(NNAlertAction *)action {
    NNAlertActionButton *button = [NNAlertActionButton buttonWithType:UIButtonTypeCustom];
    button.action = action;
    return button;
}
#pragma mark - Override Methods
- (void)layoutSubviews {
    
    [super layoutSubviews];
    if (self.topLayer.superlayer) self.topLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.action.borderWidth);
    if (self.bottomLayer.superlayer) self.bottomLayer.frame = CGRectMake(0, self.frame.size.height - self.borderWidth, self.frame.size.width, self.action.borderWidth);
    if (self.leftLayer.superlayer) self.leftLayer.frame = CGRectMake(0, 0, self.action.borderWidth, self.frame.size.height);
    if (self.rightLayer.superlayer) self.rightLayer.frame = CGRectMake(self.frame.size.width - self.action.borderWidth, 0, self.action.borderWidth, self.frame.size.height);
}
#pragma mark - Setter
- (void)setAction:(NNAlertAction *)action {

    if (_action && _action.updateHandler) { _action.updateHandler = nil; }
    _action = action;

    __weak typeof(self) wSelf = self;
    _action.updateHandler = ^(NNAlertAction *action) {
        __strong typeof(wSelf) self = wSelf;
        self.action = action;
    };
    
    self.clipsToBounds = YES;
    
    // config title
    [self.titleLabel setFont:action.font ? : [UIFont systemFontOfSize:15.f]];
    [self setTitle:action.text forState:UIControlStateNormal];
    [self setTitleColor:action.textColor forState:UIControlStateNormal];
    [self setAttributedTitle:action.attributedText forState:UIControlStateNormal];
    
    // config highlight title
    [self setTitle:action.highlightText forState:UIControlStateHighlighted];
    [self setTitleColor:action.highlightTextColor forState:UIControlStateHighlighted];
    [self setAttributedTitle:action.highlightAttributedText forState:UIControlStateHighlighted];
    
    // config image
    [self setImage:action.image forState:UIControlStateNormal];
    [self setImage:action.highlightImage forState:UIControlStateHighlighted];
    
    [self setImageEdgeInsets:action.imageEdgeInsets];
    [self setTitleEdgeInsets:action.textEdgeInsets];
    
    // config background
    [self setBackgroundImage:[UIImage nn_imageWithColor:action.backgroundColor] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage nn_imageWithColor:action.highlightBackgroundColor] forState:UIControlStateHighlighted];
    
    // config height
    BOOL isHeightChanged = !(self.frame.size.height == action.height);
    self.height = action.height;
    if (isHeightChanged && self.heightChangedHandler) { self.heightChangedHandler(); }
    
    // config cornerRadius
    self.layer.cornerRadius = action.cornerRadius;
    self.layer.masksToBounds = action.cornerRadius > 0;

    // config border
    if (action.borderPosition == NNAlertBorderPositionMaskAll) {
        self.layer.borderColor = action.borderColor.CGColor;
        self.layer.borderWidth = action.borderWidth;
        
        [self.topLayer removeFromSuperlayer];
        [self.bottomLayer removeFromSuperlayer];
        [self.leftLayer removeFromSuperlayer];
        [self.rightLayer removeFromSuperlayer];
    } else {
        self.layer.borderColor = [UIColor clearColor].CGColor;
        self.layer.borderWidth = .0f;
        
        if (action.borderPosition & NNAlertBorderPositionTop) {
            self.topLayer.backgroundColor = action.borderColor.CGColor;
            [self.layer addSublayer:self.topLayer];
        } else { [self.topLayer removeFromSuperlayer]; }
        
        if (action.borderPosition & NNAlertBorderPositionBottom) {
            self.bottomLayer.backgroundColor = action.borderColor.CGColor;
            [self.layer addSublayer:self.bottomLayer];
        } else { [self.bottomLayer removeFromSuperlayer]; }

        if (action.borderPosition & NNAlertBorderPositionLeft) {
            self.leftLayer.backgroundColor = action.borderColor.CGColor;
            [self.layer addSublayer:self.leftLayer];
        } else { [self.leftLayer removeFromSuperlayer]; }

        if (action.borderPosition & NNAlertBorderPositionRight) {
            self.rightLayer.backgroundColor = action.borderColor.CGColor;
            [self.layer addSublayer:self.rightLayer];
        } else { [self.rightLayer removeFromSuperlayer]; }
    }
}

#pragma mark - Getter

- (CALayer *)topLayer {
    
    if (!_topLayer) _topLayer = [CALayer layer];
    return _topLayer;
}

- (CALayer *)bottomLayer {
    
    if (!_bottomLayer) _bottomLayer = [CALayer layer];
    return _bottomLayer;
}

- (CALayer *)leftLayer {
    
    if (!_leftLayer) _leftLayer = [CALayer layer];
    return _leftLayer;
}

- (CALayer *)rightLayer {
    
    if (!_rightLayer) _rightLayer = [CALayer layer];
    return _rightLayer;
}

@end

@implementation NNAlertCustomView

#pragma mark - Life Cycle
- (void)dealloc {
    
#if DEBUG
    NSLog(@"%@ is %@ing", self, NSStringFromSelector(_cmd));
#endif
    if (self.isFrameObserved) {  [self.contentView removeObserver:self forKeyPath:@"frame"]; }
}

#pragma mark - Override Methods
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {

    if (object == self.contentView && [keyPath isEqualToString:@"frame"]) {
        if (!CGSizeEqualToSize(self.storedViewSize, self.contentView.size)) {
            self.storedViewSize = self.contentView.size;
            self.sizeChangedHandler ? self.sizeChangedHandler() : nil;
        }
    }
}

#pragma mark - Setter
- (void)setSizeChangedHandler:(void (^)(void))sizeChangedHandler {
    
    _sizeChangedHandler = sizeChangedHandler;
    if (self.contentView) {
        [self.contentView layoutSubviews];
        self.storedViewSize = self.contentView.size;
        [self.contentView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
        self.frameObserved = YES;
    }
}

#pragma mark - Getter
- (BOOL)isFrameObserved { return _frameObserved; }
- (BOOL)isAutoresizingWidth { return _autoresizingWidth; }

@end

@implementation NNAlertWindow
@end

@implementation NNAlertBaseController

#pragma mark - Life Cycle

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.showedHandler = self.dismissedHandler = nil;
    self.backgroundEffectView = nil;
    self.customView = nil;
    self.keywindow =  nil;
    
    [self.items removeAllObjects];
    [self.actionButtons removeAllObjects];
    [self.scrollView removeFromSuperview];
    [self.containerView removeFromSuperview];
}

#pragma mark - Override Methods

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    if (self.config.modelBackgroundStyle == NNAlertBackgroundStyleBlurEffect) {
        self.backgroundEffectView = [[UIVisualEffectView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:self.backgroundEffectView];
    }
    self.view.backgroundColor = [self.config.modelBackgroundColor colorWithAlphaComponent:.0f];
    self.orientationStyle = SCREEN_HEIGHT > SCREEN_WIDTH ? NNAlertScreenOrientationVertical : NNAlertScreenOrientationHorizontal;
    
    self.items = [NSMutableArray array];
    self.actionButtons = [NSMutableArray array];

    self.containerView = [[UIView alloc] init];
    [self.containerView addSubview:self.scrollView];
    [self.view addSubview:self.containerView];
    
    [self setupAlertConfig];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (!(self.isShowing || self.isDismissing)) { [self updateViewLayout]; }
}

- (void)viewSafeAreaInsetsDidChange {
    
    [super viewSafeAreaInsetsDidChange];
    if (!(self.isShowing || self.isDismissing)) { [self updateViewLayout]; }
}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    if (self.backgroundEffectView) { self.backgroundEffectView.frame = self.view.frame; }
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    self.orientationStyle = SCREEN_HEIGHT > SCREEN_WIDTH ? NNAlertScreenOrientationVertical : NNAlertScreenOrientationHorizontal;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.config.modelDismissWhenTouchedBackground) [self dismissAnimationsWithCompletionHandler:NULL];
    [super touchesBegan:touches withEvent:event];
}

- (BOOL)shouldAutorotate { return self.config.modelShouldAutoRotate; }

- (UIInterfaceOrientationMask)supportedInterfaceOrientations { return self.config.modelInterfaceOrientationMask; }

#pragma mark - Public Methods

- (void)setupAlertConfig {
    
    // config background color for scrollView
    self.scrollView.backgroundColor = self.config.modelContentBackgroundColor;
    
    // config shadow for containerView
    self.containerView.shadowColor = self.config.modelShadowColor;
    self.containerView.shadowRadius = self.config.modelShadowRadius;
    self.containerView.shadowOffset = self.config.modelShadowOffset;
    self.containerView.shadowOpacity = self.config.modelShadowOpacity;
    
    // config cornerRadius for containerView and alertView
    self.containerView.cornerRadius = self.scrollView.cornerRadius = self.config.modelCornerRadius;
    
    __weak typeof(self) wSelf = self;
    [self.config.items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // get configed item
        NNAlertItemHandler itemHandler = obj;
        NNAlertItem *item = [[NNAlertItem alloc] init];
        
        if (itemHandler) { itemHandler(item); }
        NSValue *insetsValue = [self.config.itemInsetsInfos safeObjectForKey:itemHandler];
        if (insetsValue) { item.insets = [insetsValue UIEdgeInsetsValue]; }
        
        switch (item.mode) {
            case NNAlertItemModeTitle:
            {
                NNAlertItemLabel *itemLabel = [NNAlertItemLabel itemLabel];
                if (item.handler) { item.handler(itemLabel); }
                [self.scrollView addSubview:itemLabel];
                [self.items addObject:itemLabel];
                
                itemLabel.item = item;
                itemLabel.textChangedHandler = ^{
                    __strong typeof(wSelf) self = wSelf;
                    [self updateViewLayout];
                };
            }
                break;
            case NNAlertItemModeContent:
            {
                NNAlertItemLabel *itemLabel = [NNAlertItemLabel itemLabel];
                itemLabel.font = [UIFont systemFontOfSize:14.f];
                if (item.handler) { item.handler(itemLabel); }
                [self.scrollView addSubview:itemLabel];
                [self.items addObject:itemLabel];
                itemLabel.item = item;
                itemLabel.textChangedHandler = ^{
                    __strong typeof(wSelf) self = wSelf;
                    [self updateViewLayout];
                };
            }
                break;
            case NNAlertItemModeTextField:
            {
                NNAlertItemTextField *textField = [NNAlertItemTextField alertTextField];
                if (item.handler) { item.handler(textField); }
                [self.scrollView addSubview:textField];
                [self.items addObject:textField];
                textField.item = item;
            }
                break;
            case NNAlertItemModeCustomView:
            {
                NNAlertCustomView *customView = [[NNAlertCustomView alloc] init];
                if (item.handler) { item.handler(customView); }
                NSAssert(customView.contentView, @"you should config customView");
                [self.scrollView addSubview:customView.contentView];
                [self.items addObject:customView];
                customView.item = item;
                customView.sizeChangedHandler = ^{
                    __strong typeof(wSelf) self = wSelf;
                    [self updateViewLayout];
                };
            }
                break;
            default:
                NNLogW(@"unsupport alert item mode :%d",(int)item.mode);
                break;
        }
    }];
}

- (void)updateViewLayout { NNLogD(@"override write in you subclass"); }

- (void)updateViewItemsLayout {
    
    [UIView setAnimationsEnabled:NO];
    CGFloat maxWidth = self.config.modelMaxWidthHandler(self.orientationStyle);
    UIEdgeInsets contentInsets = self.config.modelContentInsets;
    self.viewHeight = contentInsets.top;
    
    [self.items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIView class]]) {
            
            NNAlertItemView *itemView = (NNAlertItemView *)obj;
            UIEdgeInsets itemInsets = itemView.item.insets;
            UIEdgeInsets safeAreaInsets = VIEW_SAFE_AREA_INSETS(itemView);
            itemView.left = contentInsets.left + itemInsets.left + safeAreaInsets.left;
            itemView.top = self.viewHeight + itemView.item.insets.top;
            itemView.width = maxWidth - itemView.left - contentInsets.right - itemInsets.right - safeAreaInsets.left - safeAreaInsets.right;
            if ([itemView isKindOfClass:[UILabel class]]) {
                itemView.height = [itemView sizeThatFits:CGSizeMake(itemView.width, CGFLOAT_MAX)].height;
            }
            self.viewHeight += (itemView.height + itemInsets.top + itemInsets.bottom);
        } else if ([obj isKindOfClass:[NNAlertCustomView class]]) {
            
            NNAlertCustomView *customView = (NNAlertCustomView *)obj;
            CGRect contentViewFrame = customView.contentView.frame;
            
            UIEdgeInsets itemInsets = customView.item.insets;
            if (customView.isAutoresizingWidth) {
                customView.position = NNAlertCustomViewPositionCenter;
                contentViewFrame.size.width = maxWidth - contentInsets.left - contentInsets.right - itemInsets.left - itemInsets.right;
            }
            
            contentViewFrame.origin.y = self.viewHeight + itemInsets.top;
            switch (customView.position) {
                case NNAlertCustomViewPositionLeft:
                    contentViewFrame.origin.x = contentInsets.left + itemInsets.left;
                    break;
                case NNAlertCustomViewPositionRight:
                    contentViewFrame.origin.x = maxWidth - contentViewFrame.size.width - contentInsets.right - itemInsets.right;
                    break;
                case NNAlertCustomViewPositionCenter:
                default:
                    contentViewFrame.origin.x = (maxWidth - contentViewFrame.size.width) * .5f;
                    break;
            }
            
            void(^tmpHandler)(void) = customView.sizeChangedHandler;
            customView.sizeChangedHandler = nil;
            customView.contentView.frame = contentViewFrame;
            customView.sizeChangedHandler = tmpHandler;
            self.viewHeight += (customView.contentView.height + itemInsets.top + itemInsets.bottom);
        }
    }];
    
    self.viewHeight += contentInsets.bottom;
    
    for (NNAlertActionButton *button in self.actionButtons) {
        
        button.left = button.action.insets.left;
        button.top = self.viewHeight + button.action.insets.top;
        button.width = maxWidth - button.action.insets.left - button.action.insets.right;
        self.viewHeight += (button.height + button.action.insets.top + button.action.insets.bottom);
    }
    [UIView setAnimationsEnabled:YES];
}

- (void)handleButtonAction:(NNAlertActionButton *)button {
    
    if (!button.action.dismissAlertWhenTriggered && button.action.style == NNAlertActionStyleDefault) {
        if (button.action.handler) { button.action.handler(button.action); }
    } else {
        __weak typeof(button) wButton = button;
        [self dismissAnimationsWithCompletionHandler:^{
            __strong typeof(wButton) sButton = wButton;
            if (sButton.action.handler) { sButton.action.handler(sButton.action); }
        }];
    }
}

#pragma mark - Private Methods

- (void)showAnimationsWithCompletionHandler:(NNEmptyHandler)handler {

    [self.keywindow endEditing:YES];
    [self.view setUserInteractionEnabled:NO];
}

- (void)dismissAnimationsWithCompletionHandler:(NNEmptyHandler)hander {

    [[NNAlert sharedManager].window endEditing:YES];
}

- (void)handleTapGes:(UITapGestureRecognizer *)tapges {
    if (self.config.modelDismissWhenTouchedContent) { [self dismissAnimationsWithCompletionHandler:NULL]; }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return (touch.view == self.scrollView);
}

#pragma mark - Getter

- (UIWindow *)keywindow {
    
    if (!_keywindow) { _keywindow = [NNAlert sharedManager].mainWindow; }
    if (!_keywindow) { _keywindow = [UIApplication sharedApplication].keyWindow; }
    if (_keywindow.windowLevel != UIWindowLevelNormal) {
        _keywindow = [[UIApplication sharedApplication].windows fetchOneObject:^BOOL(__kindof UIWindow * _Nonnull obj) {
            return (obj.windowLevel == UIWindowLevelNormal && (obj.hidden == NO));
        }];
    }
    if (![NNAlert sharedManager].mainWindow) { [NNAlert configAlertMainWindow:_keywindow]; }
    return _keywindow;
}

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.directionalLockEnabled = YES;
        _scrollView.bounces = NO;
        
        UITapGestureRecognizer *tapges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGes:)];
        tapges.delegate = (id<UIGestureRecognizerDelegate>)self;
        [_scrollView addGestureRecognizer:tapges];
        _scrollView.userInteractionEnabled = YES;
    }
    return _scrollView;
}

- (BOOL)isShowing { return _showing; }
- (BOOL)isDismissing { return _dismissing; }

@end

@implementation NNAlertController

#pragma mark - Life Cycle

- (void)dealloc { [[NSNotificationCenter defaultCenter] removeObserver:self]; }

#pragma mark - Override Methods

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark - Private Methods

- (void)showAnimationsWithCompletionHandler:(NNEmptyHandler)handler{
    
    [super showAnimationsWithCompletionHandler:handler];
    if (self.isShowing) return;
    self.showing = YES;
    
    // calculate start frame
    CGRect containerFrame = self.containerView.frame;
    if (self.config.modelShowingAnimationStyle & NNAlertAnimationStyleNone) {
        containerFrame.origin.x = (SCREEN_WIDTH - containerFrame.size.width) * .5f;
        containerFrame.origin.y = (SCREEN_HEIGHT - containerFrame.size.height) * .5f;
    } else if (self.config.modelShowingAnimationStyle & NNAlertAnimationStyleFromTop) {
        containerFrame.origin.x = (SCREEN_WIDTH - containerFrame.size.width) * 0.5f;
        containerFrame.origin.y = 0 - containerFrame.size.height;
    } else if (self.config.modelShowingAnimationStyle & NNAlertAnimationStyleFromBottom) {
        containerFrame.origin.x = (SCREEN_WIDTH - containerFrame.size.width) * 0.5f;
        containerFrame.origin.y = SCREEN_HEIGHT;
    } else if (self.config.modelShowingAnimationStyle & NNAlertAnimationStyleFromLeft) {
        containerFrame.origin.x = 0 - containerFrame.size.width;
        containerFrame.origin.y = (SCREEN_HEIGHT - containerFrame.size.height) * .5f;
    } else if (self.config.modelShowingAnimationStyle & NNAlertAnimationStyleFromRight) {
        containerFrame.origin.x = SCREEN_WIDTH;
        containerFrame.origin.y = (SCREEN_HEIGHT - containerFrame.size.height) * .5f;
    }
    self.containerView.frame = containerFrame;
    
    // calcluate start value
    if (self.config.modelShowingAnimationStyle & NNAlertAnimationStyleFade) { self.containerView.alpha = .0f; }
    if (self.config.modelShowingAnimationStyle & NNAlertAnimationStyleEnlarge) { self.containerView.transform = CGAffineTransformMakeScale(.6f, .6f); }
    if (self.config.modelShowingAnimationStyle & NNAlertAnimationStyleShrink) { self.containerView.transform = CGAffineTransformMakeScale(1.2f, 1.2f); }

    __weak typeof(self) wSelf = self;
    if (self.config.modelShowingAnimationHandler) {
        
        self.config.modelShowingAnimationHandler(^{

            __strong typeof(wSelf) self = wSelf;
            if (self.config.modelBackgroundStyle == NNAlertBackgroundStyleTranslucent) {
                self.view.backgroundColor = [self.view.backgroundColor colorWithAlphaComponent:self.config.modelBackgroundAlpha];
            } else if (self.config.modelBackgroundStyle == NNAlertBackgroundStyleBlurEffect) {
                self.backgroundEffectView.effect = [UIBlurEffect effectWithStyle:self.config.modelBlurEffectStyle];
            }
            self.containerView.left = (SCREEN_WIDTH - self.containerView.width) * 0.5f;
            self.containerView.top = (SCREEN_HEIGHT - self.containerView.height) * 0.5f;
            self.containerView.alpha = 1.f;
            self.containerView.transform = CGAffineTransformIdentity;
        }, ^{
            __strong typeof(wSelf) self = wSelf;
            self.showing = NO;
            self.view.userInteractionEnabled = YES;
            if (handler) { handler(); }
            if (self.showedHandler) { self.showedHandler(); }
        });
    }
}

- (void)dismissAnimationsWithCompletionHandler:(NNEmptyHandler)handler {
    
    [super dismissAnimationsWithCompletionHandler:handler];
    if (self.isDismissing) { return; }
    self.dismissing = YES;
    if (self.config.modelDismissingAnimationHandler) {
        __weak typeof(self) wSelf = self;
        self.config.modelDismissingAnimationHandler(^{
            __strong typeof(wSelf) self = wSelf;
            
            if (self.config.modelBackgroundStyle == NNAlertBackgroundStyleTranslucent) {
                self.view.backgroundColor = [self.view.backgroundColor colorWithAlphaComponent:.0f];
            } else if (self.config.modelBackgroundStyle == NNAlertBackgroundStyleBlurEffect) {
                self.backgroundEffectView.alpha = 0.0f;
            }

            // calculate end frame
            CGRect containerFrame = self.containerView.frame;
            if (self.config.modelDismissingAnimationStyle & NNAlertAnimationStyleNone) {
                containerFrame.origin.x = (SCREEN_WIDTH - containerFrame.size.width) * .5f;
                containerFrame.origin.y = (SCREEN_HEIGHT - containerFrame.size.height) * .5f;
            } else if (self.config.modelDismissingAnimationStyle & NNAlertAnimationStyleFromTop) {
                containerFrame.origin.x = (SCREEN_WIDTH - containerFrame.size.width) * 0.5f;
                containerFrame.origin.y = 0 - containerFrame.size.height;
            } else if (self.config.modelDismissingAnimationStyle & NNAlertAnimationStyleFromBottom) {
                containerFrame.origin.x = (SCREEN_WIDTH - containerFrame.size.width) * 0.5f;
                containerFrame.origin.y = SCREEN_HEIGHT;
            } else if (self.config.modelDismissingAnimationStyle & NNAlertAnimationStyleFromLeft) {
                containerFrame.origin.x = 0 - containerFrame.size.width;
                containerFrame.origin.y = (SCREEN_HEIGHT - containerFrame.size.height) * .5f;
            } else if (self.config.modelDismissingAnimationStyle & NNAlertAnimationStyleFromRight) {
                containerFrame.origin.x = SCREEN_WIDTH;
                containerFrame.origin.y = (SCREEN_HEIGHT - containerFrame.size.height) * .5f;
            }
            self.containerView.frame = containerFrame;

            if (self.config.modelDismissingAnimationStyle & NNAlertAnimationStyleFade) {
                self.containerView.alpha = .0f;
            }
            if (self.config.modelDismissingAnimationStyle & NNAlertAnimationStyleEnlarge) {
                self.containerView.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
            }
            if (self.config.modelDismissingAnimationStyle & NNAlertAnimationStyleShrink) {
                self.containerView.transform = CGAffineTransformMakeScale(.6f, .6f);
            }
        }, ^{
            self.dismissing = NO;
            if (handler) { handler(); }
            if (self.dismissedHandler) { self.dismissedHandler(); }
        });
    }
}

- (void)handleKeyboardWillChangeFrame:(NSNotification *)notification {

    if (self.config.modelIsAvoidKeyboard) {

        double duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        self.keyboardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        self.keyboardShowing = self.keyboardFrame.origin.y < SCREEN_HEIGHT;
        [UIView beginAnimations:@"keyboardWillChangeFrame" context:NULL];
        [UIView setAnimationDuration:duration];
        [self updateViewLayout];
        [UIView commitAnimations];
    }
}

- (void)updateViewLayout {
    
    CGFloat viewWidth = SCREEN_WIDTH;
    CGFloat viewHeight = SCREEN_HEIGHT;
    CGFloat maxWidth = self.config.modelMaxWidthHandler(self.orientationStyle);
    CGFloat maxHeight = self.config.modelMaxHeightHandler(self.orientationStyle);
    [self updateViewItemsLayout];
    if (self.isKeyboardShowing) {
        if (self.keyboardFrame.size.height) {
            UIEdgeInsets safeAreaInsets = VIEW_SAFE_AREA_INSETS(self.view);
            self.scrollView.height = MIN((maxHeight - self.keyboardFrame.size.height), self.viewHeight);
            self.scrollView.width = maxWidth;
            
            self.containerView.width = self.scrollView.width;
            self.containerView.height = self.scrollView.height;
            self.containerView.left = (viewWidth - self.scrollView.width) * 0.5f;
            self.containerView.top = MAX((self.keyboardFrame.origin.y - self.scrollView.height - safeAreaInsets.top), safeAreaInsets.top);;
            [self.scrollView scrollRectToVisible:[self.scrollView nn_firstResponder].frame animated:YES];
        }
    } else {
        
        self.scrollView.width = maxWidth;
        self.scrollView.height = MIN(self.viewHeight, maxHeight);
        
        self.containerView.width = self.scrollView.width;
        self.containerView.height = self.scrollView.height;
        self.containerView.left = (viewWidth - maxWidth) * 0.5f;
        self.containerView.top = (viewHeight - self.scrollView.height) * 0.5f;
        if (self.viewHeight > self.scrollView.height) {
            [self.scrollView scrollRectToVisible:CGRectMake(0, (self.viewHeight - self.scrollView.height), self.scrollView.width, self.scrollView.height) animated:YES];
        }
    }
}

- (void)updateViewItemsLayout {
 
    [super updateViewItemsLayout];
    
    [UIView setAnimationsEnabled:NO];
    // 特殊处理下2个按钮布局方式
    CGFloat maxWidth = self.config.modelMaxWidthHandler(self.orientationStyle);
    if (self.actionButtons.count == 2) {
        
        NNAlertActionButton *leftButton = (self.actionButtons.count == self.config.actions.count) ? [self.actionButtons firstObject] : [self.actionButtons lastObject];
        NNAlertActionButton *rightButton = (self.actionButtons.count == self.config.actions.count) ? [self.actionButtons lastObject] : [self.actionButtons firstObject];
        
        UIEdgeInsets leftButtonInsets = leftButton.action.insets;
        UIEdgeInsets rightButtonInsets = rightButton.action.insets;
        CGFloat leftButtonHeight = leftButton.height + leftButtonInsets.top + leftButtonInsets.bottom;
        CGFloat rightButtonHeight = rightButton.height + rightButtonInsets.top + rightButtonInsets.bottom;
        
        CGFloat minY = MIN((leftButton.top - leftButtonInsets.top), (rightButton.top - rightButtonInsets.top));
        
        leftButton.frame = CGRectMake(leftButtonInsets.left, minY + leftButtonInsets.top, (maxWidth/2.f - leftButtonInsets.left - leftButtonInsets.right), leftButton.height);
        rightButton.frame = CGRectMake(rightButtonInsets.left + maxWidth/2.f, minY + rightButtonInsets.top, (maxWidth/2.f - rightButtonInsets.left - rightButtonInsets.right), rightButton.height);
        self.viewHeight -= MIN(leftButtonHeight, rightButtonHeight);
    }
    
    [self.scrollView setContentSize:CGSizeMake(maxWidth, self.viewHeight)];
    [UIView setAnimationsEnabled:YES];
}

- (void)setupAlertConfig {
    
    [super setupAlertConfig];

    __weak typeof(self) wSelf = self;
    [self.config.actions enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        __strong typeof(wSelf) self = wSelf;
        NNAlertActionHandler handler = obj;
        NNAlertAction *action = [[NNAlertAction alloc] init];
        if (handler) { handler(action); }
        
        if (action.borderPosition == NNAlertBorderPositionNone) {
            if (self.config.actions.count == 2 && idx == 0) { action.borderPosition = NNAlertBorderPositionTop | NNAlertBorderPositionRight; }
            else { action.borderPosition = NNAlertBorderPositionTop;  }
        }
        NNAlertActionButton *actionButton = [NNAlertActionButton buttonWithAction:action];
        [actionButton  addTarget:self action:@selector(handleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.scrollView addSubview:actionButton];
        [self.actionButtons addObject:actionButton];
        actionButton.heightChangedHandler = ^{
            __strong typeof(wSelf) self = wSelf;
            [self updateViewLayout];
        };
    }];
    
    [self updateViewLayout];
    [self showAnimationsWithCompletionHandler:^{
        __strong typeof(wSelf) self = wSelf;
        [self updateViewLayout];
    }];
}

#pragma mark - Getter

- (BOOL)isKeyboardShowing { return _keyboardShowing; }

@end


@implementation NNActionSheetController

#pragma mark - Life Cycle

#pragma mark - Override Methods

#pragma mark - Private Methods

- (void)showAnimationsWithCompletionHandler:(NNEmptyHandler)handler{
    
    [super showAnimationsWithCompletionHandler:handler];
    if (self.isShowing) return;
    self.showed = self.showing = YES;
    
    // calculate start frame
    CGRect containerFrame = self.containerView.frame;
    if (self.config.modelDismissingAnimationStyle == NNAlertAnimationStyleNone) {
        containerFrame.origin.x = (SCREEN_WIDTH - containerFrame.size.width) * .5f;
        containerFrame.origin.y = SCREEN_HEIGHT - containerFrame.size.height - self.config.modelActionSheetCanncelActionBottomMargin;
    } else if (self.config.modelShowingAnimationStyle & NNAlertAnimationStyleFromTop) {
        containerFrame.origin.x = (SCREEN_WIDTH - containerFrame.size.width) * 0.5f;
        containerFrame.origin.y = 0 - containerFrame.size.height;
    } else if (self.config.modelShowingAnimationStyle & NNAlertAnimationStyleFromBottom) {
        containerFrame.origin.x = (SCREEN_WIDTH - containerFrame.size.width) * 0.5f;
        containerFrame.origin.y = SCREEN_HEIGHT;
    } else if (self.config.modelShowingAnimationStyle & NNAlertAnimationStyleFromLeft) {
        containerFrame.origin.x = 0 - containerFrame.size.width;
        containerFrame.origin.y = (SCREEN_HEIGHT - containerFrame.size.height) - self.config.modelActionSheetCanncelActionBottomMargin;
    } else if (self.config.modelShowingAnimationStyle & NNAlertAnimationStyleFromRight) {
        containerFrame.origin.x = SCREEN_WIDTH;
        containerFrame.origin.y = (SCREEN_HEIGHT - containerFrame.size.height) - self.config.modelActionSheetCanncelActionBottomMargin;;
    }
    self.containerView.frame = containerFrame;
    
    // calcluate start value
    if (self.config.modelShowingAnimationStyle & NNAlertAnimationStyleFade) { self.containerView.alpha = .0f; }
    if (self.config.modelShowingAnimationStyle & NNAlertAnimationStyleEnlarge) { self.containerView.transform = CGAffineTransformMakeScale(.6f, .6f); }
    if (self.config.modelShowingAnimationStyle & NNAlertAnimationStyleShrink) { self.containerView.transform = CGAffineTransformMakeScale(1.2f, 1.2f); }
    
    __weak typeof(self) wSelf = self;
    if (self.config.modelShowingAnimationHandler) {
        
        self.config.modelShowingAnimationHandler(^{
            
            __strong typeof(wSelf) self = wSelf;
            if (self.config.modelBackgroundStyle == NNAlertBackgroundStyleTranslucent) {
                self.view.backgroundColor = [self.view.backgroundColor colorWithAlphaComponent:self.config.modelBackgroundAlpha];
            } else if (self.config.modelBackgroundStyle == NNAlertBackgroundStyleBlurEffect) {
                self.backgroundEffectView.effect = [UIBlurEffect effectWithStyle:self.config.modelBlurEffectStyle];
            }
            self.containerView.left = (SCREEN_WIDTH - self.containerView.width) * 0.5f;
            self.containerView.top = SCREEN_HEIGHT - self.containerView.height - self.config.modelActionSheetCanncelActionBottomMargin;
            self.containerView.alpha = 1.f;
            self.containerView.transform = CGAffineTransformIdentity;
        }, ^{
            __strong typeof(wSelf) self = wSelf;
            self.showing = NO;
            self.view.userInteractionEnabled = YES;
            if (handler) { handler(); }
            if (self.showedHandler) { self.showedHandler(); }
        });
    }
}

- (void)dismissAnimationsWithCompletionHandler:(NNEmptyHandler)handler {
    
    [super dismissAnimationsWithCompletionHandler:handler];
    if (self.isDismissing) { return; }
    self.showed = NO;
    self.dismissing = YES;
    if (self.config.modelDismissingAnimationHandler) {
        __weak typeof(self) wSelf = self;
        self.config.modelDismissingAnimationHandler(^{
            __strong typeof(wSelf) self = wSelf;
            
            if (self.config.modelBackgroundStyle == NNAlertBackgroundStyleTranslucent) {
                self.view.backgroundColor = [self.view.backgroundColor colorWithAlphaComponent:.0f];
            } else if (self.config.modelBackgroundStyle == NNAlertBackgroundStyleBlurEffect) {
                self.backgroundEffectView.alpha = 0.0f;
            }
            
            // calculate end frame
            CGRect containerFrame = self.containerView.frame;
            if (self.config.modelDismissingAnimationStyle & NNAlertAnimationStyleFromTop) {
                containerFrame.origin.x = (SCREEN_WIDTH - containerFrame.size.width) * 0.5f;
                containerFrame.origin.y = 0 - containerFrame.size.height;
            } else if (self.config.modelDismissingAnimationStyle & NNAlertAnimationStyleFromBottom) {
                containerFrame.origin.x = (SCREEN_WIDTH - containerFrame.size.width) * 0.5f;
                containerFrame.origin.y = SCREEN_HEIGHT;
            } else if (self.config.modelDismissingAnimationStyle & NNAlertAnimationStyleFromLeft) {
                containerFrame.origin.x = 0 - containerFrame.size.width;
                containerFrame.origin.y = (SCREEN_HEIGHT - containerFrame.size.height) * .5f;
            } else if (self.config.modelDismissingAnimationStyle & NNAlertAnimationStyleFromRight) {
                containerFrame.origin.x = SCREEN_WIDTH;
                containerFrame.origin.y = (SCREEN_HEIGHT - containerFrame.size.height) * .5f;
            }
            self.containerView.frame = containerFrame;
            
            if (self.config.modelDismissingAnimationStyle & NNAlertAnimationStyleFade) {
                self.containerView.alpha = .0f;
            }
            if (self.config.modelDismissingAnimationStyle & NNAlertAnimationStyleEnlarge) {
                self.containerView.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
            }
            if (self.config.modelDismissingAnimationStyle & NNAlertAnimationStyleShrink) {
                self.containerView.transform = CGAffineTransformMakeScale(.6f, .6f);
            }
        }, ^{
            self.dismissing = NO;
            if (handler) { handler(); }
            if (self.dismissedHandler) { self.dismissedHandler(); }
        });
    }
}

- (void)updateViewLayout {
    
    CGFloat viewWidth = SCREEN_WIDTH;
    CGFloat viewHeight = SCREEN_HEIGHT;
    CGFloat maxWidth = self.config.modelMaxWidthHandler(self.orientationStyle);
    [self updateViewItemsLayout];
    
    CGFloat cancelActionButtonHeight = self.cancelActionButton ? (self.cancelActionButton.action.height + self.config.modelActionSheetCancelActionSpaceHeight) : .0f;
    CGRect containerFrame = self.containerView.frame;
    containerFrame.size.width = self.scrollView.width;
    containerFrame.size.height = self.scrollView.height + cancelActionButtonHeight;
    containerFrame.origin.x = (viewWidth - maxWidth) * .5f;
    if (self.isShowed) { containerFrame.origin.y = viewHeight - containerFrame.size.height - self.config.modelActionSheetCanncelActionBottomMargin; }
    else { containerFrame.origin.y = SCREEN_HEIGHT; }
    self.containerView.frame = containerFrame;
}

- (void)updateViewItemsLayout {
    
    [super updateViewItemsLayout];
    
    [UIView setAnimationsEnabled:NO];
    // 特殊处理下2个按钮布局方式
    CGFloat maxWidth = self.config.modelMaxWidthHandler(self.orientationStyle);
    CGFloat maxHeight = self.config.modelMaxHeightHandler(self.orientationStyle);
    [self.scrollView setContentSize:CGSizeMake(maxWidth, self.viewHeight)];
    [UIView setAnimationsEnabled:YES];
    
    CGFloat cancelActionButtonHeight = self.cancelActionButton ? (self.cancelActionButton.action.height + self.config.modelActionSheetCancelActionSpaceHeight) : .0f;
    CGRect scrollViewFrame = self.scrollView.frame;
    scrollViewFrame.size.width = maxWidth;
    scrollViewFrame.size.height = (self.viewHeight > (maxHeight - cancelActionButtonHeight)) ? (maxHeight - cancelActionButtonHeight) : self.viewHeight;
    scrollViewFrame.origin.x = 0;
    self.scrollView.frame = scrollViewFrame;
    
    if (self.cancelActionButton) {
        
        self.cancelActionSpaceView.left = 0;
        self.cancelActionSpaceView.top = self.scrollView.top + self.scrollView.height;
        self.cancelActionSpaceView.width = maxWidth;
        self.cancelActionSpaceView.height = self.config.modelActionSheetCancelActionSpaceHeight;
        
        self.cancelActionButton.left = 0;
        self.cancelActionButton.top = self.scrollView.top + self.scrollView.height + self.cancelActionSpaceView.height;
        self.cancelActionButton.width = maxWidth;
    }
}

- (void)setupAlertConfig {
    
    [super setupAlertConfig];
    
    __weak typeof(self) wSelf = self;
    [self.config.actions enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        __strong typeof(wSelf) self = wSelf;
        NNAlertActionHandler handler = obj;
        NNAlertAction *action = [[NNAlertAction alloc] init];
        if (handler) { handler(action); }
        
        NNAlertActionButton *actionButton = [NNAlertActionButton buttonWithAction:action];
        
        switch (actionButton.action.style) {
            case NNAlertActionStyleCancel:
            {
                // config cancel aciton
                [actionButton  addTarget:self action:@selector(handleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                actionButton.cornerRadius = self.config.modelCornerRadius;
                actionButton.backgroundColor = (action.backgroundColor && ![action.backgroundColor isEqual:[UIColor clearColor]]) ? action.backgroundColor : [UIColor whiteColor];
                [self.containerView addSubview:actionButton];
                self.cancelActionButton = actionButton;
                
                // config space view
                if (!self.cancelActionSpaceView || !self.cancelActionSpaceView.superview) {
                    self.cancelActionSpaceView = [UIView new];
                    self.cancelActionSpaceView.backgroundColor = self.config.modelActionSheetCancelActionSpaceColor;
                    [self.containerView addSubview:self.cancelActionSpaceView];
                }
            }
                break;
            default:
            {
                if (actionButton.action.borderPosition == NNAlertBorderPositionNone) { actionButton.action.borderPosition = NNAlertBorderPositionTop; }
                [actionButton  addTarget:self action:@selector(handleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                [self.scrollView addSubview:actionButton];
                [self.actionButtons addObject:actionButton];
                
                actionButton.heightChangedHandler = ^{
                    __strong typeof(wSelf) self = wSelf;
                    [self updateViewLayout];
                };
            }
                break;
        }
    }];
    
    [self updateViewLayout];
    [self showAnimationsWithCompletionHandler:^{
        __strong typeof(wSelf) self = wSelf;
        [self updateViewLayout];
    }];
}

#pragma mark - Getter
- (BOOL)isShowed { return _showed; }
                                   
@end
