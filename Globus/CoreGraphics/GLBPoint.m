/*--------------------------------------------------*/

#include "GLBPoint.h"

/*--------------------------------------------------*/

const CGPoint GLBPointInfinity = { INFINITY, INFINITY };

/*--------------------------------------------------*/

bool GLBPointIsInfinity(CGPoint point) {
    return CGPointEqualToPoint(point, GLBPointInfinity);
}

CGPoint GLBPointAdd(CGPoint point, CGFloat value) {
    return CGPointMake(point.x + value,
                       point.y + value);
}

CGPoint GLBPointSub(CGPoint point, CGFloat value) {
    return CGPointMake(point.x - value,
                       point.y - value);
}

CGPoint GLBPointMul(CGPoint point, CGFloat value) {
    return CGPointMake(point.x * value,
                       point.y * value);
}

CGPoint GLBPointDiv(CGPoint point, CGFloat value) {
    return CGPointMake(point.x / value,
                       point.y / value);
}

CGPoint GLBPointAddPoint(CGPoint point1, CGPoint point2) {
    return CGPointMake(point1.x + point2.x,
                       point1.y + point2.y);
}

CGPoint GLBPointSubPoint(CGPoint point1, CGPoint point2) {
    return CGPointMake(point1.x - point2.x,
                       point1.y - point2.y);
}

CGPoint GLBPointMulPoint(CGPoint point1, CGPoint point2) {
    return CGPointMake(point1.x * point2.x,
                       point1.y * point2.y);
}

CGPoint GLBPointDivPoint(CGPoint point1, CGPoint point2) {
    return CGPointMake(point1.x / point2.x,
                       point1.y / point2.y);
}

CGPoint GLBPointLerp(CGPoint from, CGPoint to, CGFloat progress) {
    return CGPointMake(GLBFloatLerp(from.x, to.x, progress),
                       GLBFloatLerp(from.y, to.y, progress));
}

CGPoint GLBPointRotateAroundPoint(CGPoint point, CGPoint pivot, CGFloat angle) {
    point = CGPointApplyAffineTransform(point, CGAffineTransformMakeTranslation(-pivot.x, -pivot.y));
    point = CGPointApplyAffineTransform(point, CGAffineTransformMakeRotation(angle));
    point = CGPointApplyAffineTransform(point, CGAffineTransformMakeTranslation(pivot.x, pivot.y));
    return point;
}

CGFloat GLBPointDistance(CGPoint p1, CGPoint p2) {
    CGFloat pow1 = GLB_POW(p1.x - p2.x, 2);
    CGFloat pow2 = GLB_POW(p1.y - p2.y, 2);
    return GLB_SQRT(pow1 + pow2);
}

/*--------------------------------------------------*/
