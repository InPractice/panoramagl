//
//  MainViewController.m
//  HelloPanoramaGL
//
//  Created by julius on 14-7-25.
//  Copyright (c) 2014年 Senacyt. All rights reserved.
//




#define kIdMin 1
#define kIdMax 1000

#import "MainViewController.h"
#import "PLTransitionFadeOut.h"
#import "PLTransitionFadeIn.h"
#import "RadianModel.h"

#define kPLViewTransitionTimeInterval 0.03

#define kHotspotTAG00 100
#define kHotspotTAG11 101
#define kHotspotTAG22 102
#define kHotspotTAG33 103
#define kHotspotTAG44 104
#define kHotspotTAG55 105
#define kHotspotTAG66 106
#define kHotspotTAG77 107
#define kHotspotTAG88 108
#define kHotspotTAG99 109



#define kHotspotTAG44TO77 1000
#define kHotspotTAG44TO88 1001
#define kHotspotTAG44TO00 1002
#define kHotspotTAG77TO44 1003
#define kHotspotTAG88TO44 1004
#define kHotspotTAG00TO44 1005

//#define kHotspotTAG22TO11 1003
//#define kHotspotTAG33TO77 1004
//#define kHotspotTAG33TO88 1005
//#define kHotspotTAG44TO88 1006
//#define kHotspotTAG44TO77 1007
//#define kHotspotTAG55TO00 1008
//#define kHotspotTAG66TO99 1009                                                                        1009
//#define kHotspotTAG88TO33 1010                                                                        1009
//#define kHotspotTAG77TO33 1011
//#define kHotspotTAG55TO66 1011

@interface MainViewController ()<PLViewDelegate,PLTransitionDelegate>
{
    PLSphericalPanorama *panorama;
    int sceneFlag;
    UIImageView *roomTypeImageView;
    int currentClickHotSpot;
    
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;
}

@end

@implementation MainViewController



-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    currentClickHotSpot = kHotspotTAG44;
    
//    [RadianModel getModelArray];
    label1 = [[UILabel alloc]initWithFrame:CGRectZero];
    label1.backgroundColor=[UIColor redColor];
    label1.text = @"研发室";
    label1.font = [UIFont systemFontOfSize:10];
    label2 = [[UILabel alloc]initWithFrame:CGRectZero];
    label2.text = @"按摩室";
    label2.font = [UIFont systemFontOfSize:10];
    label3 = [[UILabel alloc]initWithFrame:CGRectZero];
    label3.text = @"休息室";
    label3.font = [UIFont systemFontOfSize:10];
    self.view = [[PLView alloc]initWithFrame:self.view.bounds];
    
    [self.view addSubview:label1];
    [self.view addSubview:label2];
    [self.view addSubview:label3];
    
    plView = (PLView *)self.view;
    plView.delegate = self;
    //    [self selectPanorama:0];
    //JSON loader example (see json.data, json_s2.data and json_cubic.data)
    //[plView load:[PLJSONLoader loaderWithPath:[[NSBundle mainBundle] pathForResource:@"json_cubic" ofType:@"data"]]];
    
    panorama = [PLSphericalPanorama panorama];
    [(PLSphericalPanorama *)panorama setTexture:[PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"44" ofType:@"jpg"]]]];
    PLTexture *hotspotTexture = [PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"hotspot" ofType:@"png"]]];
    //    PLHotspot *hotspot = [PLHotspot hotspotWithId:100 texture:hotspotTexture atv:45 ath:0 width:0.04f height:0.04f];
    
    PLHotspot *hotspot44To77 = [PLHotspot hotspotWithId:kHotspotTAG44TO77 texture:hotspotTexture atv:0 ath:98 width:0.04f height:0.04f];
    [panorama addHotspot:hotspot44To77];
    PLHotspot *hotspot44To88 = [PLHotspot hotspotWithId:kHotspotTAG44TO88 texture:hotspotTexture atv:0 ath:104 width:0.04f height:0.04f];
    [panorama addHotspot:hotspot44To88];
    
    
    
    
    PLTexture *titleLabelTexture = [PLTexture textureWithImage:[PLImage imageWithCGImage:[self getImageWithString:@"研发室"].CGImage]];
    
    PLHotspot *hotspot44To00 = [PLHotspot hotspotWithId:kHotspotTAG44TO00 texture:titleLabelTexture atv:0 ath:-115 width:0.08f height:0.08f];
    [panorama addHotspot:hotspot44To00];
    [plView setPanorama:panorama];
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(260, 20, 60, 20)];
    [button setTitle:@"户型图" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(ShowOrHideRoomTypePic) forControlEvents:UIControlEventTouchDown];
    [plView addSubview:button];
    
}

-(void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}




#pragma mark - otherMethods

