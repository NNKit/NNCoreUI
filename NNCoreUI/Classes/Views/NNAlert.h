//  NNAlert.h
//  Pods
//
//  Created by  XMFraker on 2017/12/6
//  Copyright © XMFraker All rights reserved. (https://github.com/ws00801526)
//  @class      NNAlert
//  @version    1.0.0
//  @abstract   <#class description#>
//  @discussion <#class functions#>

#import <UIKit/UIKit.h>
#import <NNCoreUI/NNAlertHelper.h>

NS_ASSUME_NONNULL_BEGIN

@interface NNAlert : NSObject

+ (NNAlertConfig *)alert;
+ (NNAlertConfig *)actionSheet;

+ (void)configAlertMainWindow:(UIWindow *)window;
/** continue show next alert in Queue */
+ (void)continueQueueDisplay;
/** dismiss current Alert And clear Queue, other Alerts in Queue will not be show */
+ (void)dismissAndClearQueue;
/** dismiss current Alert */
+ (void)dismissAlertWithCompletionHandler:(nullable NNEmptyHandler)handler;

@end

@interface NNAlertConfig : NSObject

/** config alert title @code .title(@"your alert title") @endcode */
@property (copy, nonatomic, readonly) NNConfigStringHandler title;
/** config alert content  @code .content(@"your alert content") @endcode */
@property (copy, nonatomic, readonly) NNConfigStringHandler content;
/** config alert customView @code .customView(yourView) @endcode */
@property (copy, nonatomic, readonly) NNConfigViewHandler customView;
/** config alert titleLabel @code .addTitle(^(UILabel *titleLabel) { your custom title config } ) @endcode  */
@property (copy, nonatomic, readonly) NNConfigBlockLabelHandler addTitle;
/** config alert contentLabel @code .addContent(^(UILabel *contentLabel) { your custom content config } ) @endcode */
@property (copy, nonatomic, readonly) NNConfigBlockLabelHandler addContent;
/** config alert customView @code .addCustomView(^(NNAlertCustomView *customView) { your custom config }) @endcode */
@property (copy, nonatomic, readonly) NNConfigBlockCustomViewHandler addCustomView;
/** config alert item @code .addItem(^(NNAlertItem * item) { your custom config }) @endcode */
@property (copy, nonatomic, readonly) NNConfigBlockItemHandler addItem;
/** config alert insets for content @code .contentInsets(your content insets) Default UIEdgeInsetsMake(20, 20, 20, 20) @endcode */
@property (copy, nonatomic, readonly) NNConfigEdgeInsetsHandler contentInsets;
/** config alert itemInsets for lastAddItem @code .itemInsets(your item insets) @endcode */
@property (copy, nonatomic, readonly) NNConfigEdgeInsetsHandler itemInsets;
/** config alert cornerRadius @code .cornerRadius(8.f) @endcode */
@property (copy, nonatomic, readonly) NNConfigFloatHandler cornerRadius;
/** config animation duration for show @code .showAnimationDuration(.3f) @endcode */
@property (copy, nonatomic, readonly) NNConfigFloatHandler showAnimationDuration;
/** config animation duration for dismiss @code .dismissAnimationDuration(.25f) @endcode */
@property (copy, nonatomic, readonly) NNConfigFloatHandler dismissAnimationDuration;
/** config alpha for background  @code .backgroundTranslucent(.45f) @endcode */
@property (copy, nonatomic, readonly) NNConfigFloatHandler backgroundTranslucent;
/** config blur effect style for background  @code .backgroundBlurEffectStyle(UIBlurEffectStyleLight) @endcode */
@property (copy, nonatomic, readonly) NNConfigBlurEffectStyleHandler backgroundBlurEffectStyle;
/** config background color for alert @code .backgroundColor([UIColor whiteColor]) @endcode */
@property (copy, nonatomic, readonly) NNConfigColorHandler backgroundColor;
/** config background color for content @code .contentBackgroundColor([UIColor whiteColor]) @endcode */
@property (copy, nonatomic, readonly) NNConfigColorHandler contentBackgroundColor;


