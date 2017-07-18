//
//  Image.h
//  TableViewDemo
//
//  Created by Hoang Van Trung on 7/12/17.
//  Copyright © 2017 Axe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Image : NSObject
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *imageURL;

- (id)initWithImageName:(NSString *)imageName url:(NSString *)imageURL;

@end
