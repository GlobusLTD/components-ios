/*--------------------------------------------------*/

#import "UIImage+GLBUI.h"

/*--------------------------------------------------*/

#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <objc/runtime.h>

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#import <Accelerate/Accelerate.h>

/*--------------------------------------------------*/
#elif defined(GLB_TARGET_WATCHOS)
/*--------------------------------------------------*/

#import <WatchKit/WatchKit.h>

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/

@implementation UIImage (GLB_UI)

+ (CGFloat)glb_scale {
#if defined(GLB_TARGET_IOS)
    CGFloat scale = UIScreen.mainScreen.scale;
#elif defined(GLB_TARGET_WATCHOS)
    CGFloat scale = WKInterfaceDevice.currentDevice.screenScale;
#endif
    return scale;
}

+ (CGFloat)glb_scaleWithPath:(NSString*)path {
    NSRange range3 = [path.lastPathComponent rangeOfString:@"@3x" options:NSCaseInsensitiveSearch];
    if((range3.location != NSNotFound) && (range3.length > 0)) {
        return 3.0f;
    }
    NSRange range2 = [path.lastPathComponent rangeOfString:@"@2x" options:NSCaseInsensitiveSearch];
    if((range2.location != NSNotFound) && (range2.length > 0)) {
        return 2.0f;
    }
    return 1.0f;
}

+ (instancetype)glb_imageNamed:(NSString*)named renderingMode:(UIImageRenderingMode)renderingMode {
    UIImage* result = [self imageNamed:named];
    if(result != nil) {
        result = [result imageWithRenderingMode:renderingMode];
    }
    return result;
}

+ (instancetype)glb_imageNamed:(NSString*)named capInsets:(UIEdgeInsets)capInsets {
    UIImage* result = [self imageNamed:named];
    if(result != nil) {
        result = [result resizableImageWithCapInsets:capInsets];
    }
    return result;
}

+ (instancetype)glb_imageWithColor:(UIColor*)color size:(CGSize)size {
    return [self glb_imageWithColor:color size:size cornerRadius:0];
}

