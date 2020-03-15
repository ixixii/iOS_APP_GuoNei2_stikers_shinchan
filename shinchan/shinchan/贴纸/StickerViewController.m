//
//  StickerViewController.m
//  shinchan
//
//  Created by beyond on 2020/03/15.
//  Copyright © 2020 beyond. All rights reserved.
//

#import "StickerViewController.h"
#import "SGCollectionViewCell.h"

#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define ScreenBounds [UIScreen mainScreen].bounds
#define ScreenWidth ScreenBounds.size.width
#define ScreenHeight ScreenBounds.size.height

@interface StickerViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
{
    UICollectionView *_cView;
}
@end

@implementation StickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addHeaderView];
    [self addCollectionView];
}
- (void)addHeaderView
{
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor clearColor];
    UIView *bgView =  [[UIView alloc]init];
    bgView.backgroundColor = kColor(18, 139, 191);
//    bgView.alpha = 0.45;
    bgView.frame = CGRectMake(0, 0, ScreenWidth, 65);
    [headerView addSubview:bgView];
    headerView.frame = CGRectMake(0, 0, ScreenWidth, 65);
    [self.view addSubview:headerView];

    // appName
    UILabel *classLable = [[UILabel alloc]init];
    // 添加tap手势
    UITapGestureRecognizer *tapReco = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissCtrl)];
    classLable.userInteractionEnabled = YES;
    [classLable addGestureRecognizer:tapReco];
    
    classLable.text = @"小新贴纸";
    classLable.font = [UIFont boldSystemFontOfSize:24.0];
    classLable.textAlignment = NSTextAlignmentCenter;
    classLable.textColor = kColor(255, 255, 255);
    classLable.backgroundColor = [UIColor clearColor];
    classLable.frame = CGRectMake(40, 20, ScreenWidth - 80, 45);
    [headerView addSubview:classLable];
}
- (void)addCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemWidth = (ScreenWidth - 4*10) / 3;
    layout.itemSize = CGSizeMake(itemWidth, itemWidth);
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    UICollectionView *cView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 65, ScreenWidth, ScreenHeight - 65) collectionViewLayout:layout];
//    [cView registerClass:[SGCollectionViewCell class] forCellWithReuseIdentifier:@"id_collection_view"];
    [cView registerNib:[UINib nibWithNibName:NSStringFromClass([SGCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"id_collection_view"];
    cView.dataSource = self;
    cView.delegate = self;
    cView.backgroundColor = [UIColor whiteColor];
    _cView = cView;
    
    [self.view addSubview:cView];
}
#pragma mark 代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 24;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SGCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"id_collection_view" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    NSString *imgName = [NSString stringWithFormat:@"shin%d.png",indexPath.row+1];
    NSLog(@"sg__%@",imgName);
    cell.xib_imgView.image = [UIImage imageNamed:imgName];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *imageToShare = [UIImage imageNamed:[NSString stringWithFormat:@"shin%ld.png",indexPath.row+1]];
        NSArray *activityItems =
        [NSArray arrayWithObjects:imageToShare, nil];
        UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    // UIActivityTypeMessage
//         activityVC.excludedActivityTypes = @[UIActivityTypePostToFacebook,UIActivityTypePostToTwitter, UIActivityTypePostToWeibo,UIActivityTypeMail,UIActivityTypePrint,UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeAirDrop,UIActivityTypeOpenInIBooks];
        [self presentViewController:activityVC animated:YES completion:nil];
}
@end
