//
//  ViewController.m
//  Sm2FrameworkDemo
//
//  Created by iOS on 2021/9/29.
//

#import "ViewController.h"
#import "DBChainSm2/DBChainSm2.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.redColor;


    NSArray *arr = [DBChainGMSm2Utils createKeyPairCompress:YES];

    NSLog(@"公私钥对: %@",arr);

};


@end