+ (instancetype)glb_imageWithColor:(UIColor*)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius {
    UIImage* image = nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, self.glb_scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if(context != NULL) {
        CGContextSetFillColorWithColor(context, [color CGColor]);
        if(cornerRadius > FLT_EPSILON) {
            CGPathRef path = CGPathCreateWithRoundedRect(CGRectMake(0, 0, size.width, size.height), cornerRadius, cornerRadius, NULL);
            CGContextAddPath(context, path);
            CGContextDrawPath(context, kCGPathFill);
            CGPathRelease(path);
        } else {
            CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
        }
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return image;
}

+ (instancetype)glb_imageWithData:(NSData*)data {
    @autoreleasepool {
        UIImage* image = [UIImage imageWithData:data scale:self.glb_scale];
        if(image == nil) {
            return nil;
        }
        CGImageRef imageRef = image.CGImage;
        CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(imageRef);
        BOOL anyAlpha = ((alphaInfo == kCGImageAlphaFirst) ||
                         (alphaInfo == kCGImageAlphaLast) ||
                         (alphaInfo == kCGImageAlphaPremultipliedFirst) ||
                         (alphaInfo == kCGImageAlphaPremultipliedLast));
        if(anyAlpha == YES) {
            return image;
        }
        CGColorSpaceModel colorSpaceModel = CGColorSpaceGetModel(CGImageGetColorSpace(imageRef));
        CGColorSpaceRef colorSpaceRef = CGImageGetColorSpace(imageRef);
        BOOL unsupportedColorSpace = ((colorSpaceModel == kCGColorSpaceModelUnknown) ||
                                      (colorSpaceModel == kCGColorSpaceModelMonochrome) ||
                                      (colorSpaceModel == kCGColorSpaceModelCMYK) ||
                                      (colorSpaceModel == kCGColorSpaceModelIndexed));
        if(unsupportedColorSpace == YES) {
            colorSpaceRef = CGColorSpaceCreateDeviceRGB();
        }
        size_t width = CGImageGetWidth(imageRef);
        size_t height = CGImageGetHeight(imageRef);
        NSUInteger bytesPerPixel = 4;
        NSUInteger bytesPerRow = bytesPerPixel * width;
        NSUInteger bitsPerComponent = 8;
        CGContextRef context = CGBitmapContextCreate(NULL,
                                                     width,
                                                     height,
                                                     bitsPerComponent,
                                                     bytesPerRow,
                                                     colorSpaceRef,
                                                     kCGBitmapByteOrderDefault | kCGImageAlphaNoneSkipLast);
        CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
        CGImageRef imageRefWithoutAlpha = CGBitmapContextCreateImage(context);
        UIImage* imageWithoutAlpha = [UIImage imageWithCGImage:imageRefWithoutAlpha
                                                         scale:image.scale
                                                   orientation:image.imageOrientation];
        
        if(unsupportedColorSpace == YES) {
            CGColorSpaceRelease(colorSpaceRef);
        }
        CGContextRelease(context);
        CGImageRelease(imageRefWithoutAlpha);
        return imageWithoutAlpha;
    }
}

- (instancetype)glb_unrotate {
    UIImage* result = nil;
    CGImageRef imageRef = self.CGImage;
    if(imageRef != NULL) {
        CGSize originalSize = CGSizeMake(CGImageGetWidth(imageRef), CGImageGetHeight(imageRef));
        CGSize finalSize = CGSizeZero;
        CGAffineTransform transform = CGAffineTransformIdentity;
        switch(self.imageOrientation) {
            case UIImageOrientationUp: {
                transform = CGAffineTransformIdentity;
                finalSize = originalSize;
                break;
            }
            case UIImageOrientationUpMirrored: {
                transform = CGAffineTransformMakeTranslation(originalSize.width, 0);
                transform = CGAffineTransformScale(transform, -1, 1);
                finalSize = originalSize;
                break;
            }
            case UIImageOrientationDown: {
                transform = CGAffineTransformMakeTranslation(originalSize.width, originalSize.height);
                transform = CGAffineTransformRotate(transform, (CGFloat)(M_PI));
                finalSize = originalSize;
                break;
            }
            case UIImageOrientationDownMirrored: {
                transform = CGAffineTransformMakeTranslation(0, originalSize.height);
                transform = CGAffineTransformScale(transform, 1, -1);
                finalSize = originalSize;
                break;
            }
            case UIImageOrientationLeftMirrored: {
                transform = CGAffineTransformMakeTranslation(originalSize.height, originalSize.width);
                transform = CGAffineTransformScale(transform, -1, 1);
                transform = CGAffineTransformRotate(transform, 3 * (CGFloat)M_PI / 2);
                finalSize = CGSizeMake(originalSize.height, originalSize.width);
                break;
            }
            case UIImageOrientationLeft: {
                transform = CGAffineTransformMakeTranslation(0, originalSize.width);
                transform = CGAffineTransformRotate(transform, 3 * (CGFloat)M_PI / 2);
                finalSize = CGSizeMake(originalSize.height, originalSize.width);
                break;
            }
            case UIImageOrientationRightMirrored: {
                transform = CGAffineTransformMakeScale(-1, 1);
                transform = CGAffineTransformRotate(transform, (CGFloat)M_PI / 2);
                finalSize = CGSizeMake(originalSize.height, originalSize.width);
                break;
            }
            case UIImageOrientationRight: {
                transform = CGAffineTransformMakeTranslation(originalSize.height, 0);
                transform = CGAffineTransformRotate(transform, (CGFloat)M_PI / 2);
                finalSize = CGSizeMake(originalSize.height, originalSize.width);
                break;
            }
            default:
                break;
        }
        if((finalSize.width > FLT_EPSILON) && (finalSize.height > FLT_EPSILON)) {
            UIGraphicsBeginImageContextWithOptions(finalSize, NO, self.class.glb_scale);
            CGContextRef context = UIGraphicsGetCurrentContext();
            if(context != NULL) {
                switch(self.imageOrientation) {
                    case UIImageOrientationRight:
                    case UIImageOrientationLeft:
                        CGContextScaleCTM(context, -1, 1);
                        CGContextTranslateCTM(context, -originalSize.height, 0);
                        break;
                    default:
                        CGContextScaleCTM(context, 1, -1);
                        CGContextTranslateCTM(context, 0, -originalSize.height);
                        break;
                }
                CGContextConcatCTM(context, transform);
                CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, originalSize.width, originalSize.height), imageRef);
                result = UIGraphicsGetImageFromCurrentImageContext();
            }
            UIGraphicsEndImageContext();
        }
    }
    return result;
}

