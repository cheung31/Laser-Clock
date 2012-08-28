#import <Foundation/Foundation.h>

@interface LaserLine : NSObject
@property CALayer* layer;
@property UIView* view;
@property double size;
@property double hue;
@property double brightness;
+(LaserLine* ) createTrailingLineAtAngle:(double) angle InLayer:(CALayer* )superlayer WithSize:(double) size WithHue:(double) hue WithBrightness:(double) brightness;
@end
