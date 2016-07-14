//
//  BookCell.m
//  HealthDrips
//
//  Created by Cedric.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "BookCell.h"
#import "NewsGeneralModel.h"
#import "HealthDrips.pch"
#import "BookCoverCell.h"
#import "NewsGeneralModel.h"
#import "InfoMacros.h"

@interface BookCell()<UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout>{

    NSArray * _modelArray;
}

@end

@implementation BookCell

- (void)awakeFromNib {
    
    [self.bookCollection registerNib:[UINib nibWithNibName:@"BookCoverCell" bundle:nil] forCellWithReuseIdentifier:@"bookcovercell"];
    self.bookCollection.delegate = self;
    self.bookCollection.dataSource = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

//传入cell的数据
- (void)addModelArray:(NSArray *)array{

    _modelArray = array;
    self.tyoeLabel.text = BOOK_TYPE[[_modelArray[6] intValue]];
    [self.bookCollection reloadData];
}

//collectionView的协议方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _modelArray.count - 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    BookCoverCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"bookcovercell" forIndexPath:indexPath];
    NewsGeneralModel * model = _modelArray[indexPath.row];
    [cell refreshCellWithModel:model];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake(80, 154);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    return UIEdgeInsetsMake(0, 4, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if ([self.delegate respondsToSelector:@selector(getBookModel:)]) {
        
        [self.delegate getBookModel:_modelArray[indexPath.row]];
    }
}

@end
