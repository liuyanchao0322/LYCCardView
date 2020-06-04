//
//  DWCardScrollView.h
//  CardView
//
//  Created by Admin on 2020/6/3.
//  Copyright © 2020 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, DWCardScrollViewSourceType) {
    
    DWCardScrollViewLocalSourceType = 0,
    DWCardScrollViewServerSourceType
};

typedef void(^DWCardScrollViewDidSelectedBlock1)(NSIndexPath * _Nullable indexPath);


NS_ASSUME_NONNULL_BEGIN

@interface DWCardScrollView : UIView

/** 本地图片数组 */
@property (nonatomic, copy) NSArray *images;
/** 远程图片数组 */
@property (nonatomic, strong) NSArray *imageUrlArray;
/** 数据源类型 */
@property (nonatomic, assign) DWCardScrollViewSourceType sourceType;
/** 点击卡片的回调 */
@property (nonatomic, copy) void (^DWCardScrollViewDidSelectedBlock) (NSIndexPath *indexPath);
/** 滑动卡片的回调 */
@property (nonatomic, copy) void (^DWCardScrollViewScrollIndexBlock) (NSInteger scrollIndex);
/** 轮播间隔:默认1.5s */
@property (nonatomic, assign) CGFloat timeInterval;
/** 是否开启自动轮播  */
@property (nonatomic, assign) BOOL openAutoScroll;

@end



NS_ASSUME_NONNULL_END