- (instancetype)glb_scaleToSize:(CGSize)size {
    UIImage* result = nil;
    CGColorSpaceRef colourSpace = CGColorSpaceCreateDeviceRGB();
    if(colourSpace != NULL) {
        CGRect drawRect = GLBRectAspectFitFromBoundsAndSize(CGRectMake(0, 0, size.width, size.height), self.size);
        drawRect.size.width = (CGFloat)floorf((float)drawRect.size.width);
        drawRect.size.height = (CGFloat)floorf((float)drawRect.size.height);
        
        CGContextRef context = CGBitmapContextCreate(NULL, (size_t)(drawRect.size.width), (size_t)(drawRect.size.height), 8, (size_t)(drawRect.size.width * 4), colourSpace, kCGBitmapByteOrder32Big | kCGImageAlphaPremultipliedLast);
        if(context != NULL) {
            CGContextClearRect(context, CGRectMake(0, 0, drawRect.size.width, drawRect.size.height));
            CGContextDrawImage(context, CGRectMake(0, 0, drawRect.size.width, drawRect.size.height), self.CGImage);
            
            CGImageRef image = CGBitmapContextCreateImage(context);
            if(image != NULL) {
                result = [UIImage imageWithCGImage:image scale:self.scale orientation:self.imageOrientation];
                CGImageRelease(image);
            }
            CGContextRelease(context);
        }
        CGColorSpaceRelease(colourSpace);
    }
    return result;
}

- (instancetype)glb_rotateToAngleInRadians:(CGFloat)angleInRadians {
    UIImage* result = nil;
    CGSize size = self.size;
    if((size.width > 0) && (size.height > 0)) {
        UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
        CGContextRef context = UIGraphicsGetCurrentContext();
        if(context != NULL) {
            CGContextTranslateCTM(context, 0.5f * size.width, 0.5f * size.height);
            CGContextRotateCTM(context, angleInRadians);
            CGContextTranslateCTM(context, -0.5f * size.width, -0.5f * size.height);
            [self drawAtPoint:CGPointZero];
            result = UIGraphicsGetImageFromCurrentImageContext();
        }
        UIGraphicsEndImageContext();
    }
    return result;
}

- (instancetype)glb_grayscale {
    UIImage* result = nil;
    CGSize size = self.size;
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    if(colorSpace != NULL) {
        CGContextRef context = CGBitmapContextCreate(nil, (size_t)(size.width), (size_t)(size.height), 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaNone);
        if(context != NULL) {
            CGContextDrawImage(context, rect, [self CGImage]);
            CGImageRef grayscale = CGBitmapContextCreateImage(context);
            if(grayscale != NULL) {
                result = [UIImage imageWithCGImage:grayscale];
                CGImageRelease(grayscale);
            }
            CGContextRelease(context);
        }
        CGColorSpaceRelease(colorSpace);
    }
    return result;
}

- (instancetype)glb_blackAndWhite {
    UIImage* result = nil;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    if(colorSpace != NULL) {
        CGContextRef context = CGBitmapContextCreate(nil, (size_t)(self.size.width), (size_t)(self.size.height), 8, (size_t)(self.size.width), colorSpace, (CGBitmapInfo)kCGImageAlphaNone);
        if(colorSpace != NULL) {
            CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
            CGContextSetShouldAntialias(context, NO);
            CGContextDrawImage(context, CGRectMake(0, 0, self.size.width, self.size.height), self.CGImage);
            CGImageRef bwImage = CGBitmapContextCreateImage(context);
            if(bwImage != NULL) {
                result = [UIImage imageWithCGImage:bwImage];
                CGImageRelease(bwImage);
            }
            CGContextRelease(context);
        }
        CGColorSpaceRelease(colorSpace);
    }
    return result;
}

