//
//  ViewController.h
//  LXFrame
//
//  Created by 李祥 on 2022/8/2.
//

#import "ViewController.h"
#import "MTRouter.h"

@interface ViewController ()
@property (nonatomic, copy) void (^textBlock)(NSString *msg);
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 200, 50)];
    [button setTitle:@"访问vc1" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.tag = 1;
    [button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 110, 200, 50)];
    [button2 setTitle:@"访问vc2" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button2.tag = 2;
    [button2 addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 170, 200, 50)];
    [button3 setTitle:@"访问vc3(从后往前传值)" forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button3.tag = 5;
    [button3 addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    UIButton *butto3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 230, 200, 50)];
    [butto3 setTitle:@"访问webview" forState:UIControlStateNormal];
    [butto3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    butto3.tag = 3;
    [butto3 addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:butto3];
    
    UIButton *button4 = [[UIButton alloc] initWithFrame:CGRectMake(0, 290, 200, 50)];
    [button4 setTitle:@"访问未定义的页面" forState:UIControlStateNormal];
    [button4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button4.tag = 4;
    [button4 addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];
}

-(void)back:(UIButton *)btn
{
    switch (btn.tag) {
        case 1:{
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setValue:@"hello world" forKey:@"title"];
            UIViewController *controller = [[MTRouter sharedInstance] getViewController:@"VC1" withParam:dic];
            [self presentViewController:controller animated:YES completion:nil];
        }
            break;
        case 2:{
            NSMutableDictionary *dic = [[NSMutableDictionary  alloc] init];
            [dic setValue:@"hello world" forKey:@"title"];
            UIViewController *controller = [[MTRouter sharedInstance] getViewController:@"VC2"  withParam:dic];
            [self presentViewController:controller animated:YES completion:nil];
        }
            break;
        case 3:{
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setValue:@"https://www.baidu.com" forKey:@"url"];
            UIViewController *controller = [[MTRouter sharedInstance] getViewController:@"VC3" withParam:dic];
            [self presentViewController:controller animated:YES completion:nil];
        }
            break;
        case 5:{
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            
            //可以将block加入字典，当做一个回调取值
            self.textBlock = ^(NSString *msg){
                NSLog(@"从VC3中获取的数据是-------%@",msg);
            };
            
            [dic setObject:self.textBlock forKey:@"block"];
            
            UIViewController *controller = [[MTRouter sharedInstance] getViewController:@"VC4"  withParam:dic];
            [self presentViewController:controller animated:YES completion:nil];
        }
            break;
        case 4:{
            UIViewController *controller = [[MTRouter sharedInstance] getViewController:@"unknowvc"  withParam:nil];
            [self presentViewController:controller animated:YES completion:nil];
        }
            
        default:
            break;
    }
}


@end
