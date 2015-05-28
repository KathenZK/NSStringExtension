//
//  NSString+Height.h
//  NSStringExtension
//
//  Created by ZK on 15/5/28.
//  Copyright (c) 2015年 ZK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Height)
/**
 *  传入字体，字间距，行间距，段间距后的属性字符串（Attributed String）
 */
@property (nonatomic, strong) NSMutableAttributedString *attributedString;

/**
 *  通过传入字符串的宽、字体、字间距、行间距、段间距来计算字符串的高度
 *
 *  @param width            字符串的宽
 *  @param font             字体
 *  @param characterSpacing 字间距
 *  @param linesSpacing     行间距
 *  @param paragraphSpacing 段间距
 *
 *  @return 字符串的高
 */
- (CGFloat)getStringHeightByWidth:(CGFloat)width font:(UIFont *)font characterSpacing:(CGFloat)characterSpacing linesSpacing:(CGFloat)linesSpacing paragraphSpacing:(CGFloat)paragraphSpacing;

@end
