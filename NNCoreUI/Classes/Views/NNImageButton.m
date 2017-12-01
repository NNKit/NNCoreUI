//
//  NNImageButton.m
//  NNCoreUI
//
//  Created by XMFraker on 2017/11/30.
//

#import "NNImageButton.h"
#import <NNCore/NNCore.h>

@interface NNImageButton ()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UIImageView *backgroundView;

@property (strong, nonatomic) NSMutableDictionary *stateInfos;

@end


@implementation NNImageButton

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setup];
        [self setupUI];
        [self setupConstraints];
        [self setupTouchEvents];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
        [self setupUI];
        [self setupConstraints];
        [self setupTouchEvents];
    }
    return self;
}

#pragma mark - Override Methods

- (void)awakeFromNib {
    
    [super awakeFromNib];
    [self setup];
    [self setupUI];
    [self setupConstraints];
    [self setupTouchEvents];
}

#pragma mark - Public Methods

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [self setObject:title forKey:NSStringFromSelector(@selector(titleForState:)) state:state];
}

- (void)setTitleFont:(UIFont *)font forState:(UIControlState)state {
    [self setObject:font forKey:NSStringFromSelector(@selector(titleFontForState:)) state:state];
}

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state {
    [self setObject:color forKey:NSStringFromSelector(@selector(titleColorForState:)) state:state];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    [self setObject:image forKey:NSStringFromSelector(@selector(imageForState:)) state:state];
}

- (void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state {
    [self setObject:image forKey:NSStringFromSelector(@selector(backgroundImageForState:)) state:state];
}

- (void)setAttributedTitle:(NSAttributedString *)attributedTitle forState:(UIControlState)state {
    [self setObject:attributedTitle forKey:NSStringFromSelector(@selector(attributedTitleForState:)) state:state];
}

- (nullable NSString *)titleForState:(UIControlState)state {
    return [self objectForKey:NSStringFromSelector(_cmd) state:state];
}

- (UIFont *)titleFontForState:(UIControlState)state {
    return [self objectForKey:NSStringFromSelector(_cmd) state:state] ? : [UIFont systemFontOfSize:17.f];
}

- (UIColor *)titleColorForState:(UIControlState)state {
    return [self objectForKey:NSStringFromSelector(_cmd) state:state] ? : [UIColor whiteColor];
}

- (nullable UIImage *)imageForState:(UIControlState)state {
    return [self objectForKey:NSStringFromSelector(_cmd) state:state];
}

- (nullable UIImage *)backgroundImageForState:(UIControlState)state {
    return [self objectForKey:NSStringFromSelector(_cmd) state:state];
}

- (nullable NSAttributedString *)attributedTitleForState:(UIControlState)state {
    return [self objectForKey:NSStringFromSelector(_cmd) state:state];
}

#pragma mark - Private Methods

- (void)setup {

    self.backgroundView = [[UIImageView alloc] init];
    self.backgroundView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.backgroundView];
    
    self.contentView = [[UIView alloc] init];
    self.titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.titleLabel];
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.imageView];
    [self addSubview:self.contentView];
    
    // 关闭titleLabel, imageView 的触摸事件
    self.contentView.userInteractionEnabled = self.titleLabel.userInteractionEnabled = self.imageView.userInteractionEnabled = NO;
    
    self.clipsToBounds = YES;
    self.padding = 5.f;
    self.imageSide  = NNImageButtonImageSideDefault;
    self.stateInfos = [NSMutableDictionary dictionary];
    self.touchEffectEnabled = NO;
}

