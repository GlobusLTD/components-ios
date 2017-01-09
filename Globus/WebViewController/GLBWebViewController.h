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
@property(nonatomic, nullable, strong) UIBarButtonItem* doneBarButtonItem;
@property(nonatomic, nullable, strong) UIBarButtonItem* backBarButtonItem;
@property(nonatomic, nullable, strong) UIBarButtonItem* forwardBarButtonItem;
@property(nonatomic, nullable, strong) UIBarButtonItem* refreshBarButtonItem;
@property(nonatomic, nullable, strong) UIBarButtonItem* stopBarButtonItem;
@property(nonatomic, nullable, strong) UIBarButtonItem* actionBarButtonItem;
@property(nonatomic, nullable, readonly, strong) UIProgressView* progressView;

@property(nonatomic) BOOL allowsWebKit;
@property(nonatomic, nullable, strong) NSBundle* resourcesBundle;

@property(nonatomic, nullable, strong) NSURL* URL;
@property(nonatomic, readonly, assign, getter=isLoading) BOOL loading;
@property(nonatomic, readonly, assign) BOOL canGoBack;
@property(nonatomic, readonly, assign) BOOL canGoForward;

+ (instancetype _Nullable)webViewControllerWithURL:(NSURL* _Nonnull)URL GLB_DEPRECATED_MSG("Use viewControllerWithURL:");

+ (instancetype _Nullable)viewControllerWithURL:(NSURL* _Nonnull)URL NS_SWIFT_NAME(viewController(url:));

- (instancetype _Nullable)initWithURL:(NSURL* _Nonnull)URL;

- (void)reload NS_REQUIRES_SUPER;
- (void)stopLoading NS_REQUIRES_SUPER;
- (void)goBack NS_REQUIRES_SUPER;
- (void)goForward NS_REQUIRES_SUPER;

- (void)didStartLoading;
- (void)didFinishLoading;
- (void)didLoadingError:(NSError* _Nullable)error;

- (void)updateNavigationItems;

- (void)share:(id _Nullable)sender;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
