/*--------------------------------------------------*/

#import "GLBWebViewController.h"
#import "NSBundle+GLBNS.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#import <WebKit/WebKit.h>

/*--------------------------------------------------*/

@interface GLBWebViewController () < UIWebViewDelegate, WKUIDelegate, WKNavigationDelegate >

@property(nonatomic, nonnull, strong) UIBarButtonItem* fixedSpaceItem;
@property(nonatomic, nonnull, strong) UIBarButtonItem* flexibleSpaceItem;

@end

/*--------------------------------------------------*/

@implementation GLBWebViewController

#pragma mark - Synthesize

@synthesize uiWebView = _uiWebView;
@synthesize wkWebView = _wkWebView;
@synthesize doneBarButtonItem = _doneBarButtonItem;
@synthesize backBarButtonItem = _backBarButtonItem;
@synthesize forwardBarButtonItem = _forwardBarButtonItem;
@synthesize refreshBarButtonItem = _refreshBarButtonItem;
@synthesize stopBarButtonItem = _stopBarButtonItem;
@synthesize actionBarButtonItem = _actionBarButtonItem;
@synthesize progressView = _progressView;
@synthesize resourcesBundle = _resourcesBundle;

#pragma mark - Init / Free

+ (instancetype)webViewControllerWithURL:(NSURL*)URL {
    return [[self alloc] initWithURL:URL];
}

+ (instancetype)viewControllerWithURL:(NSURL*)URL {
    return [[self alloc] initWithURL:URL];
}

- (instancetype)initWithURL:(NSURL*)URL {
    self = [super initWithNibName:nil bundle:nil];
    if(self != nil) {
        _URL = URL;
    }
    return self;
}

- (void)setup {
    [super setup];
    
    self.toolbarHidden = NO;
    self.hideKeyboardIfTouched = NO;
    
    _allowsDoneBarButton = YES;
    _allowsWebKit = YES;
}

- (void)dealloc {
    [self _dettachWebView];
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if((_progressView != nil) && (_progressView.superview == nil)) {
        [self _attachProgressView];
    }
    if((_uiWebView == nil) && (_wkWebView == nil)) {
        [self _attachWebView];
    }
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"

- (void)viewDidUnload {
    [self _dettachWebView];
    
    [super viewDidUnload];
}

#pragma clang diagnostic pop

#pragma mark - GLBViewController

- (void)update {
    [super update];
    
    if(_URL != nil) {
        [self _loadingWebView];
    }
}

- (void)clear {
    [self stopLoading];
    
    [super clear];
}

#pragma mark - Property

- (UIBarButtonItem*)fixedSpaceItem {
    if(_fixedSpaceItem == nil) {
        _fixedSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        if(UIDevice.glb_isIPad == YES) {
            _fixedSpaceItem.width = 35.0;
        }
    }
    return _fixedSpaceItem;
}

- (UIBarButtonItem*)flexibleSpaceItem {
    if(_flexibleSpaceItem == nil) {
        _flexibleSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    }
    return _flexibleSpaceItem;
}

- (void)setDoneBarButtonItem:(UIBarButtonItem*)doneBarButtonItem {
    if(_doneBarButtonItem != doneBarButtonItem) {
        _doneBarButtonItem = doneBarButtonItem;
        [self setNeedUpdateNavigationItem];
        [self setNeedUpdateToolbarItems];
    }
}

- (UIBarButtonItem*)doneBarButtonItem {
    if(_doneBarButtonItem == nil) {
        UIImage* image = [self _imageFromResourceBundle:@"bar_done"];
        if(image != nil) {
            _doneBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(_pressedDoneButton:)];
        } else {
            _doneBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                               target:self
                                                                               action:@selector(_pressedDoneButton:)];
        }
    }
    return _doneBarButtonItem;
}

