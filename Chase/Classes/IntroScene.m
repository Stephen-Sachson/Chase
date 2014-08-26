//
//  IntroScene.m
//  Chase
//
//  Created by deepfocus-004 on 8/1/14.
//  Copyright deepfocus-004 2014. All rights reserved.
//
// -----------------------------------------------------------------------

// Import the interfaces
#import "playScene.h"

// -----------------------------------------------------------------------
#pragma mark - IntroScene
// -----------------------------------------------------------------------

@implementation playScene

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (playScene *)scene
{
	return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    // Create a colored background (Dark Grey)
    glClearColor(0.2f, 0.2f, 0.2f, 1.0f);

    // done
	return self;
}

@end
