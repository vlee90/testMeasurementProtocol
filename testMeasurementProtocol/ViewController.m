//
//  ViewController.m
//  testMeasurementProtocol
//
//  Created by Vincent Lee on 2/21/15.
//  Copyright (c) 2015 VincentLee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(IBAction)fireButtonPressed:(id)sender {
    NSString *endpoint = @"http://www.google-analytics.com/collect";
//    NSString *endpoint = @"http://www.google-analytics.com/debug/collect";
//    NSString *trackingId = @"UA-59762855-3";
//    NSString *clientId = @"12345";
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
//    NSString *urlString = [NSString stringWithFormat:@"%@?v=1&tid=UA-59762855-3&cid=12345&t=event&ec=Button&ea=Pressed&el=Test&ev=1", endpoint];
    NSString *urlString = [NSString stringWithFormat:@"%@?v=1&tid=UA-59762855-3&cid=12345&t=screenview&an=AppName&av=1.1&aid=lol.id&aiid=lollol.id&cd=HomePage", endpoint];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"GET";
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if ([httpResponse isKindOfClass:[NSHTTPURLResponse class]]) {
            NSInteger code = httpResponse.statusCode;
            if (code == 200) {
                NSLog(@"Status Code : %ld", (long)code);
                NSDictionary *parsedJson = [self parseJSON:data];
                NSLog(@"%@", parsedJson);
                }
            else {
                NSLog(@"Status Code : %ld", (long)code);
                }
            }
        else {
            NSLog(@"Error : %@", error.description);
        }
  }];
    [dataTask resume];
}

-(NSDictionary *)parseJSON:(NSData *)data {
    NSError *error;
    NSDictionary *dictionary =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        NSLog(@"Parse Successful");
        return dictionary;
    }
    else {
        NSLog(@"Parse Failed");
        return nil;
    }
}

@end