- (void)setBackBarButtonItem:(UIBarButtonItem*)backBarButtonItem {
    if(_backBarButtonItem != backBarButtonItem) {
        _backBarButtonItem = backBarButtonItem;
        [self setNeedUpdateNavigationItem];
        [self setNeedUpdateToolbarItems];
    }
}

- (UIBarButtonItem*)backBarButtonItem {
    if(_backBarButtonItem == nil) {
        _backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[self _imageFromResourceBundle:@"bar_back"]
                                                              style:UIBarButtonItemStylePlain
                                                             target:self
                                                             action:@selector(goBack)];
    }
    return _backBarButtonItem;
}

- (void)setForwardBarButtonItem:(UIBarButtonItem*)forwardBarButtonItem {
    if(_forwardBarButtonItem != forwardBarButtonItem) {
        _forwardBarButtonItem = forwardBarButtonItem;
        [self setNeedUpdateNavigationItem];
        [self setNeedUpdateToolbarItems];
    }
}

- (UIBarButtonItem*)forwardBarButtonItem {
    if(_forwardBarButtonItem == nil) {
        _forwardBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[self _imageFromResourceBundle:@"bar_forward"]
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(goForward)];
    }
    return _forwardBarButtonItem;
}

- (void)setRefreshBarButtonItem:(UIBarButtonItem*)refreshBarButtonItem {
    if(_refreshBarButtonItem != refreshBarButtonItem) {
        _refreshBarButtonItem = refreshBarButtonItem;
        [self setNeedUpdateNavigationItem];
        [self setNeedUpdateToolbarItems];
    }
}

- (UIBarButtonItem*)refreshBarButtonItem {
    if(_refreshBarButtonItem == nil) {
        UIImage* image = [self _imageFromResourceBundle:@"bar_refresh"];
        if(image != nil) {
            _refreshBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(reload)];
        } else {
            _refreshBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                  target:self
                                                                                  action:@selector(reload)];
        }
    }
    return _refreshBarButtonItem;
}

- (void)setStopBarButtonItem:(UIBarButtonItem*)stopBarButtonItem {
    if(_stopBarButtonItem != stopBarButtonItem) {
        _stopBarButtonItem = stopBarButtonItem;
        [self setNeedUpdateNavigationItem];
        [self setNeedUpdateToolbarItems];
    }
}

- (UIBarButtonItem*)stopBarButtonItem {
    if(_stopBarButtonItem == nil) {
        UIImage* image = [self _imageFromResourceBundle:@"bar_stop"];
        if(image != nil) {
            _stopBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(stopLoading)];
        } else {
            _stopBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                                                               target:self
                                                                               action:@selector(stopLoading)];
        }
    }
    return _stopBarButtonItem;
}

- (void)setActionBarButtonItem:(UIBarButtonItem*)actionBarButtonItem {
    if(_actionBarButtonItem != actionBarButtonItem) {
        _actionBarButtonItem = actionBarButtonItem;
        [self setNeedUpdateNavigationItem];
        [self setNeedUpdateToolbarItems];
    }
}

- (UIBarButtonItem*)actionBarButtonItem {
    if(_actionBarButtonItem == nil) {
        UIImage* image = [self _imageFromResourceBundle:@"bar_action"];
        if(image != nil) {
            _actionBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(_pressedActionButton:)];
        } else {
            _actionBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                                 target:self
                                                                                 action:@selector(_pressedActionButton:)];
        }
    }
    return _actionBarButtonItem;
}

- (UIProgressView*)progressView {
    if(_progressView == nil) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.translatesAutoresizingMaskIntoConstraints = NO;
        if(self.isViewLoaded == YES) {
            [self _attachProgressView];
        }
    }
    return _progressView;
}

- (void)setResourcesBundle:(NSBundle*)resourcesBundle {
    if(_resourcesBundle != resourcesBundle) {
        _resourcesBundle = resourcesBundle;
        _backBarButtonItem = nil;
        _forwardBarButtonItem = nil;
        _refreshBarButtonItem = nil;
        _stopBarButtonItem = nil;
        _actionBarButtonItem = nil;
        [self setNeedUpdateNavigationItem];
        [self setNeedUpdateToolbarItems];
    }
}

