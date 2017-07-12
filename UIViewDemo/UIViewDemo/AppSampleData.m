//
//  AppSampleData.m
//  UIViewDemo
//
//  Created by Hoang Van Trung on 7/7/17.
//  Copyright © 2017 Axe. All rights reserved.
//

#import "AppSampleData.h"
#import "Image.h"

@implementation AppSampleData
+ (NSArray<Image *> *)createSampleImages{
    NSMutableArray* sampleImages = [NSMutableArray new];
    for(int i = 0;i<IMAGE_QTY;i++){
        Image* image = [[Image alloc] initWithImage:[NSString stringWithFormat:@"moon%d",i] name:[NSString stringWithFormat:@"Moon %d",i]];
        [sampleImages addObject:image];
    }
    return sampleImages;
}
@end