- (void)setupUI {
    
    if (self.currentAttributedTitle) {
        self.titleLabel.attributedText = self.currentAttributedTitle;
    } else if (self.currentTitle) {
        self.titleLabel.text = self.currentTitle;
        self.titleLabel.textColor = self.currentTitleColor;
        self.titleLabel.font = self.currentTitleFont;
    }
    
    if (self.currentImage) { self.imageView.image = self.currentImage; };
    if (self.currentBackgroundImage) { self.backgroundView.image = self.currentBackgroundImage; };

    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setupTouchEvents {
 
    // Simple effect
    UIControlEvents applyEffectEvents = UIControlEventTouchDown | UIControlEventTouchDragInside | UIControlEventTouchDragEnter;
    [self removeTarget:self action:@selector(applyTouchEffect) forControlEvents:applyEffectEvents];
    [self addTarget:self action:@selector(applyTouchEffect) forControlEvents:applyEffectEvents];
    
    UIControlEvents dismissEffectEvents = UIControlEventTouchUpInside | UIControlEventTouchUpOutside | UIControlEventTouchDragOutside | UIControlEventTouchDragExit | UIControlEventTouchCancel;
    [self removeTarget:self action:@selector(dismissTouchEffect) forControlEvents:dismissEffectEvents];
    [self addTarget:self action:@selector(dismissTouchEffect) forControlEvents:dismissEffectEvents];
}

- (void)setupConstraints {
    
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self removeConstraints:self.constraints];
    [self.contentView removeConstraints:self.contentView.constraints];
    
    CGFloat padding = (self.imageView.image && (self.titleLabel.text.length || self.titleLabel.attributedText.length)) ? self.padding : 0;
    NSDictionary *metrics = @{
                              @"padding" : @(padding),
                              @"left":@(self.contentInsets.left),
                              @"right":@(self.contentInsets.right),
                              @"top":@(self.contentInsets.top),
                              @"bottom":@(self.contentInsets.bottom)
                              };
    NSDictionary *views = NSDictionaryOfVariableBindings(_titleLabel, _imageView);

    NSMutableArray *constraints = [NSMutableArray array];
    switch (self.imageSide) {
        case NNImageButtonImageSideTop:
        {
            [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(top)-[_imageView]-(padding)-[_titleLabel]-(bottom)-|" options:NSLayoutFormatAlignAllCenterX metrics:metrics views:views]];
            [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(left)-[_imageView]-(right)-|" options:NSLayoutFormatAlignmentMask metrics:metrics views:views]];
            [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(left)-[_titleLabel]-(right)-|" options:NSLayoutFormatAlignmentMask metrics:metrics views:views]];
        }
            break;
        case NNImageButtonImageSideRight:
        {
            [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(left)-[_titleLabel]-(padding)-[_imageView]-(right)-|" options:NSLayoutFormatAlignAllCenterY metrics:metrics views:views]];
            [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(top)-[_imageView]-(bottom)-|" options:NSLayoutFormatAlignmentMask metrics:metrics views:views]];
            [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(top)-[_titleLabel]-(bottom)-|" options:NSLayoutFormatAlignmentMask metrics:metrics views:views]];
        }
            break;
        case NNImageButtonImageSideBottom:
        {
            [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(top)-[_titleLabel]-(padding)-[_imageView]-(bottom)-|" options:NSLayoutFormatAlignAllCenterX metrics:metrics views:views]];
            [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(left)-[_imageView]-(right)-|" options:NSLayoutFormatAlignmentMask metrics:metrics views:views]];
            [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(left)-[_titleLabel]-(right)-|" options:NSLayoutFormatAlignmentMask metrics:metrics views:views]];
        }
            break;
        case NNImageButtonImageSideDefault:
        default:
        {
            [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(left)-[_imageView]-(padding)-[_titleLabel]-(right)-|" options:NSLayoutFormatAlignAllCenterY metrics:metrics views:views]];
            [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(top)-[_imageView]-(bottom)-|" options:NSLayoutFormatAlignmentMask metrics:metrics views:views]];
            [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(top)-[_titleLabel]-(bottom)-|" options:NSLayoutFormatAlignmentMask metrics:metrics views:views]];
        }
            break;
    }

    [self.contentView addConstraints:constraints];

    {
        // 撑开contentView
        NSMutableArray<NSLayoutConstraint *>  *constraints = [NSMutableArray arrayWithArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentView]|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"contentView" : self.contentView}]];
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentView]|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:@{@"contentView" : _contentView}]];
        [constraints execute:^(NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            // !!! 只能使用low ,否则会导致
            obj.priority = UILayoutPriorityDefaultLow;
        }];
        
        // 设置contentView 居中
        [constraints addObject:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.f constant:.0f]];
        [constraints addObject:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.f constant:.0f]];
        [self addConstraints:constraints];
    }
}

- (void)applyTouchEffect {
    
    if (self.touchEffectEnabled) {
        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.transform = CGAffineTransformMakeScale(1.05, 1.05);
        } completion:nil];
    }
}

- (void)dismissTouchEffect {
    
    if (self.touchEffectEnabled) {
        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:nil];
    }
}

- (id)objectForKey:(NSString *)key state:(UIControlState)state {
    
    id object = [self.stateInfos safeObjectForKey:[NSString stringWithFormat:@"%@_%@", key, @(state)]];
    if (!object) { object = [self.stateInfos safeObjectForKey:[NSString stringWithFormat:@"%@_%@", key, @(UIControlStateNormal)]]; };
    return object;
}

- (void)setObject:(id)object forKey:(NSString *)key state:(UIControlState)state {
    
    NSAssert(key && key.length, @"key should not be nil");
    if (object) { [self.stateInfos setObject:object forKey:[NSString stringWithFormat:@"%@_%@", key, @(state)]]; }
    else { [self.stateInfos removeObjectForKey:[NSString stringWithFormat:@"%@_%@", key, @(state)]]; }
    
    [self setupUI];
    [self setupConstraints];
}

#pragma mark - Setter

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    [self setupUI];
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    [self setupUI];
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    [self setupUI];
}

- (void)setImageSide:(NNImageButtonImageSide)imageSide {
    
    if (_imageSide != imageSide) {
        _imageSide = imageSide;
        [self setupConstraints];
    }
}

- (void)setPadding:(CGFloat)padding {
    
    if (_padding != padding) {
        _padding = padding;
        [self setupConstraints];
    }
}

- (void)setContentInsets:(UIEdgeInsets)contentInsets {
    
    if (!UIEdgeInsetsEqualToEdgeInsets(contentInsets, _contentInsets)) {
        _contentInsets = contentInsets;
        [self setupConstraints];
    }
}

#pragma mark - Getter

- (NSString *)currentTitle { return [self titleForState:self.state]; }
- (UIFont *)currentTitleFont { return [self titleFontForState:self.state]; }
- (NSAttributedString *)currentAttributedTitle { return [self attributedTitleForState:self.state]; }
- (UIColor *)currentTitleColor { return [self titleColorForState:self.state]; }
- (UIImage *)currentImage { return [self imageForState:self.state]; }
- (UIImage *)currentBackgroundImage { return [self backgroundImageForState:self.state]; }

@end
