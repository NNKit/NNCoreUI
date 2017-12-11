//  NNAlertHelper.h
//  Pods
//
//  Created by  XMFraker on 2017/12/6
//  Copyright © XMFraker All rights reserved. (https://github.com/ws00801526)
//  @class      NNAlertHelper
//  @version    1.0.0
//  @abstract   <#class description#>
//  @discussion <#class functions#>

#ifndef NNAlertHelper_h
#define NNAlertHelper_h

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT double NNAlertVersionNumber;
FOUNDATION_EXPORT const unsigned char NNAlertVersionString[];


typedef NSUInteger NNAlertPriority NS_TYPED_EXTENSIBLE_ENUM;
static const NNAlertPriority NNAlertPriorityNone = 0;
static const NNAlertPriority NNAlertPriorityDefaultHigh = 750;
static const NNAlertPriority NNAlertPriorityDefaultLow = 250;

@class NNAlert;
@class NNAlertAction;
@class NNAlertConfig;
@class NNAlertItem;
@class NNAlertCustomView;

/** UIScreen.orientation */
typedef NS_ENUM(NSUInteger, NNAlertScreenOrientation) {
    NNAlertScreenOrientationHorizontal,
    NNAlertScreenOrientationVertical,
};

/** NNAlert.style */
typedef NS_ENUM(NSUInteger, NNAlertStyle) {
    NNAlertStyleAlert,
    NNAlertStyleActionSheet,
};

/** NNAlert.backgroundStyle */
typedef NS_ENUM(NSUInteger, NNAlertBackgroundStyle) {
    NNAlertBackgroundStyleTranslucent,
    NNAlertBackgroundStyleBlurEffect,
};

typedef NS_ENUM(NSUInteger, NNAlertCustomViewPosition) {
    NNAlertCustomViewPositionCenter,
    NNAlertCustomViewPositionLeft,
    NNAlertCustomViewPositionRight,
};

typedef NS_ENUM(NSUInteger, NNAlertItemMode) {
    NNAlertItemModeTitle,
    NNAlertItemModeContent,
    NNAlertItemModeTextField,
    NNAlertItemModeCustomView
};

typedef NS_OPTIONS(NSUInteger, NNAlertBorderPosition) {
    NNAlertBorderPositionNone = 0,
    NNAlertBorderPositionTop = 1 << 0,
    NNAlertBorderPositionLeft = 1 << 1,
    NNAlertBorderPositionBottom = 1 << 2,
    NNAlertBorderPositionRight = 1 << 4,
    NNAlertBorderPositionMaskAll = 0x1111
};

typedef NS_ENUM(NSUInteger, NNAlertActionStyle) {
    NNAlertActionStyleDefault,
    NNAlertActionStyleCancel,
    NNAlertActionStyleDestructive,
};

typedef NS_OPTIONS(NSUInteger, NNAlertAnimationStyle) {
    NNAlertAnimationStyleNone = 0,
    
    NNAlertAnimationStyleFromTop = 1 << 0,
    NNAlertAnimationStyleFromBottom = 1 << 1,
    NNAlertAnimationStyleFromLeft = 1 << 2,
    NNAlertAnimationStyleFromRight = 1 << 3,
    
    NNAlertAnimationStyleFade = 1 << 10,
    NNAlertAnimationStyleEnlarge = 1 << 11,
    NNAlertAnimationStyleShrink = 1 << 12,
};

typedef void(^NNEmptyHandler)(void);
typedef void(^NNAlertActionHandler)(NNAlertAction *action);
typedef void(^NNAlertLabelHandler)(__kindof UILabel *label);
typedef void(^NNAlertItemHandler)(__kindof NNAlertItem *item);
typedef void(^NNAlertTextFiledHandler)(__kindof UITextField *textField);
typedef void(^NNAlertCustomViewHandler)(__kindof NNAlertCustomView *customView);

typedef NNAlertConfig *(^NNConfigHandler)(void);
typedef NNAlertConfig *(^NNConfigBOOLHandler)(BOOL boolValue);
typedef NNAlertConfig *(^NNConfigFloatHandler)(CGFloat floatValue);
typedef NNAlertConfig *(^NNConfigStringHandler)(NSString *strValue);
typedef NNAlertConfig *(^NNConfigIntegerHandler)(NSInteger intValue);
typedef NNAlertConfig *(^NNConfigViewHandler)(__kindof UIView *view);
typedef NNAlertConfig *(^NNConfigAnimationStyleHandler)(NNAlertAnimationStyle style);

typedef NNAlertConfig *(^NNConfigBlockLabelHandler)(NNAlertLabelHandler);
typedef NNAlertConfig *(^NNConfigBlockItemHandler)(NNAlertItemHandler);
typedef NNAlertConfig *(^NNConfigBlockCustomViewHandler)(NNAlertCustomViewHandler);
typedef NNAlertConfig *(^NNConfigBlockTextFieldHandler)(NNAlertTextFiledHandler);

typedef NNAlertConfig *(^NNConfigColorHandler)(__kindof UIColor *color);
typedef NNAlertConfig *(^NNConfigBlockHandler)(NNEmptyHandler handler);
typedef NNAlertConfig *(^NNConfigSizeHandler)(CGSize size);
typedef NNAlertConfig *(^NNConfigEdgeInsetsHandler)(UIEdgeInsets insets);
typedef NNAlertConfig *(^NNConfigBlurEffectStyleHandler)(UIBlurEffectStyle style);
typedef NNAlertConfig *(^NNConfigInterfaceOrientationMaskHandler)(UIInterfaceOrientationMask mask);

typedef NNAlertConfig *(^NNConfigBlockActionHandler)(NNAlertActionHandler handler);
typedef NNAlertConfig *(^NNConfigStringAndBlockHandler)(NSString *str, NNAlertActionHandler handler);
typedef NNAlertConfig *(^NNConfigAnimationBlockHandler)(void(^)(NNEmptyHandler animatingHandler, NNEmptyHandler animatedHandler));
typedef NNAlertConfig *(^NNConfigFloatAndBlockHandler)(CGFloat(^)(NNAlertScreenOrientation orientation));
#endif /* NNAlertHelper_h */
