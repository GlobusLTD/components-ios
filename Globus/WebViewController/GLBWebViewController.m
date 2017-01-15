/*--------------------------------------------------*/

#import "GLBWebViewController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#import <WebKit/WebKit.h>

/*--------------------------------------------------*/

@interface GLBWebViewController () < UIWebViewDelegate, WKUIDelegate, WKNavigationDelegate >

- (UIImage*)_imageFromResourceBundle:(NSString*)imageName;
- (void)_attachWebView;
- (void)_dettachWebView;
- (void)_attachProgressView;
- (void)_dettachProgressView;
- (void)_loadingWebView;

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

- (void)setDoneBarButtonItem:(UIBarButtonItem*)doneBarButtonItem {
    if(_doneBarButtonItem != doneBarButtonItem) {
        _doneBarButtonItem = doneBarButtonItem;
        if(self.isViewLoaded == YES) {
            [self updateNavigationItems];
        }
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
        if(self.isViewLoaded == YES) {
            [self updateNavigationItems];
        }
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
        if(self.isViewLoaded == YES) {
            [self updateNavigationItems];
        }
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
        if(self.isViewLoaded == YES) {
            [self updateNavigationItems];
        }
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
        if(self.isViewLoaded == YES) {
            [self updateNavigationItems];
        }
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
        if(self.isViewLoaded == YES) {
            [self updateNavigationItems];
        }
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
        if(self.isViewLoaded == YES) {
            [self updateNavigationItems];
        }
    }
}

