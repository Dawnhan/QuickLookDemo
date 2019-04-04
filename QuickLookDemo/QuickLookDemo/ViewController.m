//
//  ViewController.m
//  QuickLookDemo
//
//  Created by 郑晗 on 2019/4/4.
//  Copyright © 2019年 郑晗. All rights reserved.
//

#import "ViewController.h"
#import <QuickLook/QuickLook.h>

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width//屏幕宽度
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height//屏幕高度

@interface ViewController ()<QLPreviewControllerDataSource,QLPreviewControllerDelegate>

@property (nonatomic ,strong)QLPreviewController *previewController;

@property (nonatomic ,strong)NSArray *fileUrlArray;

@property (nonatomic ,copy)NSURL *fileUrl;

- (IBAction)checkWordAction:(UIButton *)sender;
- (IBAction)checkPDFAction:(UIButton *)sender;
- (IBAction)checkMultipleAction:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}


- (IBAction)checkWordAction:(UIButton *)sender {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"docx"];
    
    self.fileUrlArray = @[[NSURL fileURLWithPath:filePath]];
    
    [self presentViewController:self.previewController animated:YES completion:nil];
}

- (IBAction)checkPDFAction:(UIButton *)sender {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"quicklook" ofType:@"pdf"];
    
    self.fileUrlArray = @[[NSURL fileURLWithPath:filePath]];
    
    [self presentViewController:self.previewController animated:YES completion:nil];
}

- (IBAction)checkMultipleAction:(UIButton *)sender {
    
    NSString *filePath01 = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"docx"];
    
    NSString *filePath02 = [[NSBundle mainBundle] pathForResource:@"quicklook" ofType:@"pdf"];
    
    self.fileUrlArray = @[[NSURL fileURLWithPath:filePath01],[NSURL fileURLWithPath:filePath02]];
    
    QLPreviewController *previewController = [[QLPreviewController alloc] init];
    
    previewController.delegate = self;
    
    previewController.dataSource = self;
    
    [previewController setCurrentPreviewItemIndex:0];
    
    [self presentViewController:previewController animated:YES completion:nil];
    

}

#pragma mark -- QLPreviewControllerDelegate && QLPreviewControllerDataSource
//返回预览文件数量
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController*)previewController {
    
    return self.fileUrlArray.count;
    
}
//返回数据源
- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index {
    
    return self.fileUrlArray[index];
}

// 预览界面将要消失
- (void)previewControllerWillDismiss:(QLPreviewController *)controller {
    
}
// 预览界面已经消失
- (void)previewControllerDidDismiss:(QLPreviewController *)controller {
    
}
// 文件内部链接点击是否进行外部跳转
- (BOOL)previewController:(QLPreviewController *)controller shouldOpenURL:(NSURL *)url forPreviewItem:(id <QLPreviewItem>)item {
    return NO;
}

#pragma mark -- 懒加载

- (QLPreviewController *)previewController
{
    if (!_previewController) {
        _previewController = [[QLPreviewController alloc]init];
        _previewController.delegate = self;
        _previewController.dataSource = self;
    }
    return _previewController;
}
@end
