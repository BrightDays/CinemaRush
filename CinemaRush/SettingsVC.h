//
//  SettingsVC.h
//  CinemaRush
//
//  Created by darya on 5/26/15.
//  Copyright (c) 2015 BrightDays. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>

typedef NS_ENUM(NSUInteger, SettingsVCSections)
{
    SettingsVCSectionSupport,
    SettingsVCSectionSharing,
    SettingsVCSectionLogOut,
    SettingsVCSectionsCount
};

typedef NS_ENUM(NSUInteger, SettingsVCSectionSupportRow)
{
    SettingsVCSectionSupportRowFeedback,
    SettingsVCSectionSupportRowsCount
};


typedef NS_ENUM(NSUInteger, SettingsVCSectionSharingRow)
{
    SettingsVCSectionSharingRowEmail,
    SettingsVCSectionSharingRowFacebook,
    SettingsVCSectionSharingRowTwitter,
    SettingsVCSectionSharingRowsCount
};

typedef NS_ENUM(NSUInteger, SettingsVCSectionLogOutRow)
{
    SettingsVCSectionLogOutRowLogOut,
    SettingsVCSectionLogOutRowsCount
};



@interface SettingsVC : UIViewController <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate>

@end
