/*--------------------------------------------------*/

#import "GLBViewController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@class UIWebView;
@class WKWebView;

/*--------------------------------------------------*/

@interface GLBWebViewController : GLBViewController

@property(nonatomic, readonly, strong) UIWebView* uiWebView;
@property(nonatomic, readonly, strong) WKWebView* wkWebView;
@property(nonatomic, strong) UIBarButtonItem* doneBarButtonItem;
@property(nonatomic, strong) UIBarButtonItem* backBarButtonItem;
@property(nonatomic, strong) UIBarButtonItem* forwardBarButtonItem;
@property(nonatomic, strong) UIBarButtonItem* refreshBarButtonItem;
@property(nonatomic, strong) UIBarButtonItem* stopBarButtonItem;
@property(nonatomic, strong) UIBarButtonItem* actionBarButtonItem;
@property(nonatomic, readonly, strong) UIProgressView* progressView;

@property(nonatomic) BOOL allowsWebKit;
@property(nonatomic, strong) NSBundle* resourcesBundle;

@property(nonatomic, strong) NSURL* URL;
@property(nonatomic, readonly, assign, getter=isLoading) BOOL loading;
@property(nonatomic, readonly, assign) BOOL canGoBack;
@property(nonatomic, readonly, assign) BOOL canGoForward;

+ (instancetype)webViewControllerWithURL:(NSURL*)URL;

- (instancetype)initWithURL:(NSURL*)URL;

- (void)reload NS_REQUIRES_SUPER;
- (void)stopLoading NS_REQUIRES_SUPER;
- (void)goBack NS_REQUIRES_SUPER;
- (void)goForward NS_REQUIRES_SUPER;

- (void)didStartLoading;
- (void)didFinishLoading;
- (void)didLoadingError:(NSError*)error;

- (void)updateNavigationItems;

- (void)share:(id)sender;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