- (NSBundle*)resourcesBundle {
    if(_resourcesBundle == nil) {
        _resourcesBundle = [NSBundle glb_bundleWithClass:self.class];
        if(_resourcesBundle == nil) {
            _resourcesBundle = NSBundle.mainBundle;
        }
    }
    return _resourcesBundle;
}

- (void)setURL:(NSURL*)URL {
    if([_URL isEqual:URL] == NO) {
        _URL = URL;
        if((self.isViewLoaded == YES) && (_URL != nil)) {
            [self _loadingWebView];
        }
    }
}

- (BOOL)canGoBack {
    if(_wkWebView != nil) {
        return _wkWebView.canGoBack;
    } else if(_uiWebView != nil) {
        return _uiWebView.canGoBack;
    }
    return NO;
}

- (BOOL)canGoForward {
    if(_wkWebView != nil) {
        return _wkWebView.canGoForward;
    } else if(_uiWebView != nil) {
        return _uiWebView.canGoForward;
    }
    return NO;
}

- (BOOL)isLoading {
    if(_wkWebView != nil) {
        return _wkWebView.isLoading;
    } else if(_uiWebView != nil) {
        return _uiWebView.isLoading;
    }
    return NO;
}

#pragma mark - Public

- (void)reload {
    if(_wkWebView != nil) {
        [_wkWebView reload];
    } else if(_uiWebView != nil) {
        [_uiWebView reload];
    }
}

- (void)stopLoading {
    if(_wkWebView != nil) {
        [_wkWebView stopLoading];
        [self setNeedUpdateNavigationItem];
        [self setNeedUpdateToolbarItems];
    } else if(_uiWebView != nil) {
        [_uiWebView stopLoading];
        [self setNeedUpdateNavigationItem];
        [self setNeedUpdateToolbarItems];
    }
}

- (void)goBack {
    if(_wkWebView != nil) {
        [_wkWebView goBack];
    } else if(_uiWebView != nil) {
        [_uiWebView goBack];
    }
}

- (void)goForward {
    if(_wkWebView != nil) {
        [_wkWebView goForward];
    } else if(_uiWebView != nil) {
        [_uiWebView goForward];
    }
}

- (void)didStartLoading {
}

- (void)didFinishLoading {
}

- (void)didLoadingError:(NSError*)error {
}

- (NSArray< UIBarButtonItem* >*)prepareNavigationLeftBarButtons {
    if(UIDevice.glb_isIPad == YES) {
        if(self.navigationController.viewControllers.firstObject == self) {
            return @[
                self.fixedSpaceItem,
                self.actionBarButtonItem,
                self.fixedSpaceItem,
                self.forwardBarButtonItem,
                self.fixedSpaceItem,
                self.backBarButtonItem,
                self.fixedSpaceItem,
                (self.isLoading == YES) ? self.stopBarButtonItem : self.refreshBarButtonItem,
                self.fixedSpaceItem
            ];
        }
    }
    return self.navigationItem.leftBarButtonItems;
}

- (NSArray< UIBarButtonItem* >*)prepareNavigationRightBarButtons {
    if(UIDevice.glb_isIPhone == YES) {
        if((self.navigationController.viewControllers.firstObject == self) && (_allowsDoneBarButton == YES)) {
            return @[
                self.doneBarButtonItem
            ];
        }
    } else if(UIDevice.glb_isIPad == YES) {
        if(self.navigationController.viewControllers.firstObject == self) {
            if(_allowsDoneBarButton == YES) {
                return @[
                    self.doneBarButtonItem
                ];
            }
        } else {
            return @[
                self.actionBarButtonItem,
                self.fixedSpaceItem,
                self.forwardBarButtonItem,
                self.fixedSpaceItem,
                self.backBarButtonItem,
                self.fixedSpaceItem,
                (self.isLoading == YES) ? self.stopBarButtonItem : self.refreshBarButtonItem,
                self.fixedSpaceItem
            ];
        }
    }
    return self.navigationItem.rightBarButtonItems;
}

