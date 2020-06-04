//
//  ProductCell.h
//  CardView
//
//  Created by Admin on 2020/6/2.
//  Copyright © 2020 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductCell : UITableViewCell

+ (instancetype) cellWithTableView:(UITableView *)tableView;

/** <#注释#> */
@property (nonatomic, copy) void (^ProductCellSelectedBlock) (NSIndexPath *indexPath);

@end

NS_ASSUME_NONNULL_END
