//
//  CusHomeTableViewCell.m
//  joybar
//
//  Created by 123 on 15/4/24.
//  Copyright (c) 2015年 卢兴. All rights reserved.
//

#import "CusHomeTableViewCell.h"
#import "CusTagViewController.h"
@implementation CusHomeTableViewCell
{
    CGFloat cellHeight;
}
- (void)awakeFromNib {
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setData:(NSDictionary *)dic
{
    UIImageView *headImg = [[UIImageView alloc] initWithFrame:CGRectMake(7, 7, 55, 55)];
    headImg.backgroundColor = [UIColor orangeColor];
    headImg.layer.cornerRadius = headImg.width/2;
    [self.contentView addSubview:headImg];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(headImg.width+20, 7, kScreenWidth-100, 30)];
    titleLab.text = @"华宇商厦导购";
    titleLab.font = [UIFont fontWithName:@"youyuan" size:18];
    [self.contentView addSubview:titleLab];
    
    UIImageView *locationImg = [[UIImageView alloc] initWithFrame:CGRectMake(headImg.width+20, titleLab.bottom+3, 13, 13)];
    locationImg.image = [UIImage imageNamed:@"location.png"];
    [self.contentView addSubview:locationImg];
    
    UILabel *locationLab = [[UILabel alloc] initWithFrame:CGRectMake(locationImg.right, titleLab.bottom, 200, 20)];
    locationLab.text = @"中关村南大街华宇购物中心";
    locationLab.font = [UIFont fontWithName:@"youyuan" size:14];
    locationLab.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:locationLab];
    
    
    //展示图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, locationLab.bottom+17, kScreenWidth, kScreenHeight-350)];
    imageView.backgroundColor = [UIColor cyanColor];
    imageView.userInteractionEnabled = YES;
    [self.contentView addSubview:imageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickTag:)];
    [imageView addGestureRecognizer:tap];
    
    UILabel *descriptionLab = [[UILabel alloc] initWithFrame:CGRectMake(10, imageView.bottom+10, kScreenWidth-20, 20)];
    descriptionLab.text = @"ELLE风小包,阿斯顿纳斯达克类似的减肥是";
    descriptionLab.font = [UIFont fontWithName:@"youyuan" size:16];
    [self.contentView addSubview:descriptionLab];
    
    UILabel *priceLab = [[UILabel alloc] initWithFrame:CGRectMake(10, descriptionLab.bottom+14, 100, 20)];
    priceLab.text = @"￥123";
    priceLab.font = [UIFont systemFontOfSize:18];
    priceLab.textColor = [UIColor redColor];
    [self.contentView addSubview:priceLab];
    
    UIButton *shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-100, descriptionLab.bottom+10, 80, 33)];
    shareBtn.backgroundColor = kCustomColor(248, 248, 248);
    shareBtn.layer.borderColor = kCustomColor(236, 236, 236).CGColor;
    shareBtn.layer.borderWidth = 0.5;
    shareBtn.layer.cornerRadius = 3;
    [self.contentView addSubview:shareBtn];

    UIButton *chatBtn = [[UIButton alloc] initWithFrame:CGRectMake(shareBtn.left-100, descriptionLab.bottom+10, 80, 33)];
    chatBtn.backgroundColor = kCustomColor(248, 248, 248);
    chatBtn.layer.borderColor = kCustomColor(236, 236, 236).CGColor;
    chatBtn.layer.borderWidth = 0.5;
    chatBtn.layer.cornerRadius = 3;
    [self.contentView addSubview:chatBtn];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth-260, chatBtn.bottom+10, 240, 30)];
    bgView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:bgView];

    for (int i=0; i<7; i++)
    {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(35*i, 0, 30, 30)];
        img.layer.cornerRadius = img.width/2;
        img.backgroundColor = [UIColor grayColor];
        img.tag = 1000+i;
        img.userInteractionEnabled = YES;
        [bgView addSubview:img];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickImage:)];
        [img addGestureRecognizer:tap];
    }
}

-(void)didClickImage:(UITapGestureRecognizer *)tap
{
    
}

-(void)didClickTag:(UITapGestureRecognizer *)tap
{
    CusTagViewController *VC = [[CusTagViewController alloc] init];
    [self.viewController.navigationController pushViewController:VC animated:YES];
}


@end