- (UIImage *)getImageWithString:(NSString *)string
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(110, 30),NO,0);
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 110, 30)];
    label.text = string;
    label.font = [UIFont boldSystemFontOfSize:32.0f];
    label.textColor = [UIColor whiteColor];
    [label.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


- (void)ShowOrHideRoomTypePic
{
    //加户型图 和 热点
    if (!roomTypeImageView) {
        roomTypeImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"huxingtu.jpg"]];
        
        //        roomTypeImageView.alpha = 1;
        
        roomTypeImageView.userInteractionEnabled = YES;
        [roomTypeImageView setFrame:CGRectMake(320-280, 50, 280, 210)];
        
        [plView addSubview:roomTypeImageView];
        
        UIButton *buttonName00 = [self createButtonForHotspotWithRect:CGRectMake(57, 167, 25, 25) title:@"热点" tag:kHotspotTAG00];
        [roomTypeImageView addSubview:buttonName00];
        
        UIButton *buttonName11 = [self createButtonForHotspotWithRect:CGRectMake(184, 2, 25, 25) title:@"热点" tag:kHotspotTAG11];
        [roomTypeImageView addSubview:buttonName11];
        
        UIButton *buttonName22 = [self createButtonForHotspotWithRect:CGRectMake(212, 2, 25, 25) title:@"按摩室" tag:kHotspotTAG22];
        [roomTypeImageView addSubview:buttonName22];
        UIButton *buttonName33 = [self createButtonForHotspotWithRect:CGRectMake(157, 67, 25, 25) title:@"热点" tag:kHotspotTAG33];
        [roomTypeImageView addSubview:buttonName33];
        UIButton *buttonName44 = [self createButtonForHotspotWithRect:CGRectMake(132, 102, 25, 25) title:@"热点" tag:kHotspotTAG44];
        [roomTypeImageView addSubview:buttonName44];
        UIButton *buttonName55 = [self createButtonForHotspotWithRect:CGRectMake(127, 152, 25, 25) title:@"热点" tag:kHotspotTAG55];
        [roomTypeImageView addSubview:buttonName55];
        UIButton *buttonName66 = [self createButtonForHotspotWithRect:CGRectMake(192, 147, 25, 25) title:@"热点" tag:kHotspotTAG66];
        [roomTypeImageView addSubview:buttonName66];
        UIButton *buttonName77 = [self createButtonForHotspotWithRect:CGRectMake(212, 77, 25, 25) title:@"热点" tag:kHotspotTAG77];
        [roomTypeImageView addSubview:buttonName77];
        UIButton *buttonName88 = [self createButtonForHotspotWithRect:CGRectMake(212, 102, 25, 25) title:@"热点" tag:kHotspotTAG88];
        [roomTypeImageView addSubview:buttonName88];
        UIButton *buttonName99 = [self createButtonForHotspotWithRect:CGRectMake(192, 184, 25, 25) title:@"热点" tag:kHotspotTAG99];
        [roomTypeImageView addSubview:buttonName99];
        
    }
    [roomTypeImageView setHidden:!roomTypeImageView.hidden];
    
}