- (NSBundle*)resourcesBundle {
    if(_resourcesBundle == nil) {
        NSString* mainBundlePath = NSBundle.mainBundle.bundlePath;
        Class currentClass = self.class;
        while((_resourcesBundle == nil) && (currentClass != nil)) {
            NSString* bundlePath = [NSString stringWithFormat:@"%@/%@.bundle", mainBundlePath, NSStringFromClass(currentClass)];
            _resourcesBundle = [NSBundle bundleWithPath:bundlePath];
            currentClass = currentClass.superclass;
        }
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
        [self updateNavigationItems];
    } else if(_uiWebView != nil) {
        [_uiWebView stopLoading];
        [self updateNavigationItems];
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

- (void)updateNavigationItems {
    self.backBarButtonItem.enabled = self.canGoBack;
    self.forwardBarButtonItem.enabled = self.canGoForward;
    UIBarButtonItem* refreshStopBarButtonItem = (self.isLoading == YES) ? self.stopBarButtonItem : self.refreshBarButtonItem;
    UIBarButtonItem* fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    if(UIDevice.glb_isIPad == YES) {
        fixedSpace.width = 35.0;
    }
    UIBarButtonItem* flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    if(UIDevice.glb_isIPad == YES) {
        if(self.navigationController.viewControllers.firstObject == self) {
            self.navigationItem.leftBarButtonItems = @[
                fixedSpace,
                self.actionBarButtonItem,
                fixedSpace,
                self.forwardBarButtonItem,
                fixedSpace,
                self.backBarButtonItem,
                fixedSpace,
                refreshStopBarButtonItem,
                fixedSpace
            ];
            if(_allowsDoneBarButton == YES) {
                self.navigationItem.rightBarButtonItems = @[
                    self.doneBarButtonItem
                ];
            } else {
                self.navigationItem.rightBarButtonItems = @[];
            }
        } else {
            self.navigationItem.rightBarButtonItems = @[
                self.actionBarButtonItem,
                fixedSpace,
                self.forwardBarButtonItem,
                fixedSpace,
                self.backBarButtonItem,
                fixedSpace,
                refreshStopBarButtonItem,
                fixedSpace
            ];
        }
    } else {
        if((self.navigationController.viewControllers.firstObject == self) && (_allowsDoneBarButton == YES)) {
            self.navigationItem.rightBarButtonItems = @[
                self.doneBarButtonItem
            ];
        }
        self.toolbarItems = @[
            fixedSpace,
            self.backBarButtonItem,
            flexibleSpace,
            self.forwardBarButtonItem,
            flexibleSpace,
            refreshStopBarButtonItem,
            flexibleSpace,
            self.actionBarButtonItem,
            fixedSpace
        ];
    }
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
    NSBundle* bundle = self.resourcesBundle;
    if([UIDevice glb_compareSystemVersion:@"8.0"] != NSOrderedAscending) {
        return [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil];
    }
    if(bundle != NSBundle.mainBundle) {
        return [UIImage imageWithContentsOfFile:[bundle.resourcePath stringByAppendingPathComponent:imageName]];
    }
    return [UIImage imageNamed:imageName];
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
            [webView glb_addConstraintAttribute:NSLayoutAttributeTop
                                       relation:NSLayoutRelationEqual
                                           view:self.topLayoutGuide
                                      attribute:NSLayoutAttributeBottom
                                       constant:0.0
                                       priority:UILayoutPriorityRequired];
        } else {
            [webView glb_addConstraintAttribute:NSLayoutAttributeTop
                                       relation:NSLayoutRelationEqual
                                      attribute:NSLayoutAttributeTop
                                       constant:0.0];
        }
        if(self.bottomLayoutGuide != nil) {
            [webView glb_addConstraintAttribute:NSLayoutAttributeBottom
                                       relation:NSLayoutRelationEqual
                                           view:self.bottomLayoutGuide
                                      attribute:NSLayoutAttributeTop
                                       constant:0.0
                                       priority:UILayoutPriorityRequired];
        } else {
            [webView glb_addConstraintAttribute:NSLayoutAttributeBottom
                                       relation:NSLayoutRelationEqual
                                      attribute:NSLayoutAttributeBottom
                                       constant:0.0];
        }
        [webView glb_addConstraintAttribute:NSLayoutAttributeLeft
                                   relation:NSLayoutRelationEqual
                                  attribute:NSLayoutAttributeLeft
                                   constant:0.0];
        [webView glb_addConstraintAttribute:NSLayoutAttributeRight
                                   relation:NSLayoutRelationEqual
                                  attribute:NSLayoutAttributeRight
                                   constant:0.0];
    }
    [self updateNavigationItems];
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
    
    [_progressView glb_addConstraintAttribute:NSLayoutAttributeTop
                                     relation:NSLayoutRelationEqual
                                         view:self.topLayoutGuide
                                    attribute:NSLayoutAttributeBottom
                                     constant:0.0];
    [_progressView glb_addConstraintAttribute:NSLayoutAttributeLeft
                                     relation:NSLayoutRelationEqual
                                    attribute:NSLayoutAttributeLeft
                                     constant:0.0];
    [_progressView glb_addConstraintAttribute:NSLayoutAttributeRight
                                     relation:NSLayoutRelationEqual
                                    attribute:NSLayoutAttributeRight
                                     constant:0.0];
    [_progressView glb_addConstraintAttribute:NSLayoutAttributeHeight
                                     relation:NSLayoutRelationEqual
                                     constant:1.0];
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
    [self updateNavigationItems];
    [self didLoadingError:error];
}

- (void)webView:(WKWebView*)webView didCommitNavigation:(WKNavigation*)navigation {
    [self updateNavigationItems];
    [self didStartLoading];
}

- (void)webView:(WKWebView*)webView didFinishNavigation:(WKNavigation*)navigation {
    [self updateNavigationItems];
    [self didFinishLoading];
}

- (void)webView:(WKWebView*)webView didFailNavigation:(WKNavigation*)navigation withError:(NSError*)error {
    [self updateNavigationItems];
    [self didLoadingError:error];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView*)webView {
    [self updateNavigationItems];
    [self didStartLoading];
}

- (void)webViewDidFinishLoad:(UIWebView*)webView {
    [self updateNavigationItems];
    [self didFinishLoading];
}

- (void)webView:(UIWebView*)webView didFailLoadWithError:(NSError*)error {
    [self updateNavigationItems];
    [self didLoadingError:error];
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
