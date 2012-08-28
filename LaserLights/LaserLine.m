#import "LaserLine.h"
#import <QuartzCore/QuartzCore.h>

@implementation LaserLine

@synthesize layer;
@synthesize view;
@synthesize size;

//make the layer
+(LaserLine* ) createTrailingLineAtAngle:(double)angle InLayer:(CALayer *)superlayer WithSize:(double)size {
    LaserLine* ll = [LaserLine new];
    ll.layer = [CALayer new];
    ll.size = size;
    ll.layer.anchorPoint = CGPointMake(0.5, 1);
    ll.layer.bounds = CGRectMake(0, 0, 20, superlayer.bounds.size.height);
    ll.layer.backgroundColor = CGColorCreateCopyWithAlpha([[UIColor redColor] CGColor], 0);
    ll.layer.delegate = ll;
    ll.layer.position = CGPointMake(superlayer.bounds.size.width / 2, superlayer.bounds.size.height);
    ll.layer.transform = CATransform3DMakeRotation(angle, 0, 0, 1);
    [ll.layer setNeedsDisplay];
    [superlayer addSublayer:(ll.layer)];
    return ll;
}

//draw the line
-(void) drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    CGContextSetLineWidth(ctx, 5.0);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextMoveToPoint(ctx, (self.layer.bounds.size.width / 2), 5 * size + 10);
    CGContextAddLineToPoint(ctx, (self.layer.bounds.size.width / 2), 10);
    
    CGContextSetStrokeColorWithColor(ctx, [[self randomRedishColor] CGColor]);
    CGContextStrokePath(ctx);

}


-(CGFloat)randomIntensity {
    float half = (double) arc4random() / 2;
    return (double) (arc4random() / UINT_MAX) + half;
}

-(UIColor*)randomRedishColor {
    return [UIColor colorWithHue:0.7 saturation:0.5 brightness:[self randomIntensity] alpha:1];
}


@end