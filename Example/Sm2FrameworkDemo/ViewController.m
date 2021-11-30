//
//  ViewController.m
//  Sm2FrameworkDemo
//
//  Created by iOS on 2021/9/29.
//

#import "ViewController.h"
#import "DBChainSm2/DBChainSm2.h"

#import "Sm2FrameworkDemo-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.redColor;

    NSArray *arr = [DBChainGMSm2Utils createKeyPairCompress:YES];
    NSLog(@"公私钥对: %@",arr);

    NSString *privateKey = @"A4AA6213F7C4ADD493FA6DD6E7A909223D053E8F0F21D6C0EAED4D211F6EC014";
    NSString *pubkey = [DBChainGMSm2Utils adoptPrivatekeyGetPublicKey:privateKey isCompress:YES];

    /// 获取地址
    Address *address = [[Address alloc]init];
    NSData *publicData = [DBChainGMUtils hexToData:pubkey];

    NSString *addressStr = [address sm2GetPubToDpAddress:publicData :ChainTypeCOSMOS_MAIN];
    NSLog(@"固定私钥得出公钥:%@,\n地址:%@",pubkey,addressStr);

    NSString *dbchainStr = [address sm2GetPubToDpAddress:publicData :ChainTypeDBCHAIN_MAIN];
    NSLog(@"DBChain -- 固定私钥得出公钥:%@,\n地址:%@",pubkey,dbchainStr);


};


@end
