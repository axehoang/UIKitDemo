//
//  Image.h
//  UIViewDemo
//
//  Created by Hoang Van Trung on 7/7/17.
//  Copyright © 2017 Axe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Image : NSObject

@property (strong, nonatomic) NSString* image;
@property (strong, nonatomic) NSString* name;

- (id)initWithImage:(NSString *)image name:(NSString *)name;

@end
