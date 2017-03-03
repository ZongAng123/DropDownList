//
//  CharTableViewCell.h
//  DropDownList
//
//  Created by 纵昂 on 2017/3/3.
//  Copyright © 2017年 纵昂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "charModel.h"
@interface CharTableViewCell : UITableViewCell
@property (nonatomic, strong)UIImageView * icon;
@property (nonatomic, strong)UILabel * intro;
@property (nonatomic, strong)UILabel * name;
@property (nonatomic, strong)UILabel * timer;
@property (nonatomic, strong) charModel *model;
@end