- (NSArray< UIBarButtonItem* >*)prepareToolbarItems {
    if(UIDevice.glb_isIPhone == YES) {
        return @[
            self.fixedSpaceItem,
            self.backBarButtonItem,
            self.flexibleSpaceItem,
            self.forwardBarButtonItem,
            self.flexibleSpaceItem,
            (self.isLoading == YES) ? self.stopBarButtonItem : self.refreshBarButtonItem,
            self.flexibleSpaceItem,
            self.actionBarButtonItem,
            self.fixedSpaceItem
        ];
    }
    return self.toolbarItems;
}

- (void)share:(id)sender {
    NSURL* url = _URL;
    if(_wkWebView != nil) {
        if(_wkWebView.URL != nil) {
            url = _wkWebView.URL;
        }
    } else if(_uiWebView != nil) {
        if(_uiWebView.request.URL != nil) {
            url = _uiWebView.request.URL;
        }
    }
    if(url != nil) {
        if([url.absoluteString hasPrefix:@"file:///"] == YES) {
            UIDocumentInteractionController* dc = [UIDocumentInteractionController interactionControllerWithURL:url];
            [dc presentOptionsMenuFromRect:self.view.bounds inView:self.view animated:YES];
        }
        else {
            UIActivityViewController* ac = [[UIActivityViewController alloc] initWithActivityItems:@[ url ] applicationActivities:nil];
            if(UIDevice.glb_isIPad == YES) {
                UIPopoverPresentationController* pc = ac.popoverPresentationController;
                pc.sourceView = self.view;
                pc.barButtonItem = sender;
            }
            [self presentViewController:ac animated:YES completion:NULL];
        }
    }
}

#pragma mark - Private

