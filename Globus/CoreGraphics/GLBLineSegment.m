/*--------------------------------------------------*/

#include "GLBLineSegment.h"
#include "GLBPoint.h"

/*--------------------------------------------------*/

GLBLineSegment GLBLineSegmentMake(CGPoint start, CGPoint end) {
    return (GLBLineSegment){ start, end };
}

GLBLineSegment GLBLineSegmentRotateAroundPoint(GLBLineSegment line, CGPoint pivot, CGFloat angle) {
    return GLBLineSegmentMake(
        GLBPointRotateAroundPoint(line.start, pivot, angle),
        GLBPointRotateAroundPoint(line.end, pivot, angle)
    );
}

CGPoint GLBLineSegmentIntersection(GLBLineSegment ls1, GLBLineSegment ls2) {
    CGFloat x1 = ls1.start.x, y1 = ls1.start.y;
    CGFloat x2 = ls1.end.x, y2 = ls1.end.y;
    CGFloat x3 = ls2.start.x, y3 = ls2.start.y;
    CGFloat x4 = ls2.end.x, y4 = ls2.end.y;
    CGFloat numeratorA = (x4 - x3) * (y1 - y3) - (y4 - y3) * (x1 - x3);
    CGFloat numeratorB = (x2 - x1) * (y1 - y3) - (y2 - y1) * (x1 - x3);
    CGFloat denominator = (y4 - y3) * (x2 - x1) - (x4 - x3) * (y2 - y1);
    if((GLB_FABS(numeratorA) < GLB_EPSILON) && (GLB_FABS(numeratorB) < GLB_EPSILON) && (GLB_FABS(denominator) < GLB_EPSILON)) {
        return CGPointMake((x1 + x2) * 0.5f, (y1 + y2) * 0.5f);
    }
    if(GLB_FABS(denominator) < GLB_EPSILON) {
        return GLBPointInfinity;
    }
    CGFloat uA = numeratorA / denominator;
    CGFloat uB = numeratorB / denominator;
    if((uA < 0.0f) || (uA > 1.0f) || (uB < 0.0f) || (uB > 1.0f)) {
        return GLBPointInfinity;
    }
    return CGPointMake(x1 + uA * (x2 - x1), y1 + uA * (y2 - y1));
}

/*--------------------------------------------------*/
