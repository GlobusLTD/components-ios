/*--------------------------------------------------*/
#ifndef GLB_RECT_H
#define GLB_RECT_H
/*--------------------------------------------------*/

#include "GLBCG.h"

/*--------------------------------------------------*/

CGRect GLBRectMakeOriginAndSize(CGPoint origin, CGSize size);
CGRect GLBRectMakeCenterPoint(CGPoint center, CGFloat width, CGFloat height);


CGRect GLBRectAdd(CGRect rect, CGFloat value);
CGRect GLBRectSub(CGRect rect, CGFloat value);
CGRect GLBRectMul(CGRect rect, CGFloat value);
CGRect GLBRectDiv(CGRect rect, CGFloat value);
CGRect GLBRectLerp(CGRect from, CGRect to, CGFloat progress);
CGRect GLBRectAspectFillFromBoundsAndSize(CGRect bounds, CGSize size);
CGRect GLBRectAspectFitFromBoundsAndSize(CGRect bounds, CGSize size);

CGRect GLBRectScaleAroundPoint(CGRect rect, CGPoint point, CGFloat sx, CGFloat sy);

CGPoint GLBRectGetTopLeftPoint(CGRect rect);
CGPoint GLBRectGetTopCenterPoint(CGRect rect);
CGPoint GLBRectGetTopRightPoint(CGRect rect);
CGPoint GLBRectGetLeftPoint(CGRect rect);
CGPoint GLBRectGetCenterPoint(CGRect rect);
CGPoint GLBRectGetRightPoint(CGRect rect);
CGPoint GLBRectGetBottomLeftPoint(CGRect rect);
CGPoint GLBRectGetBottomCenterPoint(CGRect rect);
CGPoint GLBRectGetBottomRightPoint(CGRect rect);

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