/** config shadow offset  @code .shadowOffset(CGSizeMake(0.f, 2.f)) @endcode */
@property (copy, nonatomic, readonly) NNConfigSizeHandler shadowOffset;
/** config shadow opacity @code .shadowOpacity(.3f) @endcode */
@property (copy, nonatomic, readonly) NNConfigFloatHandler shadowOpacity;
/** config shadow radius  @code .shadowRadius(4.f) @endcode */
@property (copy, nonatomic, readonly) NNConfigFloatHandler shadowRadius;
/** config shadow color   @code .shadowColor([UIColor blackColor]) @endcode */
@property (copy, nonatomic, readonly) NNConfigColorHandler shadowColor;
/** config dismiss when touched background  @code .dismissWhenTouchedBackground(YES) @endcode */
@property (copy, nonatomic, readonly) NNConfigBOOLHandler dismissWhenTouchedBackground;
/** config dismiss when touched content     @code .dismissWhenTouchedContent(NO) @endcode */
@property (copy, nonatomic, readonly) NNConfigBOOLHandler dismissWhenTouchedContent;

/** config max width  @code .maxWidth(SCREEN_WIDTH - 40) @endcode */
@property (copy, nonatomic, readonly) NNConfigFloatHandler maxWidth;
/** config max height @code .maxHeight(SCREEN_HEIGHT - 40) @endcode */
@property (copy, nonatomic, readonly) NNConfigFloatHandler maxHeight;

/** config max width handler   @code .maxWidthHandler(CGFloat(^)(NNAlertScreenOrientation orientation)) { your max width } @endcode */
@property (copy, nonatomic, readonly) NNConfigFloatAndBlockHandler maxWidthHandler;

/** config max height handler  @code .maxHeightHandler(CGFloat(^)(NNAlertScreenOrientation orientation)) { your max height } @endcode */
@property (copy, nonatomic, readonly) NNConfigFloatAndBlockHandler maxHeightHandler;

/** config queue @code .queue(NO) @endcode */
@property (copy, nonatomic, readonly) NNConfigBOOLHandler       queue;
/** config continueQueueDisplay @code .continueQueueDisplay(YES) @endcode */
@property (copy, nonatomic, readonly) NNConfigBOOLHandler       continueQueueDisplay;
/** config priority @code .priority(0) @endcode */
@property (copy, nonatomic, readonly) NNConfigIntegerHandler    priority;
/** config window level @code .windowLevel(UIWindowLevelAlert) @endcode */
@property (copy, nonatomic, readonly) NNConfigIntegerHandler    windowLevel;
/** config shouldAutoRotate @code .shouldAutoRotate(YES) @endcode */
@property (copy, nonatomic, readonly) NNConfigBOOLHandler    shouldAutoRotate;
/** config supportedInterfaceOrientationMask @code .supportedInterfaceOrientationMask(UIInterfaceOrientationMaskAllButUpsideDown) @endcode */
@property (copy, nonatomic, readonly) NNConfigInterfaceOrientationMaskHandler    supportedInterfaceOrientationMask;

/** config showAnimationHandler @code .showAnimationHandler(^{ your showing handler },^{ your showed handler }) @endcode*/
@property (copy, nonatomic, readonly) NNConfigAnimationBlockHandler showAnimationHandler;
/** config dismissAnimationHandler @code .dismissAnimationHandler(^{ your dismissing handler },^{ your dismissed handler }) @endcode*/
@property (copy, nonatomic, readonly) NNConfigAnimationBlockHandler dismissAnimationHandler;
/** config showAnimationStyle @code .showAnimationStyle(NNAlertAnimationStyleFade | NNAlertAnimationStyleShrink) @endcode */
@property (copy, nonatomic, readonly) NNConfigAnimationStyleHandler showAnimationStyle;
/** config dismissAnimationStyle @code .dismissAnimationStyle(NNAlertAnimationStyleFade | NNAlertAnimationStyleShrink) @endcode */
@property (copy, nonatomic, readonly) NNConfigAnimationStyleHandler dismissAnimationStyle;

/** config default action @code .defaultAction(@"your action title") @endcode */
@property (copy, nonatomic, readonly) NNConfigStringAndBlockHandler defaultAction;
/** config cancel action @code .cancelAction(@"your cancel title") @endcode */
@property (copy, nonatomic, readonly) NNConfigStringAndBlockHandler cancelAction;
/** config destructive action @code .destructive(@"your destructive title") @endcode */
@property (copy, nonatomic, readonly) NNConfigStringAndBlockHandler destructiveAction;
/** config action @code .addAction(^(NNAlertAction *action) { your config handler }) @endcode */
@property (copy, nonatomic, readonly) NNConfigBlockActionHandler addAction;

