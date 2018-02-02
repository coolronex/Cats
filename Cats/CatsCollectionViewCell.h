//
//  CatsCollectionViewCell.h
//  Cats
//
//  Created by Aaron Chong on 2/1/18.
//  Copyright © 2018 Aaron Chong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CatsCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *catImageView;

@end
