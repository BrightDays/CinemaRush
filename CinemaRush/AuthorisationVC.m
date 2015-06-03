//
//  AuthorisationVC.m
//  CinemaRush
//
//  Created by Admin on 25.05.15.
//  Copyright (c) 2015 BrightDays. All rights reserved.
//

#import "AuthorisationVC.h"
#import "Categories.h"
#import "CustomTabBarController.h"
#import "HomePageVC.h"
#import "SettingsVC.h"
#import "ProfileVC.h"
#import "SearchVC.h"
#import "MapVC.h"


@interface AuthorisationVC ()

@property (nonatomic, strong) UITextField *loginTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) NSArray *textFieldNames;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic) CGFloat textFieldsWidth;
@property (nonatomic) CGFloat textFieldsHeight;

@end

@implementation AuthorisationVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
}

#pragma mark - initUI


- (void) initUI
{
    [self initBackground];
    [self initTextFields];
    [self initLoginButton];
    [self initLogoImageView];
    [self animateUI];
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
    self.logoImageView.frame = CGRectMake((self.view.width - width) / 2, (self.loginTextField.originY - width) / 2, width, width);
    self.logoImageView.alpha = 0.7f;
    [self.view addSubview:self.logoImageView];
}

- (void) initLoginButton
{
    self.loginButton = [[UIButton alloc] initWithFrame:CGRectMake(self.loginTextField.originX, self.passwordTextField.originY + self.passwordTextField.height + 20, self.textFieldsWidth, self.textFieldsHeight)];
    [self.loginButton setTitle:@"Log In" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor whiteColorWithAlpha:0.6f] forState:UIControlStateNormal];
    self.loginButton.backgroundColor = [UIColor colorFromHexString:@"#cc80ff" withAlpha:0.7f];
    self.loginButton.layer.cornerRadius = 10.f;
    [self.loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginButton];
}

- (void) initLoginTextField
{
    self.loginTextField = [[UITextField alloc] initWithFrame:CGRectMake((self.view.width - self.textFieldsWidth) / 2, self.view.height / 2 - 60, self.textFieldsWidth, self.textFieldsHeight)];
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
    self.textFieldNames = @[@"Login", @"Password"];
    
    [self initLoginTextField];
    [self initPasswordTextField];
    [self.view addSubview:self.loginTextField];
    [self.view addSubview:self.passwordTextField];
}

#pragma mark animateUI

- (void) animateUI
{
    __weak AuthorisationVC *weakSelf = self;
    
    //logo
    CGRect logoImageViewFrame = self.logoImageView.frame;
    self.logoImageView.frame = CGRectMake(self.logoImageView.originX, - self.logoImageView.height, self.logoImageView.width, self.logoImageView.height);
    [UIView animateWithDuration:1.f delay:0.f usingSpringWithDamping:0.2f initialSpringVelocity:0.f options:0 animations:^{
        weakSelf.logoImageView.frame = logoImageViewFrame;
    }completion:nil];
    
    //login text field
    CGRect loginTextFieldFrame = self.loginTextField.frame;
    self.loginTextField.frame = CGRectMake(-self.textFieldsWidth, self.loginTextField.originY, self.textFieldsWidth, self.textFieldsHeight);
    [UIView animateWithDuration:1.f delay:0.7f usingSpringWithDamping:0.2f initialSpringVelocity:0.f options:0 animations:^{
        weakSelf.loginTextField.frame = loginTextFieldFrame;
    }completion:nil];
    
    //password text field
    CGRect passwordTextFieldFrame = self.passwordTextField.frame;
    self.passwordTextField.frame = CGRectMake(self.view.width + self.textFieldsWidth, self.passwordTextField.originY, self.textFieldsWidth, self.textFieldsHeight);
    [UIView animateWithDuration:1.f delay:0.9f usingSpringWithDamping:0.2f initialSpringVelocity:0.f options:0 animations:^{
        weakSelf.passwordTextField.frame = passwordTextFieldFrame;
    }completion:nil];
    
    //login button
    CGRect loginButtonFrame = self.loginButton.frame;
    self.loginButton.frame = CGRectMake(self.loginButton.originX, self.view.height + self.textFieldsHeight, self.textFieldsWidth, self.textFieldsHeight);
    [UIView animateWithDuration:1.f delay:1.2f usingSpringWithDamping:0.2f initialSpringVelocity:0.f options:0 animations:^{
        weakSelf.loginButton.frame = loginButtonFrame;
    }completion:nil];
    
    
    
}


#pragma mark - Actions

- (void) tapOnBackgroundAction:(UITapGestureRecognizer*)sender
{
    for(UIView *view in self.view.subviews)
    {
        [view resignFirstResponder];
    }
}


- (void) loginButtonAction:(UIButton*)sender
{
    if ([self.loginTextField.text isEqualToString:@"admin"] && [self.passwordTextField.text isEqualToString:@"admin"])
    {
        CustomTabBarController *controller = [CustomTabBarController new];
        [self presentViewController:controller animated:YES completion:nil];
    }
}

@end
 