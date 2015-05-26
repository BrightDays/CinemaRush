//
//  AuthorisationVC.h
//  CinemaRush
//
//  Created by Admin on 25.05.15.
//  Copyright (c) 2015 BrightDays. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ENUM(NSInteger, TextFieldType)
{
    TextFieldTypeLogin = 0,
    TextFieldTypePassword
};

@interface AuthorisationVC : UIViewController <UITextFieldDelegate, UITabBarControllerDelegate>

@end
