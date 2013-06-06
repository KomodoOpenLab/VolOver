//
//  ViewController.m
//  VolOver
//
//  Created by Owen McGirr on 14/01/2013.
//  Copyright (c) 2013 Owen McGirr. All rights reserved.
//

#import "ViewController.h"

//handy macro for determining if running on an iPad
#define IS_IPAD ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)] && [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    MPMusicPlayerController *vControl = [MPMusicPlayerController iPodMusicPlayer];
    [volSlider setValue:vControl.volume];
    currentValue = vControl.volume;
	if ([vControl playbackState] == MPMusicPlaybackStatePaused) {
		[vControl setVolume:0.0];
		[vControl play];
		startTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(start) userInfo:nil repeats:NO]; // See .h for comment.
	}
	else if ([vControl playbackState] == MPMusicPlaybackStateStopped) {
		[vControl setVolume:0.0];
		MPMediaQuery *everything = [[MPMediaQuery alloc] init];
		everything = [MPMediaQuery songsQuery];
		[vControl setQueueWithQuery:everything];
		[vControl play];
		startTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(start) userInfo:nil repeats:NO]; // See .h for comment.
	}
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    MPMediaQuery *everything = [[MPMediaQuery alloc] init];
    everything = [MPMediaQuery songsQuery];
    if (everything == nil) { // If music library is empty.
        UIAlertView *err = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"You must have at least one song in your music library to use VolOver." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [err show];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (IS_IPAD)
    {
        NSLog(@"ipad");
        if (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation==UIInterfaceOrientationLandscapeRight)
        {
            backgroundView.frame = CGRectMake(0, 0, 1024, 748);
            backgroundView.image = [UIImage imageNamed:@"Default-Landscape.png"];
        }
        else if (toInterfaceOrientation==UIInterfaceOrientationPortrait || toInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown)
        {
            backgroundView.frame = CGRectMake(0, 0, 768, 1004);
            backgroundView.image = [UIImage imageNamed:@"Default.png"];
        }
    }
    else //iphone
    {
        if (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation==UIInterfaceOrientationLandscapeRight)
        {
            backgroundView.frame = CGRectMake(0, 0, 480, 320);
            backgroundView.image = [UIImage imageNamed:@"iphonebackground-landscape.png"];
        }
        else if (toInterfaceOrientation==UIInterfaceOrientationPortrait || toInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown)
        {
            backgroundView.frame = CGRectMake(0,0,320,460);
            backgroundView.image = [UIImage imageNamed:@"iphonebackground.png"];
        }
    }
}





// methods

- (void)start { // Selector for startTimer.
    MPMusicPlayerController *vControl = [MPMusicPlayerController iPodMusicPlayer];
    [vControl pause];
    [vControl setVolume:volSlider.value];
}










// button actions

- (IBAction)vMuteAct:(id)sender {
    MPMusicPlayerController *vControl = [MPMusicPlayerController iPodMusicPlayer];
    if (volSlider.value > 0.0) {
        currentValue = volSlider.value;
        [volSlider setValue:0.0];
        [vControl setVolume:volSlider.value];
    }
    else {
        [volSlider setValue:currentValue];
        [vControl setVolume:volSlider.value];
    }
    if (currentValue == 0.0) {
        [volSlider setValue:0.5];
        [vControl setVolume:volSlider.value];
        currentValue = volSlider.value;
    }
}

- (IBAction)vUpAct:(id)sender {
    [volSlider setValue:volSlider.value+0.1];
    currentValue = volSlider.value;
    MPMusicPlayerController *vControl = [MPMusicPlayerController iPodMusicPlayer];
    [vControl setVolume:volSlider.value];
}

- (IBAction)vDownAct:(id)sender {
    [volSlider setValue:volSlider.value-0.1];
    currentValue = volSlider.value;
    MPMusicPlayerController *vControl = [MPMusicPlayerController iPodMusicPlayer];
    [vControl setVolume:volSlider.value];
}

- (IBAction)volChanged:(id)sender {
    MPMusicPlayerController *vControl = [MPMusicPlayerController iPodMusicPlayer];
    [vControl setVolume:volSlider.value];
    currentValue = volSlider.value;
}
- (void)viewDidUnload {
    backgroundView = nil;
    backgroundView = nil;
    [super viewDidUnload];
}
@end