- (instancetype)glb_invertColors {
    UIImage* result = nil;
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.class.glb_scale);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeCopy);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeDifference);
    CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), UIColor.whiteColor.CGColor);
    CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, self.size.width, self.size.height));
    result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

#if defined(GLB_TARGET_IOS)

- (instancetype)glb_blurredImageWithRadius:(CGFloat)radius iterations:(NSUInteger)iterations tintColor:(UIColor*)tintColor {
    UIImage* image = nil;
    CGSize size = self.size;
    CGFloat scale = self.scale;
    if((floorf((float)size.width) * floorf((float)size.height)) > FLT_EPSILON) {
        CGImageRef imageRef = self.CGImage;
        uint32_t boxSize = (uint32_t)(radius * scale);
        if(boxSize % 2 == 0) {
            boxSize++;
        }
        vImage_Buffer buffer1;
        buffer1.width = CGImageGetWidth(imageRef);
        buffer1.height = CGImageGetHeight(imageRef);
        buffer1.rowBytes = CGImageGetBytesPerRow(imageRef);
        size_t bytes = buffer1.rowBytes * buffer1.height;
        buffer1.data = malloc(bytes);
        if(buffer1.data != NULL) {
            vImage_Buffer buffer2;
            buffer2.width = buffer1.width;
            buffer2.height = buffer1.height;
            buffer2.rowBytes = buffer1.rowBytes;
            buffer2.data = malloc(bytes);
            if(buffer2.data != nil) {
                size_t tempBufferSize = (size_t)vImageBoxConvolve_ARGB8888(&buffer1, &buffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend + kvImageGetTempBufferSize);
                if(tempBufferSize > 0) {
                    void* tempBuffer = malloc(tempBufferSize);
                    if(tempBuffer != nil) {
                        CFDataRef dataSource = CGDataProviderCopyData(CGImageGetDataProvider(imageRef));
                        if(dataSource != NULL) {
                            memcpy(buffer1.data, CFDataGetBytePtr(dataSource), bytes);
                            CFRelease(dataSource);
                        }
                        for(NSUInteger i = 0; i < iterations; i++) {
                            if(vImageBoxConvolve_ARGB8888(&buffer1, &buffer2, tempBuffer, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend) == kvImageNoError) {
                                void* temp = buffer1.data;
                                buffer1.data = buffer2.data;
                                buffer2.data = temp;
                            }
                        }
                        free(tempBuffer);
                        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                        if(colorSpace != nil) {
                            CGContextRef context = CGBitmapContextCreate(buffer1.data, buffer1.width, buffer1.height, 8, buffer1.rowBytes, colorSpace, kCGImageAlphaPremultipliedLast);
                            if(context != NULL) {
                                if(tintColor != nil) {
                                    if(CGColorGetAlpha(tintColor.CGColor) > 0) {
                                        CGContextSetFillColorWithColor(context, [[tintColor colorWithAlphaComponent:0.25] CGColor]);
                                        CGContextSetBlendMode(context, kCGBlendModePlusDarker);
                                        CGContextFillRect(context, CGRectMake(0, 0, buffer1.width, buffer1.height));
                                    }
                                }
                                imageRef = CGBitmapContextCreateImage(context);
                                if(imageRef != nil) {
                                    image = [UIImage imageWithCGImage:imageRef scale:scale orientation:self.imageOrientation];
                                    CGImageRelease(imageRef);
                                }
                                CGContextRelease(context);
                            }
                            CGColorSpaceRelease(colorSpace);
                        }
                    }
                }
                free(buffer2.data);
            }
            free(buffer1.data);
        }
    }
    return image;
}

#endif

- (void)glb_drawInRect:(CGRect)rect alignment:(GLBUIImageAlignment)alignment {
    return [self glb_drawInRect:rect alignment:alignment corners:UIRectCornerAllCorners radius:0 blendMode:kCGBlendModeNormal alpha:1];
}

- (void)glb_drawInRect:(CGRect)rect alignment:(GLBUIImageAlignment)alignment blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha {
    return [self glb_drawInRect:rect alignment:alignment corners:UIRectCornerAllCorners radius:0 blendMode:blendMode alpha:alpha];
}