- (UIButton *)createButtonForHotspotWithRect:(CGRect)rect title:(NSString *)string tag:(NSInteger)tag
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"hotSpotCustom.png"] forState:UIControlStateNormal];
    [button setFrame:rect];
    button.titleLabel.font = [UIFont systemFontOfSize:10];
    [button setTitle:string forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

    [button setImageEdgeInsets:UIEdgeInsetsMake(7, 7, 7,7)];

    
    [button setTag:tag];
    [button addTarget:self action:@selector(changeSence:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)changeSence:(UIButton *)sender
{
    PLTransitionFadeOut *fadeOut = [[PLTransitionFadeOut alloc] initWithInterval:kPLViewTransitionTimeInterval];
    fadeOut.delegate = plView;
    currentClickHotSpot = sender.tag;
    [fadeOut executeWithView:plView scene:panorama];
    
}



#pragma mark - PLview delegate
-(void)view:(UIView<PLIView> *)pView didClickHotspot:(PLHotspot *)hotspot screenPoint:(CGPoint)point scene3DPoint:(PLPosition)position
{
    
    PLTransitionFadeOut *fadeOut = [[PLTransitionFadeOut alloc] initWithInterval:kPLViewTransitionTimeInterval];
    fadeOut.delegate = plView;
    sceneFlag = (int) hotspot.identifier;
    currentClickHotSpot = -1;
    [self transitionEffect];
    [fadeOut executeWithView:plView scene:panorama];
    
}

-(void)view:(UIView<PLIView> *)pView didEndTransition:(PLTransition *)transition
{
    // 清除场景
    [plView clear];
    // 重置镜头
    [plView.camera reset];
    // 初始化场景
    
    [self initTheSenceWithType:sceneFlag];
    
    
    [self resetSceneFlag];
    PLTransitionFadeIn *fadeIn = [[PLTransitionFadeIn alloc] initWithInterval:kPLViewTransitionTimeInterval];
    [fadeIn executeWithView:plView scene:panorama];
    roomTypeImageView.hidden = YES;
}

-(BOOL)view:(UIView<PLIView> *)pView didRotateCamera:(PLCamera *)camera rotation:(PLRotation)rotation
{
//    NSLog(@"pitch == %f  roll == %f  yaw == %f",rotation.pitch,rotation.roll,rotation.yaw);
    
    for (PLHotspot *hotSpot in pView.panorama.elements ) {

        if (hotSpot.identifier == kHotspotTAG44TO00) {
            // 320*568
            
            
            
            float yFloat = rotation.pitch*548.0/90.0;
            
//            label1.frame = CGRectMake(160.0+ (hotSpot.ath+ rotation.yaw)*(320.0/45.0)*0.83-15, 284.0-yFloat-30, 30, 15);

        }
        
    }

    
    return YES;
}

#pragma mark - Other method
- (void)transitionEffect
{
    for (int i = 0; i < 50; i++) {
        plView.camera.fov += 0.002f;
        [plView drawView];
    }
}

- (void)resetSceneFlag
{
    sceneFlag = -1;
}

#pragma mark- 初始化 sence
- (void)initTheSenceWithType:(NSInteger)type
{
    
    if (currentClickHotSpot == kHotspotTAG00 ||sceneFlag == kHotspotTAG44TO00) {
        [(PLSphericalPanorama *)panorama setTexture:[PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"00" ofType:@"jpg"]]]];
        PLTexture *hotspotTexture = [PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"hotspot" ofType:@"png"]]];
        PLHotspot *hotspot = [PLHotspot hotspotWithId:kHotspotTAG00TO44 texture:hotspotTexture atv:-35 ath:127 width:0.04f height:0.04f];
        [panorama addHotspot:hotspot];
    }else if (currentClickHotSpot == kHotspotTAG11){
        [(PLSphericalPanorama *)panorama setTexture:[PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"11" ofType:@"jpg"]]]];
    }else if (currentClickHotSpot == kHotspotTAG22){
        [(PLSphericalPanorama *)panorama setTexture:[PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"22" ofType:@"jpg"]]]];
        
    }else if (currentClickHotSpot == kHotspotTAG33){
        [(PLSphericalPanorama *)panorama setTexture:[PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"33" ofType:@"jpg"]]]];
        
    }else if (currentClickHotSpot == kHotspotTAG44||sceneFlag == kHotspotTAG77TO44  ||sceneFlag == kHotspotTAG88TO44 || sceneFlag == kHotspotTAG00TO44){
        [(PLSphericalPanorama *)panorama setTexture:[PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"44" ofType:@"jpg"]]]];
        PLTexture *hotspotTexture = [PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"hotspot" ofType:@"png"]]];
        
        PLHotspot *hotspot44To77 = [PLHotspot hotspotWithId:kHotspotTAG44TO77 texture:hotspotTexture atv:0 ath:98 width:0.04f height:0.04f];
        [panorama addHotspot:hotspot44To77];
        PLHotspot *hotspot44To88 = [PLHotspot hotspotWithId:kHotspotTAG44TO88 texture:hotspotTexture atv:0 ath:104 width:0.04f height:0.04f];
        [panorama addHotspot:hotspot44To88];
        PLHotspot *hotspot44To00 = [PLHotspot hotspotWithId:kHotspotTAG44TO00 texture:hotspotTexture atv:0 ath:-115 width:0.04f height:0.04f];
        [panorama addHotspot:hotspot44To00];
    }else if (currentClickHotSpot == kHotspotTAG55){
        [(PLSphericalPanorama *)panorama setTexture:[PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"55" ofType:@"jpg"]]]];
        
    }else if (currentClickHotSpot == kHotspotTAG66){
        [(PLSphericalPanorama *)panorama setTexture:[PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"66" ofType:@"jpg"]]]];
        
    }else if (currentClickHotSpot == kHotspotTAG77||sceneFlag == kHotspotTAG44TO77  ){
        [(PLSphericalPanorama *)panorama setTexture:[PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"77" ofType:@"jpg"]]]];
        PLTexture *hotspotTexture = [PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"hotspot" ofType:@"png"]]];
        PLHotspot *hotspot = [PLHotspot hotspotWithId:kHotspotTAG77TO44 texture:hotspotTexture atv:-31 ath:-167 width:0.04f height:0.04f];
        [panorama addHotspot:hotspot];
    }else if (currentClickHotSpot == kHotspotTAG88||sceneFlag == kHotspotTAG44TO88){
        [(PLSphericalPanorama *)panorama setTexture:[PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"88" ofType:@"jpg"]]]];
        PLTexture *hotspotTexture = [PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"hotspot" ofType:@"png"]]];
        PLHotspot *hotspot = [PLHotspot hotspotWithId:kHotspotTAG88TO44 texture:hotspotTexture atv:-40 ath:-116 width:0.04f height:0.04f];
        [panorama addHotspot:hotspot];
    }else if (currentClickHotSpot == kHotspotTAG99){
        [(PLSphericalPanorama *)panorama setTexture:[PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"99" ofType:@"jpg"]]]];
        
    }
    
    
}

-(void)dealloc
{
    
    [super dealloc];
}

@end