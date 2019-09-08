//
//  FViewController.m
//  CTJumpAnimation
//
//  Created by HQ on 15/8/22.
//  Copyright (c) 2015年 HQ. All rights reserved.
//

#import "FViewController.h"
#import "SViewController.h"

#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

#import <objc/runtime.h>

@interface FViewController () <ABPeoplePickerNavigationControllerDelegate>

@end

@implementation FViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(100, 200, 100, 50);
    [button setTitle:@"push" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
  
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)push
{
    [self pushViewController:[SViewController new] animated:YES];
}

- (void)selectedContactButtonAction
{
    //ios6后获取用户权限
    [self accessTheAddress];
    
//    ABPeoplePickerNavigationController *peoleVC = [[ABPeoplePickerNavigationController alloc] init];
//    peoleVC.peoplePickerDelegate = self;
//    //特别注意，这里要使用膜态弹出。
//    [self presentViewController:peoleVC animated:YES completion:nil];
}

//该方法在用户点击弹出通讯录右上角的cancel按钮的时候调用，我们可以在这个方法里实现我们退出通讯录的操作：[selfdismissModalViewControllerAnimated:YES];
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    NSLog(@"peoplePickerNavigationControllerDidCancel");
    [self dismissViewControllerAnimated:YES completion:nil];
}




//当用户通过一个时间进入对话框的时候，显示出来的是一个联系人界面，列出了所有联系人的名字。这个方法就是确定用户是否可以通过点击联系人，查看某个联系人的详情。如果返回 NO，则无法查看列表中联系人的详情，默认返回值为 YES。
//ios8.0一下系统
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    return YES;
}


//该代理方法响应用户进入联系人详情页面后的相关操作，比如去的联系人的某个电话号码。返回值用来表示是否响应系统默认的点击操作，例如，当返回值为yes的之后，我们点击用户的电话号码，除了进行我们规定的取值操作意外，还会执行系统默认的拨号操作，我们当然，如果点击网址，就会打开浏览器，进入点击的页面。 因此，我们将返回值设置为NO。
//ios8.0一下系统
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    //取联系人姓名
    
    NSString *name = (__bridge NSString *)ABRecordCopyCompositeName(person);
    NSLog(@"=======>%@",name);

    //判断点击的区域
    
    if (property == kABPersonPhoneProperty) {
        //取出当前点击的区域中所有的内容
            
        ABMutableMultiValueRef phoneMulti =  ABRecordCopyValue(person,kABPersonPhoneProperty);
            
        //根据点击的那一行对应的identifier取出所在的索引
        int index =  (int)ABMultiValueGetIndexForIdentifier(phoneMulti, identifier);
        //根据索引把相应的值取出
        NSString *phone =  (__bridge NSString *)ABMultiValueCopyValueAtIndex(phoneMulti, index);
        NSLog(@"%@",phone);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    return NO;
    
}

//点击联系人列表上的某人时 直接触发返回
//- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person {
//
//}

//点击联系人进行详细 再点击时具体项时触发返回 ios8.0以上
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    //取联系人姓名
    
    NSString *name = (__bridge NSString *)ABRecordCopyCompositeName(person);
    NSLog(@"=======>%@",name);

    //判断点击的区域
    
    if (property == kABPersonPhoneProperty) {
        //取出当前点击的区域中所有的内容
        
        ABMutableMultiValueRef phoneMulti =  ABRecordCopyValue(person,kABPersonPhoneProperty);
        
        //根据点击的那一行对应的identifier取出所在的索引
        int index =  (int)ABMultiValueGetIndexForIdentifier(phoneMulti, identifier);
        //根据索引把相应的值取出
        NSString *phone =  (__bridge NSString *)ABMultiValueCopyValueAtIndex(phoneMulti, index);
        NSLog(@"%@",phone);
    }
}

//由于在ios6以后对用户信息提供了安全的保护，在获取前必须要通过用户的同意才行
- (void)accessTheAddress
{
    ABAddressBookRef addressBook = nil;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {
        addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        //等待同意后向下执行
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            dispatch_semaphore_signal(sema);
            NSLog(@"这里是用户选择是否允许后的执行代码");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                ABPeoplePickerNavigationController *peoleVC = [[ABPeoplePickerNavigationController alloc] init];
                peoleVC.peoplePickerDelegate = self;
                //特别注意，这里要使用膜态弹出。
                [self presentViewController:peoleVC animated:YES completion:nil];
            });

        });
    }
    else{
        addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    }
}

@end
