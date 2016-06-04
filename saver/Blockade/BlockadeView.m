//
//  BlockadeView.m
//  Blockade
//
//  Created by Esad Hajdarevic on 04/06/16.
//  Copyright © 2016 Esad Hajdarevic. All rights reserved.
//

@import WebKit;

#import "BlockadeView.h"

@implementation BlockadeView {
    WKWebView *_webView;
}

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview {
    if (self = [super initWithFrame:frame isPreview:isPreview]) {
    }
    return self;
}

- (void)startAnimation {
    [super startAnimation];

    _webView = [[WKWebView alloc] initWithFrame:[self bounds]];
    [_webView setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
    [_webView setAutoresizesSubviews:YES];

    NSColor *color = [NSColor colorWithCalibratedWhite:0.0 alpha:1.0];
    [[_webView layer] setBackgroundColor:color.CGColor];

    [self addSubview:_webView];

    NSURL *index = [[NSBundle bundleForClass:[self class]] URLForResource:@"index" withExtension:@"html"];
    [_webView loadFileURL:index allowingReadAccessToURL:[index URLByDeletingLastPathComponent]];
}

- (void)stopAnimation {
    [super stopAnimation];
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
