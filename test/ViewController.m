//
//  ViewController.m
//  test
//
//  Created by qa on 10/16/14.
//  Copyright (c) 2014 qa. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    IBOutlet UITextField *hanziText;
    IBOutlet UITextField *barcodeText;
    IBOutlet UILabel *pingyinLab;
}
@property (retain, nonatomic)IBOutlet UIWebView *protWebView;
@end


@implementation ViewController
@synthesize protWebView;
- (void)viewDidLoad {
    [super viewDidLoad];
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(10, 140, 350,  520)];
    [webView setUserInteractionEnabled:YES];             //是否支持交互
    [webView setDelegate:self];                          //委托
    [webView setOpaque:NO];                              //Opaque为不透明的意思，这里为透明
    [webView setScalesPageToFit:YES];                    //自动缩放以适应屏幕
    [self.view addSubview:webView];
    
    //加载网页的方式
    //1.创建并加载远程网页
    
    //2.加载本地文件资源
    //    NSURL *url = [NSURL fileURLWithPath:filePath];  //filePath为文件路径
    //    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //    [webView loadRequest:request];
    
    //3.读入一个 HTML，直接写入一个HTML代码
    //    NSString *htmlPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"webapp/loader.html"];//相当于文件地址
    //    NSString *htmlString = [NSString stringWithContentsOfFile: htmlPath encoding:NSUTF8StringEncoding error:NULL];
    //    [webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:htmlPath]];
    opaqueview = [[UIView alloc] initWithFrame:CGRectMake(10, 140, 350, 520 )]; //opaqueview 需要在.h文件中进行声明用以做UIActivityIndicatorView的容器view；
    
    activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(10, 140, 350, 520 )];
    [activityIndicatorView setCenter:opaqueview.center];
    
    [ activityIndicatorView   setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleWhite];  //颜色根据不同的界面自己调整
    [ opaqueview  setBackgroundColor:[ UIColor   blackColor]];
    [ opaqueview  setAlpha: 0.6 ];
    [ self . view  addSubview :  opaqueview];
    [ opaqueview  addSubview : activityIndicatorView];
    
    //    [super viewDidLoad];
//    // Do any additional setup after loading the view, typically from a nib.
//     NSURL * urls=[[NSURL alloc]initWithString:@"www.baidu.com"];
//    [protWebView loadRequest:[NSURLRequest requestWithURL:urls]];
}

//当网页视图已经开始加载一个请求之后得到通知

- (void) webViewDidStartLoad:(UIWebView  *)webView {
    [activityIndicatorView startAnimating];
    opaqueview.hidden = NO;
}

//当网页视图结束加载一个请求之后得到通知

- (void) webViewDidFinishLoad:(UIWebView *)webView{
    [activityIndicatorView stopAnimating]; //停止风火轮
    opaqueview.hidden = YES; //隐藏
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)btnAction:(id)sender{
    if([hanziText.text length]){
       NSMutableString *ms = [[NSMutableString alloc] initWithString:hanziText.text];
        if(CFStringTransform((CFMutableArrayRef)ms, 0, kCFStringTransformMandarinLatin, NO)){
            NSLog(@"pingyin: %@",ms);
        }
        if(CFStringTransform((CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)){
            NSLog(@"pingyin: %@",ms);
        }
        NSMutableString *code = [[NSMutableString alloc] initWithString:barcodeText.text];
        NSString *tempsss = [ms stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString * temp = [@"http://m.kuaidi100.com/index_all.html?type=" stringByAppendingString:tempsss];
        NSString * temps = [temp stringByAppendingString:@"&postid="];
        NSString * tempss = [temps stringByAppendingString:code];
        
        
        NSURL * url = [NSURL URLWithString:tempss];
        NSLog(tempss);
//        NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
//        NSHTTPURLResponse * response = nil;
//        NSData * returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
//        NSString * returnStr = [[NSString alloc]initWithData:returnData encoding:4];
//        //m.kuaidi100.com
//        NSLog(@"%@",returnStr);
//        //NSURL * urls=[[NSURL alloc]initWithString:@"m.kuaidi100.com"];
//       // [protWebView loadRequest:[NSURLRequest requestWithURL:urls]];
//  //      UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 400)];
//        //[self.view addSubview:protWebView];
////      
////        
////        //pingyinLab.text = [str copy];
////        webView =[[UIWebView alloc]initWithFrame:CGRectMake(0, 44, 320, 400)];
////        [webView setUserInteractionEnabled:NO];
////        [webView setBackgroundColor:[UIColor clearColor]];
////        [webView setDelegate:self];
////        [webView setOpaque:NO];
//        NSURL * urls = [NSURL URLWithString:@"http://m.kuaidi100.com/index_all.html?type=quanfengkuaidi&postid=123456"];
        [webView loadRequest:[NSURLRequest requestWithURL:url]];
        
    }
}

@end