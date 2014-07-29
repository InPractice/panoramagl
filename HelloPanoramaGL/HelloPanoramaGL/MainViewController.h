//
//  MainViewController.h
//  HelloPanoramaGL
//
//  Created by julius on 14-7-25.
//  Copyright (c) 2014年 Senacyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLView.h"
#import "PLJSONLoader.h"

@interface MainViewController : UIViewController <PLViewDelegate>
{
@private
    
    PLView *plView;
    
    
}


@end

