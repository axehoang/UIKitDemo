//
//  Image.m
//  UIViewDemo
//
//  Created by Hoang Van Trung on 7/7/17.
//  Copyright © 2017 Axe. All rights reserved.
//

#import "Image.h"

@implementation Image

- (id)initWithImage:(NSString *)image name:(NSString *)name{
    if(self == [super init]){
        self.image = image;
        self.name = name;
    }
    return self;
}

@end
