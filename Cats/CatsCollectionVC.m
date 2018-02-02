//
//  CatsCollectionVC.m
//  Cats
//
//  Created by Aaron Chong on 2/1/18.
//  Copyright © 2018 Aaron Chong. All rights reserved.
//

#import "CatsCollectionVC.h"
#import "CatImage.h"
#import "CatsCollectionViewCell.h"

@interface CatsCollectionVC ()

@property (strong, nonatomic) CatImage *catImage;
@property (strong, nonatomic) NSArray <CatImage *> *catCollection;

@end

@implementation CatsCollectionVC

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=15f7f925d370f9f92fc2dcf8eac5c533&tags=cat"];
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        if (error) {
            NSLog(@"error: %@", error.description);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *info = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError) {
            NSLog(@"json error: %@", error.description);
        }
        NSMutableArray<CatImage*>* tempArray = [[NSMutableArray alloc] init];
        for (NSDictionary *catImage in info[@"photos"][@"photo"]) {

            NSNumber *farmID = catImage[@"farm"];
            NSString *serverID = catImage[@"server"];
            NSString *idNumber = catImage[@"id"];
            NSString *secretID = catImage[@"secret"];
            NSString *title = catImage[@"title"];
            
            NSLog(@"farmID: %@, serverID: %@, idNumber: %@, secretID: %@, title: %@", farmID, serverID, idNumber, secretID, title);
            
            CatImage *image = [[CatImage alloc]initWithFarmID:farmID serverID:serverID idNumber:idNumber secretID:secretID title:title];
            [image createCatImageURL];
            [tempArray addObject:image];
            
        }
        self.catCollection = tempArray;
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.collectionView reloadData];
        }];
    }];
    
    [task resume];
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.catCollection.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CatsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"catsCell" forIndexPath:indexPath];
    
    CatImage* cat = self.catCollection[indexPath.item];
    cell.catImageView.image = cat.catUIImage;
    cell.titleLabel.text = cat.title;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
