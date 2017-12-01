//
//  NNImageButton.h
//  NNCoreUI
//
//  Created by XMFraker on 2017/11/30.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, NNImageButtonImageSide) {
    NNImageButtonImageSideTop = 1,
    NNImageButtonImageSideLeft = 2,
    NNImageButtonImageSideBottom = 3,
    NNImageButtonImageSideRight = 4,
    NNImageButtonImageSideDefault = NNImageButtonImageSideLeft
};

NS_ASSUME_NONNULL_BEGIN

@interface NNImageButton : UIControl

/** image - title 间距 默认 5.f */
@property (assign, nonatomic) CGFloat padding;
/** image 位置  默认 NNImageButtonImageSideLeft */
@property (assign, nonatomic) NNImageButtonImageSide imageSide;
/** 是否开启点击放大动画效果  默认为NO */
@property (assign, nonatomic) BOOL touchEffectEnabled;
/** contentInsets 间距 默认UIEdgeInsetsZero */
@property (assign, nonatomic) UIEdgeInsets contentInsets;

@property (copy, nonatomic, readonly, nullable)   NSString *currentTitle;
@property (strong, nonatomic, readonly)   UIColor *currentTitleColor;
@property (strong, nonatomic, readonly)   UIFont *currentTitleFont;
@property (copy, nonatomic, readonly, nullable)   NSAttributedString *currentAttributedTitle;
@property (strong, nonatomic, readonly, nullable)   UIImage *currentImage;
@property (strong, nonatomic, readonly, nullable)   UIImage *currentBackgroundImage;


- (void)setTitle:(nullable NSString *)title forState:(UIControlState)state;
- (void)setTitleFont:(UIFont *)font forState:(UIControlState)state;
- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state;
- (void)setImage:(nullable UIImage *)image forState:(UIControlState)state;
- (void)setBackgroundImage:(nullable UIImage *)image forState:(UIControlState)state;
- (void)setAttributedTitle:(nullable NSAttributedString *)attributedTitle forState:(UIControlState)state;

- (nullable NSString *)titleForState:(UIControlState)state;
- (UIFont *)titleFontForState:(UIControlState)state;
- (UIColor *)titleColorForState:(UIControlState)state;
- (nullable UIImage *)imageForState:(UIControlState)state;
- (nullable UIImage *)backgroundImageForState:(UIControlState)state;
- (nullable NSAttributedString *)attributedTitleForState:(UIControlState)state;

@end

NS_ASSUME_NONNULL_END
