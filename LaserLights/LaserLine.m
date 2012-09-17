#import "LaserLine.h"
#import <QuartzCore/QuartzCore.h>

@implementation LaserLine

@synthesize layer;
@synthesize view;
@synthesize size;

//make the line + layer
+ (LaserLine* )createTrailingLineAtAngle:(double)angle InLayer:(CALayer *)superlayer WithSize:(double)size WithHue:(double)hue WithBrightness:(double)brightness {
    LaserLine* ll = [LaserLine new];
    ll.layer = [CALayer new];
    ll.size = size;
    ll.hue = hue;
    ll.brightness = brightness;
    ll.layer.anchorPoint = CGPointMake(0.5, 1);
    ll.layer.bounds = CGRectMake(0, 0, 5, superlayer.bounds.size.height);
    ll.layer.backgroundColor = CGColorCreateCopyWithAlpha([[UIColor redColor] CGColor], 0);
    ll.layer.delegate = ll;
    ll.layer.position = CGPointMake(superlayer.bounds.size.width / 2, superlayer.bounds.size.height);
    ll.layer.transform = CATransform3DMakeRotation(angle, 0, 0, 1);
    [ll.layer setNeedsDisplay];
    [superlayer addSublayer:(ll.layer)];
    return ll;
}

//draw the line
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    CGContextSetLineWidth(ctx, 2);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextMoveToPoint(ctx, (self.layer.bounds.size.width / 2), 5 * size + 10);
    CGContextAddLineToPoint(ctx, (self.layer.bounds.size.width / 2), 10);
    
    CGContextSetStrokeColorWithColor(ctx, [[self shiftingColor] CGColor]);
    CGContextStrokePath(ctx);

}


//0.7 for purplish hue
- (UIColor*)shiftingColor {
    return [UIColor colorWithHue:self.hue saturation:0.5 brightness:self.brightness alpha:1];
}


@end