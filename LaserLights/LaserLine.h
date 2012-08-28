#import <Foundation/Foundation.h>

@interface LaserLine : NSObject
@property CALayer* layer;
@property UIView* view;
@property double size;
+(LaserLine* ) createTrailingLineAtAngle:(double) angle InLayer:(CALayer* )superlayer WithSize:(double) size;
@end