- (void)glb_drawInRect:(CGRect)rect alignment:(GLBUIImageAlignment)alignment radius:(CGFloat)radius {
    return [self glb_drawInRect:rect alignment:alignment corners:UIRectCornerAllCorners radius:radius blendMode:kCGBlendModeNormal alpha:1];
}

- (void)glb_drawInRect:(CGRect)rect alignment:(GLBUIImageAlignment)alignment radius:(CGFloat)radius blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha {
    return [self glb_drawInRect:rect alignment:alignment corners:UIRectCornerAllCorners radius:radius blendMode:blendMode alpha:alpha];
}

- (void)glb_drawInRect:(CGRect)rect alignment:(GLBUIImageAlignment)alignment corners:(UIRectCorner)corners radius:(CGFloat)radius {
    return [self glb_drawInRect:rect alignment:alignment corners:corners radius:radius blendMode:kCGBlendModeNormal alpha:1];
}

- (void)glb_drawInRect:(CGRect)rect alignment:(GLBUIImageAlignment)alignment corners:(UIRectCorner)corners radius:(CGFloat)radius blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha {
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSaveGState(contextRef);
    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    [path addClip];
    switch(alignment) {
        case GLBUIImageAlignmentStretch: break;
        case GLBUIImageAlignmentAspectFill: rect = GLBRectAspectFillFromBoundsAndSize(rect, self.size); break;
        case GLBUIImageAlignmentAspectFit: rect = GLBRectAspectFitFromBoundsAndSize(rect, self.size); break;
    }
    [self drawInRect:rect blendMode:blendMode alpha:alpha];
    CGContextRestoreGState(contextRef);
}

@end

/*--------------------------------------------------*/

BOOL GLBImageIsGifData(NSData* data) {
    if(data.length > 4) {
        const unsigned char * bytes = data.bytes;
        return ((bytes[0] == 0x47) && (bytes[1] == 0x49) && (bytes[2] == 0x46));
    }
    return NO;
}

UIImage* GLBImageWithGIFDataDefault(NSData* data) {
    return GLBImageWithGIFData(data, UIImage.glb_scale, nil);
}

