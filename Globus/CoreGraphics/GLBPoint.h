/*--------------------------------------------------*/
#ifndef GLB_POINT
#define GLB_POINT
/*--------------------------------------------------*/

#include "GLBCG.h"

/*--------------------------------------------------*/

CG_EXTERN const CGPoint GLBPointInfinity;

/*--------------------------------------------------*/

bool GLBPointIsInfinity(CGPoint point);

CGPoint GLBPointAdd(CGPoint point, CGFloat value);
CGPoint GLBPointSub(CGPoint point, CGFloat value);
CGPoint GLBPointMul(CGPoint point, CGFloat value);
CGPoint GLBPointDiv(CGPoint point, CGFloat value);
CGPoint GLBPointAddPoint(CGPoint point1, CGPoint point2);
CGPoint GLBPointSubPoint(CGPoint point1, CGPoint point2);
CGPoint GLBPointMulPoint(CGPoint point1, CGPoint point2);
CGPoint GLBPointDivPoint(CGPoint point1, CGPoint point2);

CGPoint GLBPointLerp(CGPoint from, CGPoint to, CGFloat progress);

CGPoint GLBPointRotateAroundPoint(CGPoint point, CGPoint pivot, CGFloat angle);

CGFloat GLBPointDistance(CGPoint p1, CGPoint p2);

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
