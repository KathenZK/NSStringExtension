//
//  NSString+Height.m
//  NSStringExtension
//
//  Created by ZK on 15/5/28.
//  Copyright (c) 2015年 ZK. All rights reserved.
//

#import "NSString+Height.h"
#import <objc/runtime.h>
#import <CoreText/CoreText.h>

static void *attributedStringKey = &attributedStringKey;

@implementation NSString (Height)

#pragma mark - 使用运行时给NSString添加attributedString属性
- (NSMutableAttributedString *)attributedString
{
    return objc_getAssociatedObject(self, attributedStringKey);
}

- (void)setAttributedString:(NSMutableAttributedString *)attributedString
{
    objc_setAssociatedObject(self, attributedStringKey, attributedString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - 获取字符串的高度
- (CGFloat)getStringHeightByWidth:(CGFloat)width font:(UIFont *)font characterSpacing:(CGFloat)characterSpacing linesSpacing:(CGFloat)linesSpacing paragraphSpacing:(CGFloat)paragraphSpacing
{
    [self initAttributedStringWithFont:font CharacterSpacing:characterSpacing linesSpacing:linesSpacing paragraphSpacing:paragraphSpacing];
    
    CGFloat totalHeight;
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self.attributedString);
    CGRect drawingRect = CGRectMake(0, 0, width, 10000); // 高要足够大
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, drawingRect);
    CTFrameRef textFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    CGPathRelease(path);
    CFRelease(framesetter);
    
    NSArray *linesArray = (NSArray *)CTFrameGetLines(textFrame);
    CGPoint origins[linesArray.count];
    
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0, 0), origins);
    
    CGFloat line_y = origins[linesArray.count-1].y; //最后一行line的原点y坐标
    CGFloat ascent;
    CGFloat descent;
    CGFloat leading;
    
    CTLineRef line = (__bridge CTLineRef)([linesArray objectAtIndex:[linesArray count]-1]);
    CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    totalHeight = 10000 - line_y + descent;
    
    CFRelease(textFrame);
    return totalHeight;
    
    return 0;
}

#pragma mark - 初始化属性字符串attributedString
- (void)initAttributedStringWithFont:(UIFont *)font CharacterSpacing:(CGFloat)characterSpacing linesSpacing:(CGFloat)linesSpacing paragraphSpacing:(CGFloat)paragraphSpacing
{
    if (self.attributedString == nil) {
        self.attributedString = [[NSMutableAttributedString alloc] initWithString:self];
        
        //设置字体及大小
        if (font == nil) {
            font = [UIFont fontWithName:nil size:[UIFont systemFontSize]];
        }
        NSLog(@"font.pointSize----%f\nfont.pointSize----%f",font.pointSize, font.pointSize);
//        CTFontRef myFont = CTFontCreateWithName((CFStringRef)font.fontName, font.pointSize, NULL);
        [self.attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, self.length)];
        
        //设置字间距
        [self.attributedString addAttribute:NSKernAttributeName value:[NSNumber numberWithFloat:characterSpacing] range:NSMakeRange(0, self.length)];
        
        //设置行间距和段间距
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineSpacing = linesSpacing;
        paragraph.paragraphSpacing = paragraphSpacing;
        paragraph.alignment = NSTextAlignmentLeft;
        [self.attributedString addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, self.length)];
        
    }
}

@end
