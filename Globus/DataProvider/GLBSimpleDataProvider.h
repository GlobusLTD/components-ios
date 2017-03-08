/*--------------------------------------------------*/

#import "NSObject+GLBNS.h"

/*--------------------------------------------------*/

@protocol GLBSimpleDataProviderDelegate;

/*--------------------------------------------------*/

@protocol GLBSimpleDataProvider

@property(nonatomic, nullable, weak) id< GLBSimpleDataProviderDelegate > delegate;
@property(nonatomic, nullable, readonly, strong) id error;

@property(nonatomic, nonnull, readonly, strong) id model;

- (void)load;
- (void)cancel;

@property(nonatomic, readonly) BOOL canCache;
@property(nonatomic, nonnull, readonly, strong) id cacheModel;

@property(nonatomic, readonly) BOOL canReload;
- (void)reload;

@end

/*--------------------------------------------------*/

@protocol GLBSimpleDataProviderDelegate

- (void)startLoadingForDataProvider:(nonnull id< GLBSimpleDataProvider >)dataProvider;
- (void)finishLoadingForDataProvider:(nonnull id< GLBSimpleDataProvider >)dataProvider error:(nonnull id)error;
- (void)finishLoadingForDataProvider:(nonnull id< GLBSimpleDataProvider >)dataProvider model:(nullable id)model;

@end

/*--------------------------------------------------*/
