//
//  IntroScene.m
//  Chase
//
//  Created by deepfocus-004 on 8/1/14.
//  Copyright deepfocus-004 2014. All rights reserved.


#import "PlayScene.h"

@interface PlayScene () {
    CCSprite *ball;
    CCParticleSystem *flameParticle;
}

@end

@implementation PlayScene

#pragma mark - Create & Destroy

+ (PlayScene *)scene
{
	return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (!self) return(nil);
    
    CCSprite *bgSprite=[CCSprite spriteWithImageNamed:@"bg.png"];
    bgSprite.contentSize = [[CCDirector sharedDirector] viewSize];
    [self addChild:bgSprite];
    
    CCPhysicsNode *physics=[CCPhysicsNode node];
    physics.gravity=ccp(0, -980);
    [self addChild:physics];
    
    CGRect outRect=CGRectZero;
    outRect.size=[CCDirector sharedDirector].viewSize;
    CCNode *outline=[CCNode node];
    outline.physicsBody=[CCPhysicsBody bodyWithPolylineFromRect:outRect cornerRadius:0.5f];
    outline.physicsBody.friction=1.0f;
    outline.physicsBody.elasticity=0.8f;
    outline.physicsBody.collisionType=@"outline";
    outline.physicsBody.collisionMask=@[@"ball"];
    [physics addChild:outline];
    
    ball=[CCSprite spriteWithImageNamed:@"ball.png"];
    float radius=ball.texture.contentSize.width/2;
    ball.position=ccp(200, 100);
    ball.physicsBody=[CCPhysicsBody bodyWithCircleOfRadius:radius*0.6 andCenter:ccp(radius, radius)];
    ball.physicsBody.friction=1.0f;
    ball.physicsBody.elasticity=0.5f;
    ball.physicsBody.collisionType=@"ball";
    ball.physicsBody.collisionMask=@[@"outline"];
    [physics addChild:ball];
    
    float scale=1.5f;
    flameParticle=[CCParticleSystem particleWithFile:@"flame.plist"];
//    flameParticle.positionType=CCPositionTypeNormalized;
    flameParticle.position=ball.position;
    flameParticle.startSize*=scale;
    flameParticle.startSizeVar*=scale;
    flameParticle.endSize*=scale;
    flameParticle.endSizeVar*=scale;
    flameParticle.gravity=ccpMult(flameParticle.gravity, scale);
    flameParticle.posVar=ccpMult(flameParticle.posVar, scale);
    [physics addChild:flameParticle z:-1];
    
    self.userInteractionEnabled=YES;
    
	return self;
}

- (void)update:(CCTime)delta {
    flameParticle.position=ball.position;
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    [ball.physicsBody applyImpulse:ccp(30, 280)];
}

- (UIImage*) getGLScreenshot {
    NSInteger myDataLength = 320 * 480 * 4;
    
    // allocate array and read pixels into it.
    GLubyte *buffer = (GLubyte *) malloc(myDataLength);
    glReadPixels(0, 0, 320, 480, GL_RGBA, GL_UNSIGNED_BYTE, buffer);
    
    // gl renders "upside down" so swap top to bottom into new array.
    // there's gotta be a better way, but this works.
    GLubyte *buffer2 = (GLubyte *) malloc(myDataLength);
    for(int y = 0; y <480; y++)
    {
        for(int x = 0; x <320 * 4; x++)
        {
            buffer2[(479 - y) * 320 * 4 + x] = buffer[y * 4 * 320 + x];
        }
    }
    
    // make data provider with data.
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL,
                                                              buffer2, myDataLength, NULL);
    
    // prep the ingredients
    int bitsPerComponent = 8;
    int bitsPerPixel = 32;
    int bytesPerRow = 4 * 320;
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    
    // make the cgimage
    CGImageRef imageRef = CGImageCreate(320, 480, bitsPerComponent,
                                        bitsPerPixel, bytesPerRow, colorSpaceRef, bitmapInfo, provider,
                                        NULL, NO, renderingIntent);
    
    // then make the uiimage from that
    UIImage *myImage = [UIImage imageWithCGImage:imageRef];
    return myImage;
}

- (void)saveGLScreenshotToPhotosAlbum {
    UIImageWriteToSavedPhotosAlbum([self getGLScreenshot], nil,
                                   nil, nil);
}

@end
