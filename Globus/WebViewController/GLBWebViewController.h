/*--------------------------------------------------*/

#import "GLBViewController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@class UIWebView;
@class WKWebView;

/*--------------------------------------------------*/

@interface GLBWebViewController : GLBViewController

@property(nonatomic, nullable, readonly, strong) UIWebView* uiWebView;
@property(nonatomic, nullable, readonly, strong) WKWebView* wkWebView;
@property(nonatomic) BOOL allowsDoneBarButton;
@property(nonatomic, nonnull, strong) UIBarButtonItem* doneBarButtonItem;
@property(nonatomic, nonnull, strong) UIBarButtonItem* backBarButtonItem;
@property(nonatomic, nonnull, strong) UIBarButtonItem* forwardBarButtonItem;
@property(nonatomic, nonnull, strong) UIBarButtonItem* refreshBarButtonItem;
@property(nonatomic, nonnull, strong) UIBarButtonItem* stopBarButtonItem;
@property(nonatomic, nonnull, strong) UIBarButtonItem* actionBarButtonItem;
@property(nonatomic, nullable, readonly, strong) UIProgressView* progressView;

@property(nonatomic) BOOL allowsWebKit;
@property(nonatomic, nullable, strong) NSBundle* resourcesBundle;

@property(nonatomic, nullable, strong) NSURL* URL;
@property(nonatomic, readonly, getter=isLoading) BOOL loading;
@property(nonatomic, readonly) BOOL canGoBack;
@property(nonatomic, readonly) BOOL canGoForward;

+ (nullable instancetype)webViewControllerWithURL:(nonnull NSURL*)URL GLB_DEPRECATED_MSG("Use viewControllerWithURL:");

+ (nullable instancetype)viewControllerWithURL:(nonnull NSURL*)URL NS_SWIFT_NAME(viewController(url:));

- (nullable instancetype)initWithURL:(nonnull NSURL*)URL;

- (void)reload NS_REQUIRES_SUPER;
- (void)stopLoading NS_REQUIRES_SUPER;
- (void)goBack NS_REQUIRES_SUPER;
- (void)goForward NS_REQUIRES_SUPER;

- (void)didStartLoading;
- (void)didFinishLoading;
- (void)didLoadingError:(nullable NSError*)error;

- (void)share:(nullable id)sender;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
