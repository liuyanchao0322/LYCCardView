//
//  DWCardCell.m
//  CardView
//
//  Created by Admin on 2020/6/3.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "DWCardCell.h"
#import <UIImageView+WebCache.h>

@interface DWCardCell()

@property(nonatomic, strong) UIImageView *imageView;
/** <#注释#> */
@property (nonatomic, strong) UILabel *nameLabel;
/** <#注释#> */
@property (nonatomic, strong) UILabel *descLabel;
@end

@implementation DWCardCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    
    [self addSubview:self.imageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.descLabel];
}

- (void)setImage:(UIImage *)image {
    _image = image;
    _imageView.image = image;
}

- (void)setImageUrl:(NSString *)imageUrl
{
    _imageUrl = imageUrl;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
    self.nameLabel.frame = CGRectMake(15, 15, 100, 16);
    self.descLabel.frame = CGRectMake(15, 45, 100, 16);
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.layer.cornerRadius = 4;
        _imageView.layer.masksToBounds = YES;
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}


- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"项目名称";
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.textColor = UIColor.blueColor;
    }
    return _nameLabel;
}

- (UILabel *)descLabel
{
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.text = @"项目介绍基尼基尼";
        _descLabel.font = [UIFont systemFontOfSize:15];
        _descLabel.textAlignment = NSTextAlignmentLeft;
        _descLabel.textColor = UIColor.redColor;
    }
    return _descLabel;
}

@end
