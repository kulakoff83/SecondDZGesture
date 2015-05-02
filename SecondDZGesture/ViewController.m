//
//  ViewController.m
//  SecondDZGesture
//
//  Created by Dmitriy Kulakov on 02.05.15.
//  Copyright (c) 2015 Dmitriy Kulakov. All rights reserved.
//

#import "ViewController.h"
#import "DZBoardView.h"

@interface ViewController ()

@property (nonatomic,strong) DZBoardView *boardView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor grayColor];
    [self startGame];
    [self addStartButton];
}

- (void)viewDidAppear:(BOOL)animated
{
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
}

- (void)startGame
{
    self.boardView = [[DZBoardView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.height)];
    self.boardView.center = self.view.center;
    [self.view addSubview:self.boardView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addStartButton
{
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeSystem];
    startButton.frame = CGRectMake(25, self.view.frame.size.height/2-25, 50, 50);
    [startButton addTarget:self action:@selector(startButtonPressed) forControlEvents:UIControlEventAllEvents];
    [startButton setTitle:@"START" forState:UIControlStateNormal];
    startButton.tintColor = [UIColor whiteColor];
    [self.view addSubview:startButton];
}

- (void)startButtonPressed
{
    [self startGame];
}


@end
