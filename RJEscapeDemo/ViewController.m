//
//  ViewController.m
//  RJEscapeDemo
//
//  Created by TouchWorld on 2020/9/27.
//

#import "ViewController.h"
#import "NSString+RJAdd.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *str = @"关于对《关于征求\"关于进一步加快推进体育强市建设的意见\"（征求意见稿）意见的函》的回复意见";
    NSString *encodeStr = [NSString rj_escapeEncode:str];
    NSLog(@"encode: %@", encodeStr);
    NSString *decodeStr = [NSString rj_escapeDecode:encodeStr];
    NSLog(@"decode: %@", decodeStr);
}


@end
