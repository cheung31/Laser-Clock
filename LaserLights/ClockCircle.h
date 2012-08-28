#import <Foundation/Foundation.h>

@interface ClockCircle : NSObject
@property float size;
+(void) drawCircleWithSize:(float) size InView:(UIView* ) view;
@end