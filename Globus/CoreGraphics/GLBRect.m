/*--------------------------------------------------*/

#include "GLBRect.h"

/*--------------------------------------------------*/

CGRect GLBRectMakeOriginAndSize(CGPoint origin, CGSize size) {
    return CGRectMake(origin.x, origin.y, size.width, size.height);
}

CGRect GLBRectMakeCenterPoint(CGPoint center, CGFloat width, CGFloat height) {
    return CGRectMake(center.x - (width * 0.5f),
                      center.y - (height * 0.5f),
                      width,
                      height);
}

CGRect GLBRectAdd(CGRect rect, CGFloat value) {
    return CGRectMake(rect.origin.x + value,
                      rect.origin.y + value,
                      rect.size.width + value,
                      rect.size.height + value);
}

CGRect GLBRectSub(CGRect rect, CGFloat value) {
    return CGRectMake(rect.origin.x - value,
                      rect.origin.y - value,
                      rect.size.width - value,
                      rect.size.height - value);
}

CGRect GLBRectMul(CGRect rect, CGFloat value) {
    return CGRectMake(rect.origin.x * value,
                      rect.origin.y * value,
                      rect.size.width * value,
                      rect.size.height * value);
}

CGRect GLBRectDiv(CGRect rect, CGFloat value) {
    return CGRectMake(rect.origin.x / value,
                      rect.origin.y / value,
                      rect.size.width / value,
                      rect.size.height / value);
}

CGRect GLBRectLerp(CGRect from, CGRect to, CGFloat progress) {
    return CGRectMake(GLBFloatLerp(from.origin.x, to.origin.x, progress),
                      GLBFloatLerp(from.origin.y, to.origin.y, progress),
                      GLBFloatLerp(from.size.width, to.size.width, progress),
                      GLBFloatLerp(from.size.height, to.size.height, progress));
}

CGRect GLBRectAspectFillFromBoundsAndSize(CGRect bounds, CGSize size) {
    CGFloat iw = GLB_FLOOR(size.width);
    CGFloat ih = GLB_FLOOR(size.height);
    CGFloat bw = GLB_FLOOR(bounds.size.width);
    CGFloat bh = GLB_FLOOR(bounds.size.height);
    CGFloat fw = bw / iw;
    CGFloat fh = bh / ih;
    CGFloat scale = (fw > fh) ? fw : fh;
    CGFloat rw = iw * scale;
    CGFloat rh = ih * scale;
    CGFloat rx = (bw - rw) * 0.5f;
    CGFloat ry = (bh - rh) * 0.5f;
    return CGRectMake(bounds.origin.x + rx, bounds.origin.y + ry, rw, rh);
}

CGRect GLBRectAspectFitFromBoundsAndSize(CGRect bounds, CGSize size) {
    CGFloat iw = GLB_FLOOR(size.width);
    CGFloat ih = GLB_FLOOR(size.height);
    CGFloat bw = GLB_FLOOR(bounds.size.width);
    CGFloat bh = GLB_FLOOR(bounds.size.height);
    CGFloat fw = bw / iw;
    CGFloat fh = bh / ih;
    CGFloat scale = (fw < fh) ? fw : fh;
    CGFloat rw = iw * scale;
    CGFloat rh = ih * scale;
    CGFloat rx = (bw - rw) * 0.5f;
    CGFloat ry = (bh - rh) * 0.5f;
    return CGRectMake(bounds.origin.x + rx, bounds.origin.y + ry, rw, rh);
}

CGRect GLBRectScaleAroundPoint(CGRect rect, CGPoint point, CGFloat sx, CGFloat sy) {
    rect = CGRectApplyAffineTransform(rect, CGAffineTransformMakeTranslation(-point.x, -point.y));
    rect = CGRectApplyAffineTransform(rect, CGAffineTransformMakeScale(sx, sy));
    rect = CGRectApplyAffineTransform(rect, CGAffineTransformMakeTranslation(point.x, point.y));
    return rect;
}

CGPoint GLBRectGetTopLeftPoint(CGRect rect) {
    return CGPointMake(CGRectGetMinX(rect),
                       CGRectGetMinY(rect));
}

CGPoint GLBRectGetTopCenterPoint(CGRect rect) {
    return CGPointMake(CGRectGetMidX(rect),
                       CGRectGetMinY(rect));
}

CGPoint GLBRectGetTopRightPoint(CGRect rect) {
    return CGPointMake(CGRectGetMaxX(rect),
                       CGRectGetMinY(rect));
}

CGPoint GLBRectGetLeftPoint(CGRect rect) {
    return CGPointMake(CGRectGetMinX(rect),
                       CGRectGetMidY(rect));
}

CGPoint GLBRectGetCenterPoint(CGRect rect) {
    return CGPointMake(CGRectGetMidX(rect),
                       CGRectGetMidY(rect));
}

CGPoint GLBRectGetRightPoint(CGRect rect) {
    return CGPointMake(CGRectGetMaxX(rect),
                       CGRectGetMidY(rect));
}

CGPoint GLBRectGetBottomLeftPoint(CGRect rect) {
    return CGPointMake(CGRectGetMinX(rect),
                       CGRectGetMaxY(rect));
}

CGPoint GLBRectGetBottomCenterPoint(CGRect rect) {
    return CGPointMake(CGRectGetMidX(rect),
                       CGRectGetMaxY(rect));
}

CGPoint GLBRectGetBottomRightPoint(CGRect rect) {
    return CGPointMake(CGRectGetMaxX(rect),
                       CGRectGetMaxY(rect));
}

/*--------------------------------------------------*/