UIImage* GLBImageWithGIFData(NSData* data, CGFloat scale, NSError** error) {
    UIImage* result = nil;
    CFMutableDictionaryRef options = CFDictionaryCreateMutable(kCFAllocatorDefault, 2, &kCFCopyStringDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    if(options != NULL) {
        CFDictionarySetValue(options, kCGImageSourceShouldCache, kCFBooleanTrue);
        CFDictionarySetValue(options, kUTTypeGIF, kCGImageSourceTypeIdentifierHint);
        CGImageSourceRef imageSource = CGImageSourceCreateWithData((__bridge CFDataRef)data, options);
        if(imageSource != NULL) {
            CFDictionaryRef imageSourceOptions = CGImageSourceCopyProperties(imageSource, options);
            if(imageSourceOptions != NULL) {
                UIImageOrientation imageOrientation = UIImageOrientationUp;
                CFNumberRef imageSourceOrientation = CFDictionaryGetValue(imageSourceOptions, kCGImagePropertyOrientation);
                if(imageSourceOrientation != NULL) {
                    CFNumberGetValue(imageSourceOrientation, kCFNumberNSIntegerType, &imageOrientation);
                }
                size_t numberOfFrames = CGImageSourceGetCount(imageSource);
                if(numberOfFrames > 1) {
                    NSMutableArray* images = [NSMutableArray arrayWithCapacity:numberOfFrames];
                    NSTimeInterval duration = 0.0f;
                    for(size_t index = 0; index < numberOfFrames; index++) {
                        CGImageRef image = CGImageSourceCreateImageAtIndex(imageSource, index, options);
                        if(image != NULL) {
                            [images addObject:[UIImage imageWithCGImage:image scale:scale orientation:imageOrientation]];
                            
                            CFDictionaryRef imageOptions = CGImageSourceCopyPropertiesAtIndex(imageSource, index, NULL);
                            if(imageOptions != NULL) {
                                CFDictionaryRef gifImageOptions = CFDictionaryGetValue(imageOptions, kCGImagePropertyGIFDictionary);
                                if(gifImageOptions != NULL) {
                                    NSTimeInterval imageDuration = 0.0f;
                                    CFNumberRef gifImageDelayTime = CFDictionaryGetValue(gifImageOptions, kCGImagePropertyGIFDelayTime);
                                    if(gifImageDelayTime != NULL) {
                                        CFNumberGetValue(gifImageDelayTime, kCFNumberDoubleType, &imageDuration);
                                    }
                                    duration += imageDuration;
                                }
                                CFRelease(imageOptions);
                            }
                            CGImageRelease(image);
                        }
                    }
                    result = [UIImage animatedImageWithImages:images duration:duration];
                } else if(numberOfFrames > 0) {
                    CGImageRef image = CGImageSourceCreateImageAtIndex(imageSource, 0, options);
                    if(image != NULL) {
                        result = [UIImage imageWithCGImage:image scale:scale orientation:imageOrientation];
                        CGImageRelease(image);
                    }
                } else if(error != nil){
                    // TODO
                }
                CFRelease(imageSourceOptions);
            } else if(error != nil){
                // TODO
            }
            CFRelease(imageSource);
        } else if(error != nil) {
            // TODO
        }
        CFRelease(options);
    } else if(error != nil){
        // TODO
    }
    return result;
}

NSData* GLBImageGIFRepresentationDefault(UIImage* image) {
    return GLBImageGIFRepresentation(image, 0, nil);
}

NSData* GLBImageGIFRepresentation(UIImage* image, NSUInteger loopCount, NSError** error) {
    CFMutableDataRef data = CFDataCreateMutable(kCFAllocatorDefault, 1024 * 1024);
    if(data != NULL) {
        NSArray< UIImage* >* images = image.images;
        size_t numberOfFrames = images.count;
        NSTimeInterval duration = image.duration;
        NSTimeInterval durationPerFrame = duration / numberOfFrames;
        CFMutableDictionaryRef options = CFDictionaryCreateMutable(kCFAllocatorDefault, 1, &kCFCopyStringDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
        if(options != NULL) {
            CFMutableDictionaryRef gifOptions = CFDictionaryCreateMutable(kCFAllocatorDefault, 1, &kCFCopyStringDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
            if(gifOptions != NULL) {
                CFNumberRef gifLoopCount = CFNumberCreate(kCFAllocatorDefault, kCFNumberNSIntegerType, &loopCount);
                if(gifLoopCount != NULL) {
                    CFDictionarySetValue(gifOptions, kCGImagePropertyGIFLoopCount, gifLoopCount);
                    CFRelease(gifLoopCount);
                }
                CFDictionarySetValue(options, kCGImagePropertyGIFDictionary, gifOptions);
                CFRelease(gifOptions);
            }
            CFRelease(options);
        }
        CFMutableDictionaryRef frameOptions = CFDictionaryCreateMutable(kCFAllocatorDefault, 1, &kCFCopyStringDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
        if(frameOptions != NULL) {
            CFMutableDictionaryRef gifOptions = CFDictionaryCreateMutable(kCFAllocatorDefault, 1, &kCFCopyStringDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
            if(gifOptions != NULL) {
                CFNumberRef gifDelayTime = CFNumberCreate(kCFAllocatorDefault, kCFNumberDoubleType, &durationPerFrame);
                if(gifDelayTime != NULL) {
                    CFDictionarySetValue(gifOptions, kCGImagePropertyGIFDelayTime, gifDelayTime);
                    CFRelease(gifDelayTime);
                }
                CFDictionarySetValue(frameOptions, kCGImagePropertyGIFDictionary, gifOptions);
                CFRelease(gifOptions);
            }
            CFRelease(frameOptions);
        }
        CGImageDestinationRef imageDest = CGImageDestinationCreateWithData(data, kUTTypeGIF, numberOfFrames, NULL);
        if(imageDest != NULL) {
            CGImageDestinationSetProperties(imageDest, options);
            for(size_t index = 0; index < images.count; index++) {
                CGImageRef image = [images[index] CGImage];
                CGImageDestinationAddImage(imageDest, image, frameOptions);
            }
            if(CGImageDestinationFinalize(imageDest) == NO) {
                CFRelease(data);
                data = NULL;
                if(error != nil) {
                    // TODO
                }
            }
            CFRelease(imageDest);
        }
    }
    if((data != NULL) && (CFDataGetLength(data) < 1)) {
        CFRelease(data);
        data = NULL;
    }
    return (__bridge NSData*)(data);
}

/*--------------------------------------------------*/

@interface UIImage (GLB_Image_Gif)
@end

/*--------------------------------------------------*/

static inline void GLBImageSwizzleSelector(Class aClass, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(aClass, originalSelector);
    IMP originalImp = method_getImplementation(originalMethod);
    const char* originalType = method_getTypeEncoding(originalMethod);
    Method swizzledMethod = class_getInstanceMethod(aClass, swizzledSelector);
    IMP swizzledImp = method_getImplementation(swizzledMethod);
    const char* swizzledType = method_getTypeEncoding(swizzledMethod);
    if(class_addMethod(aClass, originalSelector, swizzledImp, swizzledType) == YES) {
        class_replaceMethod(aClass, swizzledSelector, originalImp, originalType);
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

/*--------------------------------------------------*/

@implementation UIImage (GLB_Image_Gif)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            Class selfClass = object_getClass((id)self);
            GLBImageSwizzleSelector(selfClass, @selector(imageWithData:), @selector(glb_imageWithData:));
            GLBImageSwizzleSelector(selfClass, @selector(imageWithData:scale:), @selector(glb_imageWithData:scale:));
            GLBImageSwizzleSelector(selfClass, @selector(imageWithContentsOfFile:), @selector(glb_imageWithContentsOfFile:));
            GLBImageSwizzleSelector(self, @selector(initWithContentsOfFile:), @selector(glb_initWithContentsOfFile:));
            GLBImageSwizzleSelector(self, @selector(initWithData:), @selector(glb_initWithData:));
            GLBImageSwizzleSelector(self, @selector(initWithData:scale:), @selector(glb_initWithData:scale:));
        }
    });
}

+ (instancetype)glb_imageWithContentsOfFile:(NSString*)path {
    if(path != nil) {
        NSData* data = [NSData dataWithContentsOfFile:path];
        if((data != nil) && (GLBImageIsGifData(data) == YES)) {
            CGFloat scale = [self glb_scaleWithPath:path];
            return GLBImageWithGIFData(data, scale, nil);
        }
    }
    return [self glb_imageWithContentsOfFile:path];
}

+ (instancetype)glb_imageWithData:(NSData*)data {
    if((data != nil) && (GLBImageIsGifData(data) == YES)) {
        return GLBImageWithGIFDataDefault(data);
    }
    return [self glb_imageWithData:data];
}

+ (instancetype)glb_imageWithData:(NSData*)data scale:(CGFloat)scale {
    if((data != nil) && (GLBImageIsGifData(data) == YES)) {
        return GLBImageWithGIFData(data, scale, nil);
    }
    return [self glb_imageWithData:data scale:scale];
}

- (instancetype)glb_initWithContentsOfFile:(NSString *)path {
    if(path != nil) {
        NSData* data = [NSData dataWithContentsOfFile:path];
        if((data != nil) && (GLBImageIsGifData(data) == YES)) {
            CGFloat scale = [self.class glb_scaleWithPath:path];
            return GLBImageWithGIFData(data, scale, nil);
        }
    }
    return [self glb_initWithContentsOfFile:path];
}

- (instancetype)glb_initWithData:(NSData*)data {
    if((data != nil) && (GLBImageIsGifData(data) == YES)) {
        return GLBImageWithGIFDataDefault(data);
    }
    return [self glb_initWithData:data];
}

- (instancetype)glb_initWithData:(NSData*)data scale:(CGFloat)scale {
    if((data != nil) && (GLBImageIsGifData(data) == YES)) {
        return GLBImageWithGIFData(data, scale, nil);
    }
    return [self glb_initWithData:data scale:scale];
}

@end

/*--------------------------------------------------*/
