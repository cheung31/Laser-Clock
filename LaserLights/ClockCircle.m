#import "ClockCircle.h"

@implementation ClockCircle
@synthesize size;
+(void) drawCircleWithSize:(float)size InView:(UIView* ) view {
    CGContextRef context = UIGraphicsGetCurrentContext(); 
    CGContextAddArc(context, (view.bounds.origin.x + (view.bounds.size.width /2)), (view.bounds.origin.y + (view.bounds.size.height / 2)), size, 0, 2 * M_PI, YES);
    CGContextShowGlyphsAtPoint(<#CGContextRef context#>, <#CGFloat x#>, <#CGFloat y#>, <#const CGGlyph *glyphs#>, <#size_t count#>)
    CGContextStrokePath(context);
}
@end