//
//  DNCBaseSceneModels.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

//
// Request Models
//
#pragma mark - Request Models

@interface __DNCBaseSceneRequest : NSObject

+ (instancetype)request;

@end

@interface DNCBaseSceneRequest : __DNCBaseSceneRequest

@end

@interface DNCBaseSceneConfirmationRequest : __DNCBaseSceneRequest

@property (strong, nonatomic)   NSString*   selection;

@property (strong, nonatomic)   id  userData;

@end

//
// Response Models
//
#pragma mark - Response Models

@interface __DNCBaseSceneResponse : NSObject

+ (instancetype)response;

@end

@interface DNCBaseSceneResponse : __DNCBaseSceneResponse
@end

@interface DNCBaseSceneConfirmationResponse : __DNCBaseSceneResponse

@property (copy, nonatomic) NSString*   title;
@property (copy, nonatomic) NSString*   message;
@property (copy, nonatomic) NSString*   button1;
@property (copy, nonatomic) NSString*   button2;

@property (assign, atomic)  UIAlertControllerStyle  alertStyle;
@property (assign, atomic)  UIAlertActionStyle      button1Style;
@property (assign, atomic)  UIAlertActionStyle      button2Style;

@property (strong, nonatomic)   id  userData;

@end

@interface DNCBaseSceneDismissResponse : __DNCBaseSceneResponse

@property (assign, atomic)  BOOL            animated;
@property (copy, nonatomic) NSDictionary*   sendData;

@end

@interface DNCBaseSceneErrorResponse : __DNCBaseSceneResponse

@property (strong, nonatomic)   NSString*   title;
@property (strong, nonatomic)   NSError*    error;

@end

@interface DNCBaseSceneMessageResponse : __DNCBaseSceneResponse

@property (strong, nonatomic)   NSString*   title;
@property (strong, nonatomic)   NSString*   message;

@end

@interface DNCBaseSceneSpinnerResponse : __DNCBaseSceneResponse

@property (assign, atomic)  BOOL    show;

@end

@interface DNCBaseSceneTitleResponse : __DNCBaseSceneResponse

@property (strong, nonatomic)   NSString*   title;

@end

//
// ViewModel Models
//
#pragma mark - ViewModel Models

@interface __DNCBaseSceneViewModel : NSObject

+ (instancetype)viewModel;

@end

@interface DNCBaseSceneViewModel : __DNCBaseSceneViewModel

@property (copy, nonatomic)   NSDictionary* sendData;

@end

@interface DNCBaseSceneConfirmationViewModel : __DNCBaseSceneViewModel

@property (copy, nonatomic) NSString*   title;
@property (copy, nonatomic) NSString*   message;
@property (copy, nonatomic) NSString*   button1;
@property (copy, nonatomic) NSString*   button2;

@property (assign, atomic)  UIAlertControllerStyle  alertStyle;
@property (assign, atomic)  UIAlertActionStyle      button1Style;
@property (assign, atomic)  UIAlertActionStyle      button2Style;

@property (strong, nonatomic)   id  userData;

@end

@interface DNCBaseSceneDismissViewModel : __DNCBaseSceneViewModel

@property (assign, atomic)  BOOL            animated;
@property (copy, nonatomic) NSDictionary*   sendData;

@end

@interface DNCBaseSceneMessageViewModel : __DNCBaseSceneViewModel

@property (copy, nonatomic)   NSString*   title;
@property (copy, nonatomic)   NSString*   message;

@end

@interface DNCBaseSceneSpinnerViewModel : __DNCBaseSceneViewModel

@property (assign, atomic)  BOOL    show;

@end

@interface DNCBaseSceneTitleViewModel : __DNCBaseSceneViewModel

@property (strong, nonatomic)   NSString*   title;

@end

@interface DNCBaseSceneToastViewModel : __DNCBaseSceneViewModel

@property (copy, nonatomic)   NSString*     title;
@property (copy, nonatomic)   NSString*     message;

@property (copy, nonatomic)   UIColor*      titleColor;
@property (copy, nonatomic)   UIColor*      messageColor;
@property (copy, nonatomic)   UIColor*      backgroundColor;

@property (copy, nonatomic)   UIFont*       titleFont;
@property (copy, nonatomic)   UIFont*       messageFont;

@end
