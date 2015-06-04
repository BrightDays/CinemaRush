//
//  SettingsVC.m
//  CinemaRush
//
//  Created by darya on 5/26/15.
//  Copyright (c) 2015 BrightDays. All rights reserved.
//

#import "SettingsVC.h"
#import <MessageUI/MFMailComposeViewController.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import "Categories.h"
#import "Colors.h"

@interface SettingsVC ()



@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *settingsKeys;
@property (nonatomic, strong) NSMutableArray *settingsValues;
@property (nonatomic) BOOL showInterstitialAd;

@property (nonatomic, strong) UIView *topBarView;
@property (nonatomic, strong) UILabel *topBarLabel;

@end


@implementation SettingsVC

#pragma mark - View


-(void) viewDidLoad
{
    [super viewDidLoad];
    
    [self initUI];
}

#pragma mark - setting up

- (void) initUI
{
    [self setUpTopBar];
    [self setUpTableView];
}

- (void) setUpTopBar
{
    self.topBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 80)];
    self.topBarView.backgroundColor = defaultColor;
    self.topBarLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, self.view.width, 40)];
    self.topBarLabel.backgroundColor = [UIColor clearColor];
    self.topBarLabel.textAlignment = NSTextAlignmentCenter;
    self.topBarLabel.textColor = [UIColor whiteColor];
    self.topBarLabel.text = @"Settings";
    self.topBarLabel.font = [UIFont fontWithName:@"Helvetica" size:20.f];
    [self.topBarView addSubview:self.topBarLabel];
    [self.view addSubview:self.topBarView];

}

- (void) setUpTableView
{
    static NSString *cellIdentifier = @"SettingsCell";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, self.view.width, self.view.height) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    self.tableView.backgroundColor = tableViewBackColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [self.view addSubview:self.tableView];
}



#pragma mark - Table View Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return SettingsVCSectionsCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == SettingsVCSectionSharing)
        return SettingsVCSectionSharingRowsCount;
    if (section == SettingsVCSectionSupport)
        return SettingsVCSectionSupportRowsCount;
    if (section == SettingsVCSectionLogOut)
        return SettingsVCSectionLogOutRowsCount;
    return 0;
}


- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    NSString* name;
    if (section == SettingsVCSectionSupport)
    {
        name = @"SUPPORT";
    } else
        if (section == SettingsVCSectionSharing)
        {
            name =  @"SHARING";
        } else
            if (section == SettingsVCSectionLogOut)
            {
                name = @"LOG OUT";
            } else
                name = @"";
    return name;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SettingsCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = tableViewCellColor;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.f];
    if (indexPath.section == SettingsVCSectionSupport)
    {
        if (indexPath.row == SettingsVCSectionSupportRowFeedback)
        {
            cell.textLabel.text = @"Send Feedback";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [cell.imageView setImage:[UIImage imageNamed:@"feedback_"]];
            return cell;
        }
        return nil;
    }
    
    if (indexPath.section == SettingsVCSectionSharing)
    {
        if (indexPath.row == SettingsVCSectionSharingRowEmail)
        {
            cell.textLabel.text = @"Tell a friend";
            cell.accessoryView = nil;
            [cell.imageView setImage:[UIImage imageNamed:@"tell_"]];
            return cell;
        }
        if (indexPath.row == SettingsVCSectionSharingRowFacebook)
        {
            cell.textLabel.text = @"Share on Facebook";
            cell.accessoryView = nil;
            [cell.imageView setImage:[UIImage imageNamed:@"facebook_"]];
            return cell;
        }
        if (indexPath.row == SettingsVCSectionSharingRowTwitter)
        {
            cell.textLabel.text = @"Share on Twitter";
            cell.accessoryView = nil;
            [cell.imageView setImage:[UIImage imageNamed:@"twitter_"]];
            return cell;
        }
        return nil;
    }
    
    if (indexPath.section == SettingsVCSectionLogOut)
    {
        if (indexPath.row == SettingsVCSectionLogOutRowLogOut)
        {
            cell.textLabel.text = @"Log Out";
            cell.accessoryView = nil;
            [cell.imageView setImage:[UIImage imageNamed:@"out_"]];
            return cell;
        }
        return nil;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == SettingsVCSectionSupport)
    {
        if (indexPath.row == SettingsVCSectionSupportRowFeedback)
        {
            [self addActionSheet];
        }
    }
    if (indexPath.section == SettingsVCSectionSharing)
    {
        if (indexPath.row == SettingsVCSectionSharingRowTwitter)
        {
            
            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
            {
                SLComposeViewController* twitterVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
                [twitterVC setInitialText:@"Cool tweet"];
                [twitterVC setCompletionHandler:^(SLComposeViewControllerResult result)
                 {
                     
                 }];
                [self presentViewController:twitterVC animated:YES completion:nil];
            } else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No Twitter Accounts" message:@"There are no Twitter accounts configures. You can add or create a Twitter account in Settings." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alertView show];
            }
        }
        if (indexPath.row == SettingsVCSectionSharingRowFacebook)
        {
            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
            {
                SLComposeViewController* facebookVC = [SLComposeViewController composeViewControllerForServiceType: SLServiceTypeFacebook];
                [facebookVC setInitialText:@"Cool post to FB"];
                [facebookVC setCompletionHandler:^(SLComposeViewControllerResult result)
                 {
                 }];
                [self presentViewController:facebookVC animated:YES completion:nil];
            } else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No Facebook Accounts" message:@"There are no Facebook accounts configured. You can add or create a Facebook account in Settings." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
            }
        }
        if (indexPath.row == SettingsVCSectionSharingRowEmail)
        {
            NSString *mailTo = @"friendEmail@email.com";
            NSString *mailSubject = @"WOW!";
            NSString *msgBody = @"Use cool app: CinemaRush";
            [self sendEmailTo: mailTo ? @[mailTo] : nil withSubject:mailSubject andMessage:msgBody andAttachmentData:nil];
        }
        
    }
    if (indexPath.section == SettingsVCSectionLogOut)
    {
        if (indexPath.row == SettingsVCSectionLogOutRowLogOut)
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
    
}

#pragma mark - support


- (void)addActionSheet
{
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Report a defect", @"Feature request", @"Other", nil];
    actionSheet.tag = 1;
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 1)
    {
        [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
        NSArray *texts = @[@"Report a defect", @"Feature request", @"Other"];
        if (buttonIndex != actionSheet.cancelButtonIndex)
        {
            NSString *mailTo = @"brightdayswork@gmail.com";
            NSString *mailSubject = texts[buttonIndex];
            NSString *msgBody = @"Please describe the problem:\n\r";
            [self sendEmailTo: mailTo ? @[mailTo] : nil withSubject: mailSubject andMessage: msgBody andAttachmentData: nil];
        }
    }
}

- (void)sendEmailTo:(NSArray *)recipients withSubject:(NSString *)subject andMessage:(NSString *)message andAttachmentData:(NSData *)data
{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController* vc = [[MFMailComposeViewController alloc] init];
        vc.mailComposeDelegate = self;
        
        if (recipients)
            [vc setToRecipients:recipients];
        
        [vc setSubject:subject];
        [vc setMessageBody: message isHTML: NO];
        [self presentViewController: vc animated: YES completion: nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Mail Accounts" message:@"There are no Mail accounts configured. You can add or create a Mail account in Settings." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - button actions

-(void) closeViewControllerAction:(id) sender
{
    [self dismissViewControllerAnimated: YES completion: nil];
}

@end
