//
//  DNCBaseSceneModels.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

#import "DNCBaseSceneCommon.h"

//
// DataObject Models
//
#pragma mark - DataObject Models

@interface __DNCBaseSceneDataObject : NSObject

+ (instancetype)dataObject;

@end

@interface DNCBaseSceneDataObject : __DNCBaseSceneDataObject

@end

//
// Request Models
//
#pragma mark - Request Models

@interface __DNCBaseSceneRequest : NSObject

+ (instancetype)request;

@end

@interface DNCBaseSceneRequest : __DNCBaseSceneRequest

@end

@interface DNCBaseSceneErrorRequest : DNCBaseSceneRequest

@property (strong, nonatomic)   NSString*   title;
@property (strong, nonatomic)   NSError*    error;

@end

@interface DNCBaseSceneConfirmationRequest : DNCBaseSceneRequest

@property (strong, nonatomic)   NSString*   selection;
@property (strong, nonatomic)   NSString*   textField1Value;
@property (strong, nonatomic)   NSString*   textField2Value;

@property (strong, nonatomic)   id  userData;

@end

@interface DNCBaseSceneWebRequest : DNCBaseSceneRequest

@property (strong, nonatomic)   NSURL*  url;

@end

@interface DNCBaseSceneWebErrorRequest : DNCBaseSceneRequest

@property (strong, nonatomic)   NSURL*      url;
@property (strong, nonatomic)   NSError*    error;

@end

//
// Response Models
//
#pragma mark - Response Models

@interface __DNCBaseSceneResponse : NSObject

+ (instancetype)response;

@end

@interface DNCBaseSceneResponse : __DNCBaseSceneResponse

@property (copy, nonatomic) NSString*   scene;

@end

@interface DNCBaseSceneStartResponse : DNCBaseSceneResponse

@property (assign, nonatomic) DNCBaseSceneDisplayType   displayType;

@end

@interface DNCBaseSceneEndResponse : DNCBaseSceneResponse

@property (assign, nonatomic) DNCBaseSceneDisplayType   displayType;

@end

@interface DNCBaseSceneConfirmationResponse : DNCBaseSceneResponse

@property (copy, nonatomic) NSString*               title;
@property (copy, nonatomic) NSString*               message;
@property (assign, atomic)  UIAlertControllerStyle  alertStyle;

@property (assign, atomic)  UIKeyboardType          textField1KeyboardType;
@property (copy, nonatomic) NSString*               textField1Placeholder;
@property (copy, nonatomic) NSString*               textField1TextContentType;

@property (assign, atomic)  UIKeyboardType          textField2KeyboardType;
@property (copy, nonatomic) NSString*               textField2Placeholder;
@property (copy, nonatomic) NSString*               textField2TextContentType;

@property (copy, nonatomic) NSString*               button1;
@property (copy, nonatomic) NSString*               button1Code;
@property (assign, atomic)  UIAlertActionStyle      button1Style;

@property (copy, nonatomic) NSString*               button2;
@property (copy, nonatomic) NSString*               button2Code;
@property (assign, atomic)  UIAlertActionStyle      button2Style;

@property (copy, nonatomic) NSString*               button3;
@property (copy, nonatomic) NSString*               button3Code;
@property (assign, atomic)  UIAlertActionStyle      button3Style;

@property (copy, nonatomic) NSString*               button4;
@property (copy, nonatomic) NSString*               button4Code;
@property (assign, atomic)  UIAlertActionStyle      button4Style;

@property (strong, nonatomic)   id  userData;

@end

@interface DNCBaseSceneDismissResponse : DNCBaseSceneResponse

@property (assign, atomic)  BOOL            animated;
@property (copy, nonatomic) NSDictionary*   sendData;

@end

@interface DNCBaseSceneErrorResponse : DNCBaseSceneResponse

@property (strong, nonatomic)   NSString*   title;
@property (strong, nonatomic)   NSError*    error;

@end

@interface DNCBaseSceneMessageResponse : DNCBaseSceneResponse

@property (strong, nonatomic)   NSString*   title;
@property (strong, nonatomic)   NSString*   message;

@end

@interface DNCBaseSceneSpinnerResponse : DNCBaseSceneResponse

@property (assign, atomic)  BOOL    show;

@end

@interface DNCBaseSceneTitleResponse : DNCBaseSceneResponse

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

@property (copy, nonatomic) NSDictionary*   sendData;
@property (copy, nonatomic) NSString*       scene;

@end

@interface DNCBaseSceneStartViewModel : DNCBaseSceneViewModel

@property (assign, nonatomic)   DNCBaseSceneDisplayType     displayType;
@property (assign, atomic)      BOOL                        animated;

@end

@interface DNCBaseSceneEndViewModel : DNCBaseSceneViewModel

@property (assign, nonatomic)   DNCBaseSceneDisplayType     displayType;
@property (assign, atomic)      BOOL                        animated;

@end

@interface DNCBaseSceneConfirmationViewModel : DNCBaseSceneViewModel

@property (copy, nonatomic) NSString*               title;
@property (copy, nonatomic) NSString*               message;
@property (assign, atomic)  UIAlertControllerStyle  alertStyle;

@property (assign, atomic)  UIKeyboardType          textField1KeyboardType;
@property (copy, nonatomic) NSString*               textField1Placeholder;
@property (copy, nonatomic) NSString*               textField1TextContentType;

@property (assign, atomic)  UIKeyboardType          textField2KeyboardType;
@property (copy, nonatomic) NSString*               textField2Placeholder;
@property (copy, nonatomic) NSString*               textField2TextContentType;

@property (copy, nonatomic) NSString*               button1;
@property (copy, nonatomic) NSString*               button1Code;
@property (assign, atomic)  UIAlertActionStyle      button1Style;

@property (copy, nonatomic) NSString*               button2;
@property (copy, nonatomic) NSString*               button2Code;
@property (assign, atomic)  UIAlertActionStyle      button2Style;

@property (copy, nonatomic) NSString*               button3;
@property (copy, nonatomic) NSString*               button3Code;
@property (assign, atomic)  UIAlertActionStyle      button3Style;

@property (copy, nonatomic) NSString*               button4;
@property (copy, nonatomic) NSString*               button4Code;
@property (assign, atomic)  UIAlertActionStyle      button4Style;

@property (strong, nonatomic)   id  userData;

@end

@interface DNCBaseSceneDismissViewModel : DNCBaseSceneViewModel

@property (assign, atomic)  BOOL    animated;

@end

@interface DNCBaseSceneMessageViewModel : DNCBaseSceneViewModel

@property (copy, nonatomic)   NSString*   title;
@property (copy, nonatomic)   NSString*   message;

@end

@interface DNCBaseSceneSpinnerViewModel : DNCBaseSceneViewModel

@property (assign, atomic)  BOOL    show;

@end

@interface DNCBaseSceneTitleViewModel : DNCBaseSceneViewModel

@property (strong, nonatomic)   NSString*   title;

@end

@interface DNCBaseSceneToastViewModel : DNCBaseSceneViewModel

@property (copy, nonatomic)   NSString*     title;
@property (copy, nonatomic)   NSString*     message;

@property (copy, nonatomic)   UIColor*      titleColor;
@property (copy, nonatomic)   UIColor*      messageColor;
@property (copy, nonatomic)   UIColor*      backgroundColor;

@property (copy, nonatomic)   UIFont*       titleFont;
@property (copy, nonatomic)   UIFont*       messageFont;

@end
