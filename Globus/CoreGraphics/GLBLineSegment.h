/*--------------------------------------------------*/
#ifndef GLB_LINE_SEGMENT_H
#define GLB_LINE_SEGMENT_H
/*--------------------------------------------------*/

#include "GLBCG.h"

/*--------------------------------------------------*/

typedef struct {
    CGPoint start;
    CGPoint end;
} GLBLineSegment;

/*--------------------------------------------------*/

GLBLineSegment GLBLineSegmentMake(CGPoint start, CGPoint end);
GLBLineSegment GLBLineSegmentRotateAroundPoint(GLBLineSegment line, CGPoint pivot, CGFloat angle);
CGPoint GLBLineSegmentIntersection(GLBLineSegment ls1, GLBLineSegment ls2);

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
