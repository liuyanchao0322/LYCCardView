//
//  DWCardScrollView.m
//  CardView
//
//  Created by Admin on 2020/6/3.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "DWCardScrollView.h"
#import "DWCardCell.h"

static NSString *const kCellIdentifier = @"DWCardCellId";

static CGFloat const HorizontalMargin = 20.0;
static CGFloat const ItemMargin = 10.0;

@interface DWCardScrollView() <UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) UIScrollView *panScrollView;
@property(nonatomic, strong) NSTimer *timer;

@end


@implementation DWCardScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.timeInterval = 1.5;
        [self setupView];
    }
    return self;
}

- (void)setupView {

    CGFloat collectionViewWidth = self.frame.size.width;
    CGFloat collectionViewHeight = self.frame.size.height;
    CGFloat itemWidth = collectionViewWidth - HorizontalMargin * 2;

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(itemWidth, collectionViewHeight);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = ItemMargin;
    layout.sectionInset = UIEdgeInsetsMake(0, HorizontalMargin, 0, HorizontalMargin);
    
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, collectionViewWidth, collectionViewHeight) collectionViewLayout:layout];
    [self addSubview:collectionView];
    _collectionView = collectionView;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.alwaysBounceHorizontal = YES;
    collectionView.clipsToBounds = NO;
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    [collectionView registerClass:[DWCardCell class] forCellWithReuseIdentifier:kCellIdentifier];
    
    // 核心在这呢
    CGFloat pageScrollWidth = itemWidth + ItemMargin;
    _panScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake((collectionView.frame.size.width - pageScrollWidth)/2, 0, pageScrollWidth, collectionViewHeight)];
    [self addSubview:_panScrollView];
    _panScrollView.hidden = YES;
    _panScrollView.showsHorizontalScrollIndicator = NO;
    _panScrollView.alwaysBounceHorizontal = YES;
    _panScrollView.pagingEnabled = YES;
    _panScrollView.delegate = self;
    
    // collectionView 添加 _panScrollViews的手势
    [_collectionView addGestureRecognizer:_panScrollView.panGestureRecognizer];
    
    // collectionView 让自己的手势不可用
    _collectionView.panGestureRecognizer.enabled = NO;
    
    [self scrollViewDidEndDecelerating:self.panScrollView];
    
}


#pragma mark - Set & Get
- (void)setImages:(NSArray *)images {
    _images = [images copy];
    [self updateView];
}

- (void)setImageUrlArray:(NSArray *)imageUrlArray
{
    _imageUrlArray = imageUrlArray;
    [self updateView];
}


- (void)setTimeInterval:(CGFloat)timeInterval
{
    _timeInterval = timeInterval;
}


- (void)updateView {
    [_collectionView reloadData];
}

- (void)setOpenAutoScroll:(BOOL)openAutoScroll
{
    _openAutoScroll = openAutoScroll;
    if (openAutoScroll) {
        [self addTimer];
    }
}

- (void)addTimer {
    if (self.timer.isValid) {
        [self.timer invalidate];
    }
    
    self.timer = [NSTimer timerWithTimeInterval:self.timeInterval target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)autoScroll {
    
    NSArray *dataArray = self.sourceType == DWCardScrollViewLocalSourceType ? self.images : self.imageUrlArray;

    if (dataArray.count <= 1) {
        return;
    }
    
    // 滚到最后一页的时候，回到第一页
    if (_panScrollView.contentOffset.x >= _panScrollView.frame.size.width * (dataArray.count - 1)) {
        [_panScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    } else {
        [_panScrollView setContentOffset:CGPointMake(_panScrollView.contentOffset.x + _panScrollView.frame.size.width, 0) animated:YES];
    }
}


#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSArray *dataArray = self.sourceType == DWCardScrollViewLocalSourceType ? self.images : self.imageUrlArray;
    
    _panScrollView.contentSize = CGSizeMake(_panScrollView.frame.size.width * dataArray.count, 0);
    return dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DWCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    if (self.sourceType == DWCardScrollViewLocalSourceType) {
        if (indexPath.item < _images.count) {
            UIImage *image = _images[indexPath.item];
            cell.image = image;
        }
    } else {
        if (indexPath.item < self.imageUrlArray.count) {
            NSString *imageUrl = self.imageUrlArray[indexPath.item];
            cell.imageUrl = imageUrl;
        }
    }
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    if (self.DWCardScrollViewDidSelectedBlock) {
        self.DWCardScrollViewDidSelectedBlock(indexPath);
    }
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == _panScrollView) {
        _collectionView.contentOffset = _panScrollView.contentOffset;
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat kScreenWidth = [UIScreen mainScreen].bounds.size.width;
    int index = (scrollView.contentOffset.x + kScreenWidth * 0.5) / kScreenWidth;
    
    NSLog(@"scrollIndex == %d", index);
    if (self.DWCardScrollViewScrollIndexBlock) {
        self.DWCardScrollViewScrollIndexBlock(index);
    }
}


@end
