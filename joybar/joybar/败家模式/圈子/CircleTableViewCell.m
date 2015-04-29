//
//  CircleTableViewCell.m
//  joybar
//
//  Created by 123 on 15/4/20.
//  Copyright (c) 2015年 卢兴. All rights reserved.
//

#import "CircleTableViewCell.h"
#import "UIView+Shadow.h"
@implementation CircleTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void) setData:(NSArray *)dataArr
{
    NSArray *array1 = [self.contentView subviews];
    for (UIView *view in array1)
    {
        [view removeFromSuperview];
    }

    //构建单元格的视图区域
    for(int index = 0;index < dataArr.count; index ++ )
    {
        CGRect frame = CGRectMake(20+20*index+(kScreenWidth-60)/2*index, 20, (kScreenWidth-60)/2, (kScreenWidth-60)/2);
        UIImageView *image = [[UIImageView alloc] initWithFrame:frame];
        image.tag = index + 10;
        image.userInteractionEnabled = YES;
//        image.backgroundColor = [UIColor orangeColor];
        image.image = [UIImage imageNamed:@"quanzi01.png"];
        [self.contentView addSubview:image];
        
        UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, image.width-20, image.height-20)];
        headImage.layer.masksToBounds = YES;
        headImage.layer.cornerRadius = headImage.width/2;
        headImage.backgroundColor = [UIColor whiteColor];
        headImage.contentMode = UIViewContentModeScaleAspectFill;
        headImage.image = [UIImage imageNamed:@"test1.jpg"];
        [image addSubview:headImage];
        
        UIImageView *shadowImg = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, headImage.width, headImage.height)];
//        headImage.contentMode = UIViewContentModeScaleAspectFill;
        shadowImg.image = [UIImage imageNamed:@"shadow.png"];
        [headImage addSubview:shadowImg];

        
        UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(20+20*index+(kScreenWidth-60)/2*index, image.bottom+10, image.width, 15)];
        nameLab.text = @"欧美高端女包";
        nameLab.textAlignment = NSTextAlignmentCenter;
        nameLab.font = [UIFont fontWithName:@"youyuan" size:15];
        [self.contentView addSubview:nameLab];
        
        UILabel *numLab = [[UILabel alloc] initWithFrame:CGRectMake(20+20*index+(kScreenWidth-60)/2*index, nameLab.bottom+3, image.width, 13)];
        numLab.text = @"人数: 1234";
        numLab.textAlignment = NSTextAlignmentCenter;
        numLab.font = [UIFont fontWithName:@"youyuan" size:11];
        [self.contentView addSubview:numLab];
        
        
        UIImageView *locationImg = [[UIImageView alloc] initWithFrame:CGRectMake(45+20*index+(kScreenWidth-60)/2*index, numLab.bottom+3, 13, 13)];
        locationImg.image = [UIImage imageNamed:@"location.png"];
        [self.contentView addSubview:locationImg];
        
        UILabel *addressLab = [[UILabel alloc] initWithFrame:CGRectMake(locationImg.right, numLab.bottom+3, 100, 13)];
        addressLab.text = @"王府井百货-MIUMIU";
        addressLab.textAlignment = NSTextAlignmentLeft;
        addressLab.textColor = [UIColor lightGrayColor];
        addressLab.backgroundColor = [UIColor clearColor];
        addressLab.font = [UIFont fontWithName:@"youyuan" size:11];
        [self.contentView addSubview:addressLab];
        
    }

}

@end
