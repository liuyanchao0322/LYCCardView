//
//  ProductCell.m
//  CardView
//
//  Created by Admin on 2020/6/2.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "ProductCell.h"
#import "DWCardScrollView.h"

@interface ProductCell ()

/** <#注释#> */
@property (nonatomic, strong) DWCardScrollView *cardsView;

@end

@implementation ProductCell

+ (instancetype) cellWithTableView:(UITableView *)tableView
{
    static NSString *cellId = @"ProductCellId";
    ProductCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[ProductCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellId];
    }
    return cell;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.cardsView];
    
        __weak typeof(ProductCell) *weakSelf = self;
        self.cardsView.DWCardScrollViewDidSelectedBlock = ^(NSIndexPath * _Nonnull indexPath) {
            if (weakSelf.ProductCellSelectedBlock) {
                weakSelf.ProductCellSelectedBlock(indexPath);
            }
        };
    }
    return self;
}

- (DWCardScrollView *)cardsView
{
    if (!_cardsView) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        _cardsView = [[DWCardScrollView alloc] initWithFrame:CGRectMake(0, 0, width, 140)];
        _cardsView.sourceType = DWCardScrollViewServerSourceType;
//        _cardsView.timeInterval = 5.0;
//        _cardsView.openAutoScroll = YES;

//        _cardsView.images = @[[UIImage imageNamed:@"product1"], [UIImage imageNamed:@"product2"], [UIImage imageNamed:@"product3"], [UIImage imageNamed:@"product1"]];
        
        _cardsView.imageUrlArray =            @[@"http://d.hiphotos.baidu.com/image/pic/item/b7fd5266d016092408d4a5d1dd0735fae7cd3402.jpg",
                                      @"http://h.hiphotos.baidu.com/image/h%3D300/sign=2b3e022b262eb938f36d7cf2e56085fe/d0c8a786c9177f3e18d0fdc779cf3bc79e3d5617.jpg",
                                      @"http://a.hiphotos.baidu.com/image/pic/item/b7fd5266d01609240bcda2d1dd0735fae7cd340b.jpg",
                                      @"http://h.hiphotos.baidu.com/image/pic/item/728da9773912b31b57a6e01f8c18367adab4e13a.jpg",
                                      @"http://h.hiphotos.baidu.com/image/pic/item/0d338744ebf81a4c5e4fed03de2a6059242da6fe.jpg"];

    }
    return _cardsView;
}



@end
