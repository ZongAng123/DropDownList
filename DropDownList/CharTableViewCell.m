//
//  CharTableViewCell.m
//  DropDownList
//
//  Created by 纵昂 on 2017/3/3.
//  Copyright © 2017年 纵昂. All rights reserved.
//

#define KSIZE ([UIScreen mainScreen].bounds.size)

#import "CharTableViewCell.h"

@implementation CharTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createTableView];
    }
    return self;
}
- (void)createTableView{
    _icon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10 + 6 / 375.0 * KSIZE.width, 40 / 375.0 * KSIZE.width, 40 / 375.0 * KSIZE.width)];
    _icon.layer.cornerRadius = 20 / 375.0 * KSIZE.width;
    _icon.layer.masksToBounds = YES;
    [self.contentView addSubview:_icon];
    
    _name = [[UILabel alloc] initWithFrame:CGRectMake(10 + 50 / 375.0 * KSIZE.width, 10 + 6 / 375.0 * KSIZE.width, 170 / 375.0 * KSIZE.width, 20 / 375.0 * KSIZE.width)];
    _name.textColor = [UIColor colorWithRed:0.81 green:0.37 blue:0.41 alpha:1.0];
    _name.font = [UIFont boldSystemFontOfSize:13 / 375.0 * KSIZE.width];
    [self.contentView addSubview:_name];
    
    _intro = [[UILabel alloc] initWithFrame:CGRectMake(10 + 50 / 375.0 * KSIZE.width, 10 + 30 / 375.0 * KSIZE.width, 210 / 375.0 * KSIZE.width, 20 / 375.0 * KSIZE.width)];
    _intro.textColor = [UIColor colorWithRed:0.45 green:0.45 blue:0.45 alpha:1.0];
    _intro.font = [UIFont systemFontOfSize:12 / 375.0 * KSIZE.width];
    [self.contentView addSubview:_intro];
    
    _timer = [[UILabel alloc] initWithFrame:CGRectMake(10 + 305 / 375.0 * KSIZE.width, 10 + 6 / 375.0 * KSIZE.width, 50 / 375.0 * KSIZE.width, 34 / 375.0 * KSIZE.width)];
    _timer.textColor = [UIColor colorWithRed:0.45 green:0.45 blue:0.45 alpha:1.0];
    _timer.font = [UIFont systemFontOfSize:11 / 375.0 * KSIZE.width];
    [self.contentView addSubview:_timer];
    UILabel * labelLine = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 + 55 / 375.0 * KSIZE.width, KSIZE.width - 10, 1)];
    labelLine.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0];
    
    [self addSubview:labelLine];
    
}

- (void)setModel:(charModel *)model{
    _model = model;
    //    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"place_%d.png", arc4random()%2 + 1]]];
    _icon.image = [UIImage imageNamed:model.iconName];
    _name.text = model.name;
    _timer.text = model.timer;
    _intro.text = model.intro;
}

@end