- (UIImage*)_imageFromResourceBundle:(NSString*)imageName {
    UIImage* image = nil;
    NSBundle* bundle = self.resourcesBundle;
    if([UIDevice glb_compareSystemVersion:@"8.0"] != NSOrderedAscending) {
        return [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil];
    }
    if(bundle != NSBundle.mainBundle) {
        image = [UIImage imageWithContentsOfFile:[bundle.resourcePath stringByAppendingPathComponent:imageName]];
    } else {
        image = [UIImage imageNamed:imageName];
    }
    if(image != nil) {
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    return image;
}

- (void)_attachWebView {
    UIView* webView = nil;
    if(([UIDevice glb_compareSystemVersion:@"8.0"] != NSOrderedAscending) && (_allowsWebKit == YES)) {
        _wkWebView = [[WKWebView alloc] initWithFrame:UIScreen.mainScreen.bounds];
        _wkWebView.translatesAutoresizingMaskIntoConstraints = NO;
        _wkWebView.UIDelegate = self;
        _wkWebView.navigationDelegate = self;
        [_wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        webView = _wkWebView;
    } else {
        _uiWebView = [[UIWebView alloc] initWithFrame:UIScreen.mainScreen.bounds];
        _uiWebView.translatesAutoresizingMaskIntoConstraints = NO;
        _uiWebView.delegate = self;
        webView = _uiWebView;
    }
    if(webView != nil) {
        [self.view insertSubview:webView atIndex:0];
        
        if(self.topLayoutGuide != nil) {
            [webView glb_addConstraintTop:0.0f bottomItem:self.topLayoutGuide];
        } else {
            [webView glb_addConstraintTop:0.0f];
        }
        if(self.bottomLayoutGuide != nil) {
            [webView glb_addConstraintBottom:0.0f topItem:self.bottomLayoutGuide];
        } else {
            [webView glb_addConstraintBottom:0.0f];
        }
        [webView glb_addConstraintLeft:0.0f];
        [webView glb_addConstraintRight:0.0f];
    }
    [self setNeedUpdateNavigationItem];
    [self setNeedUpdateToolbarItems];
}

- (void)_dettachWebView {
    if(_wkWebView != nil) {
        _wkWebView.navigationDelegate = nil;
        [_wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
        [_wkWebView removeFromSuperview];
        _wkWebView = nil;
    } else if(_uiWebView != nil) {
        _uiWebView.delegate = nil;
        [_uiWebView removeFromSuperview];
        _uiWebView = nil;
    }
}

- (void)_attachProgressView {
    UIView* webView = nil;
    if(_wkWebView != nil) {
        webView = _wkWebView;
    } else if(_uiWebView != nil) {
        webView = _uiWebView;
    } else {
        return;
    }
    [self.view insertSubview:_progressView aboveSubview:webView];
    
    [_progressView glb_addConstraintTop:0.0f bottomItem:self.topLayoutGuide];
    [_progressView glb_addConstraintLeft:0.0f];
    [_progressView glb_addConstraintRight:0.0f];
    [_progressView glb_addConstraintHeight:1.0f];
}

- (void)_dettachProgressView {
    [_progressView removeFromSuperview];
    _progressView = nil;
}

- (void)_loadingWebView {
    if(_wkWebView != nil) {
        [_wkWebView loadRequest:[NSURLRequest requestWithURL:_URL]];
    } else if(_uiWebView != nil) {
        [_uiWebView loadRequest:[NSURLRequest requestWithURL:_URL]];
    }
}

#pragma mark - Target actions

- (void)_pressedDoneButton:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)_pressedActionButton:(id)sender {
    [self share:sender];
}

#pragma mark - NSKeyValueObserving

- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context {
    if([keyPath isEqualToString:@"estimatedProgress"] == YES) {
        self.progressView.hidden = ((1.0 - _wkWebView.estimatedProgress) <= DBL_EPSILON);
        [self.progressView setProgress:((float)(_wkWebView.estimatedProgress)) animated:YES];
    }
}

#pragma mark - WKUIDelegate

- (WKWebView*)webView:(WKWebView*)webView createWebViewWithConfiguration:(WKWebViewConfiguration*)configuration forNavigationAction:(WKNavigationAction*)navigationAction windowFeatures:(WKWindowFeatures*)windowFeatures {
    if(navigationAction.targetFrame.isMainFrame == NO) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView*)webView didFailProvisionalNavigation:(WKNavigation*)navigation withError:(NSError*)error {
    [self setNeedUpdateNavigationItem];
    [self setNeedUpdateToolbarItems];
    [self didLoadingError:error];
}

- (void)webView:(WKWebView*)webView didCommitNavigation:(WKNavigation*)navigation {
    [self setNeedUpdateNavigationItem];
    [self setNeedUpdateToolbarItems];
    [self didStartLoading];
}

- (void)webView:(WKWebView*)webView didFinishNavigation:(WKNavigation*)navigation {
    [self setNeedUpdateNavigationItem];
    [self setNeedUpdateToolbarItems];
    [self didFinishLoading];
}

- (void)webView:(WKWebView*)webView didFailNavigation:(WKNavigation*)navigation withError:(NSError*)error {
    [self setNeedUpdateNavigationItem];
    [self setNeedUpdateToolbarItems];
    [self didLoadingError:error];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView*)webView {
    [self setNeedUpdateNavigationItem];
    [self setNeedUpdateToolbarItems];
    [self didStartLoading];
}

- (void)webViewDidFinishLoad:(UIWebView*)webView {
    [self setNeedUpdateNavigationItem];
    [self setNeedUpdateToolbarItems];
    [self didFinishLoading];
}

- (void)webView:(UIWebView*)webView didFailLoadWithError:(NSError*)error {
    [self setNeedUpdateNavigationItem];
    [self setNeedUpdateToolbarItems];
    [self didLoadingError:error];
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