/** show alert config @code .show() @endcode */
@property (copy, nonatomic, readonly) NNConfigHandler show;
/** config completedHandler @code .completedHandler(^ { your completed handler }) @endcode */
@property (copy, nonatomic, readonly) NNConfigBlockHandler completedHandler;

/**
 隐藏当前alert
 
 @param handler 完成回调
 */
- (void)dismissWithCompletionHandler:(nullable NNEmptyHandler)handler;

/// ========================================
/// @name   ⚠️ alert
/// ========================================

/** config textfield for alert @code .addTextField(^(UITextField *textField) { your config handler}) @endcode */
@property (copy, nonatomic, readonly) NNConfigBlockTextFieldHandler addTextField;
/** config avoidKeyboard for alert @code .avoidKeyboard(YES) @endcode */
@property (copy, nonatomic, readonly) NNConfigBOOLHandler avoidKeyboard;

/// ========================================
/// @name   ⚠️ actionSheet
/// ========================================

/** config action cancel action space height @code .actionSheetCancelActionSpaceHeight(10.f) @endcode */
@property (copy, nonatomic, readonly)   NNConfigFloatHandler actionSheetCancelActionSpaceHeight;
/** config action cancel action space color @code .actionSheetCancelActionSpaceColor([UIColor clearColor]) @endcode */
@property (copy, nonatomic, readonly)   NNConfigColorHandler actionSheetCancelActionSpaceColor;
/** config action cancel action margin bottom @code .actionSheetMarginBottom(10.f) @endcode */
@property (copy, nonatomic, readonly)   NNConfigFloatHandler actionSheetMarginBottom;

@end

@interface NNAlertAction : NSObject

@property (assign, nonatomic) NNAlertActionStyle style;
@property (strong, nonatomic) UIFont *font;
@property (copy, nonatomic)   NSString *text;
@property (strong, nonatomic) UIColor  *textColor;
@property (copy, nonatomic)   NSString *highlightText;
@property (strong, nonatomic) UIColor  *highlightTextColor;
@property (copy, nonatomic)   NSAttributedString *attributedText;
@property (copy, nonatomic)   NSAttributedString *highlightAttributedText;
@property (strong, nonatomic) UIColor  *backgroundColor;
@property (strong, nonatomic) UIColor  *highlightBackgroundColor;

@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) UIImage *highlightImage;

@property (assign, nonatomic) UIEdgeInsets insets;
@property (assign, nonatomic) UIEdgeInsets imageEdgeInsets;
@property (assign, nonatomic) UIEdgeInsets textEdgeInsets;

@property (assign, nonatomic) CGFloat cornerRadius;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat borderWidth;
@property (strong, nonatomic) UIColor *borderColor;
@property (assign, nonatomic) NNAlertBorderPosition borderPosition;

/** 点击事件触发后, 是否自动隐藏对应Alert, 默认为YES, 只针对 NNAlertActionStyleDefault有效 */
@property (assign, nonatomic) BOOL dismissAlertWhenTriggered;
@property (copy, nonatomic, nullable)   NNAlertActionHandler handler;

- (void)setNeedsUpdate;
@end

@interface NNAlertItem : NSObject

@property (assign, nonatomic) NNAlertItemMode mode;
@property (assign, nonatomic) UIEdgeInsets insets;
@property (copy, nonatomic, nullable)   void(^handler)(id view);

- (void)setNeedsUpdate;
@end

@interface NNAlertCustomView : NSObject

@property (strong, nonatomic) UIView *contentView;
/** contentView.position to superView Default NNAlertCustomViewPositionCenter*/
@property (assign, nonatomic) NNAlertCustomViewPosition position;
/** autoresizing contentView.frame to superView  Default NO */
@property (assign, nonatomic, getter=isAutoresizingWidth) BOOL autoresizingWidth;
@end

@interface NNAlertWindow : UIWindow @end

@interface NNAlertBaseController : UIViewController @end

@interface NNAlertController : NNAlertBaseController @end

@interface NNActionSheetController : NNAlertBaseController @end;

NS_ASSUME_NONNULL_END
