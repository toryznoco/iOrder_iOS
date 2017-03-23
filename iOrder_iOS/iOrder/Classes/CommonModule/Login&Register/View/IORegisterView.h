//
//  IORegisterView.h
//  iOrder
//
//  Created by 易无解 on 8/17/16.
//  Copyright © 2016 normcore. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IORegisterView;

@protocol IORegisterViewDelegate <NSObject>

- (void)registerView:(IORegisterView *)registerView registerBtnDidPressed:(UIButton *)regitserBtn;

@end

#pragma mark - interface IORegisterTextField

@interface IORegisterTextField : UITextField

@end

#pragma mark - interface IORegisterView

@interface IORegisterView : UIView

@property (nonatomic, weak) id<IORegisterViewDelegate> delegate;

@property (nonatomic, weak) IORegisterTextField *phoneNumber;
@property (nonatomic, weak) IORegisterTextField *password;

@end


