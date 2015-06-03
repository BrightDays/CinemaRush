//
//  SignUpVC.m
//  CinemaRush
//
//  Created by darya on 6/3/15.
//  Copyright (c) 2015 BrightDays. All rights reserved.
//

#import "SignUpVC.h"
#import "Categories.h"
#import "AuthorisationVC.h"
#import "AppDelegate.h"

@interface SignUpVC ()


@property (nonatomic, strong) UITextField *loginTextField;
@property (nonatomic, strong) UITextField *passwordTextField;

@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic) CGFloat textFieldsWidth;
@property (nonatomic) CGFloat textFieldsHeight;
@property (nonatomic, strong) UIButton *signUpButton;


@end

@implementation SignUpVC

#pragma mark - view
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
}

#pragma mark - UI

- (void) initUI
{
    [self initBackground];
    [self initTextFields];
    [self initSignUpButton];
    [self initCancelButton];
    [self initLogoImageView];
}


- (void) initBackground
{
    UIImage *image = [UIImage imageNamed:@"loginBackground@2x.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnBackgroundAction:)];
    [self.view addGestureRecognizer:tapRecognizer];
}


- (void) initLogoImageView
{
    UIImage *logoImage = [UIImage imageNamed:@"iconMain300@2x.png"];
    self.logoImageView = [[UIImageView alloc] initWithImage:logoImage];
    CGFloat width = self.loginTextField.width / 2;
    self.logoImageView.layer.masksToBounds = YES;
    self.logoImageView.frame = CGRectMake((self.view.width - width) / 2, (self.loginTextField.originY - width) / 2, width, width);
    self.logoImageView.alpha = 0.7f;
    [self.view addSubview:self.logoImageView];
}

- (void) initSignUpButton
{
    self.signUpButton = [[UIButton alloc] initWithFrame:CGRectMake(self.loginTextField.originX, self.passwordTextField.originY + self.passwordTextField.height + 20, self.textFieldsWidth, self.textFieldsHeight)];
    [self.signUpButton setTitle:@"Sign Up" forState:UIControlStateNormal];
    [self.signUpButton setTitleColor:[UIColor whiteColorWithAlpha:0.6f] forState:UIControlStateNormal];
    self.signUpButton.backgroundColor = [UIColor colorFromHexString:@"#ff6161" withAlpha:0.7f];
    self.signUpButton.layer.cornerRadius = 10.f;
    [self.signUpButton addTarget:self action:@selector(signUpButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.signUpButton];
}

- (void) initCancelButton
{
    self.cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(self.loginTextField.originX, self.signUpButton.originY + self.signUpButton.height + 10, self.textFieldsWidth, self.textFieldsHeight)];
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:[UIColor whiteColorWithAlpha:0.6f] forState:UIControlStateNormal];
    self.cancelButton.backgroundColor = [UIColor colorFromHexString:@"#850021" withAlpha:0.7f];
    self.cancelButton.layer.cornerRadius = 10.f;
    [self.cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cancelButton];
}

- (void) initLoginTextField
{
    self.loginTextField = [[UITextField alloc] initWithFrame:CGRectMake((self.view.width - self.textFieldsWidth) / 2, self.view.height / 2 - 80, self.textFieldsWidth, self.textFieldsHeight)];
    self.loginTextField.backgroundColor = [UIColor whiteColorWithAlpha:0.4f];
    self.loginTextField.placeholder = @"Login";
    self.loginTextField.text = @"";
    self.loginTextField.layer.cornerRadius = 10.f;
    self.loginTextField.textColor = [UIColor whiteColorWithAlpha:0.8f];
    self.loginTextField.textAlignment = NSTextAlignmentCenter;
    self.loginTextField.tag = TextFieldTypeLogin;
    self.loginTextField.delegate = self;
}

- (void) initPasswordTextField
{
    self.passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.loginTextField.originX, self.loginTextField.originY + self.loginTextField.height + 10, self.textFieldsWidth, self.textFieldsHeight)];
    self.passwordTextField.backgroundColor = self.loginTextField.backgroundColor;
    self.passwordTextField.placeholder = @"Password";
    self.passwordTextField.text = @"";
    self.passwordTextField.layer.cornerRadius = 10.f;
    self.passwordTextField.textColor = [UIColor whiteColorWithAlpha:0.8f];
    self.passwordTextField.textAlignment = NSTextAlignmentCenter;
    self.passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordTextField.delegate = self;
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.tag = TextFieldTypePassword;
}

- (void) initTextFields
{
    self.textFieldsWidth = self.view.width - 100;
    self.textFieldsHeight = 44;
    
    [self initLoginTextField];
    [self initPasswordTextField];
    [self.view addSubview:self.loginTextField];
    [self.view addSubview:self.passwordTextField];
}

#pragma mark - actions

- (void) signUpButtonAction:(UIButton*)sender
{
    NSString *login = self.loginTextField.text;
    NSString *password = self.passwordTextField.text;
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    if ([appDelegate checkUniqueLogin:login])
    {
        [appDelegate saveNewUser:login andPassword:password];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Nice!" message:@"You are successfully registrated. Have fun." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    } else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"Login already exists." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

- (void) cancelButtonAction:(UIButton*)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) tapOnBackgroundAction:(UITapGestureRecognizer*)sender
{
    for(UIView *view in self.view.subviews)
    {
        [view resignFirstResponder];
    }
}

#pragma mark - ui alert view delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
