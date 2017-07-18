//
//  Image.m
//  TableViewDemo
//
//  Created by Hoang Van Trung on 7/12/17.
//  Copyright © 2017 Axe. All rights reserved.
//

#import "Image.h"

@implementation Image

- (id)initWithImageName:(NSString *)imageName url:(NSString *)imageURL{
    if(self == [super init]){
        self.imageName = imageName;
        self.imageURL = imageURL;
    }
    return self;
}

@end
