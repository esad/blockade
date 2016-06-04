//
//  BlockadeView.m
//  Blockade
//
//  Created by Esad Hajdarevic on 04/06/16.
//  Copyright © 2016 Esad Hajdarevic. All rights reserved.
//

@import WebKit;

#import "BlockadeView.h"

@interface BlockadeView() {
    WKWebView *_webView;
}
@end

@implementation BlockadeView

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview {
    if (self = [super initWithFrame:frame isPreview:isPreview]) {
        self.wantsLayer = YES;
        CALayer *layer = [CALayer layer];
        layer.frame = self.bounds;
        layer.backgroundColor = [NSColor blackColor].CGColor;
        self.layer = layer;
    }
    return self;
}

- (void)startAnimation {
    [super startAnimation];

    _webView = [[WKWebView alloc] initWithFrame:[self bounds]];
    [_webView setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
    [_webView setAutoresizesSubviews:YES];

    [_webView addObserver:self forKeyPath:@"loading" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    _webView.hidden = YES;
    [self addSubview:_webView];

    NSURL *index = [[NSBundle bundleForClass:[self class]] URLForResource:@"index" withExtension:@"html"];
    [_webView loadFileURL:index allowingReadAccessToURL:[index URLByDeletingLastPathComponent]];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"loading"] &&
        ![change[NSKeyValueChangeNewKey] boolValue] &&
        [change[NSKeyValueChangeOldKey] boolValue]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _webView.hidden = NO;
        });
    }
}

- (void)stopAnimation {
    [super stopAnimation];
    [_webView removeObserver:self forKeyPath:@"loading"];
    [_webView removeFromSuperview];
    _webView = nil;
}

- (BOOL)hasConfigureSheet {
    return NO;
}

- (NSWindow*)configureSheet {
    return nil;
}

@end
