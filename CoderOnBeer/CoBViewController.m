//
//  ViewController.m
//  CoderOnBeer
//
//  Created by Erick Santos on 10/6/15.
//  Copyright © 2015 Erick Vicente. All rights reserved.
//

#import "CoBViewController.h"
#import <CoreSpotlight/CoreSpotlight.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface CoBViewController ()
@property (weak, nonatomic) IBOutlet UILabel *eventName;
@property (weak, nonatomic) IBOutlet UILabel *local;
@property (weak, nonatomic) IBOutlet UIButton *hideButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) NSUserActivity *activityStore;

@end

@implementation CoBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self configureSearchAPI];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Search API
-(void)configureSearchAPI{
    
    NSUserActivity *activity = [[NSUserActivity alloc] initWithActivityType:@"search"];
    activity.title = _eventName.text;
    activity.userInfo = @{@"id" : _eventName.text};
    activity.keywords = [[NSSet alloc] initWithObjects:_local.text, _eventName.text, nil];
    activity.eligibleForSearch = YES;
    activity.eligibleForPublicIndexing = YES;
    
    CSSearchableItemAttributeSet *attributeSet = [[CSSearchableItemAttributeSet alloc] initWithItemContentType:(NSString*)kUTTypeJSON];
    attributeSet.title = _eventName.text;
    attributeSet.contentDescription = _local.text;
    attributeSet.identifier = _eventName.text;
    
    attributeSet.thumbnailData = UIImagePNGRepresentation(_imageView.image);
    activity.contentAttributeSet = attributeSet;
    self.activityStore = activity;
    [activity becomeCurrent];
}

#pragma mark Action Buttons
- (IBAction)detail:(id)sender {
}

- (IBAction)changeName:(id)sender {
    if ([_eventName.text isEqualToString:@"CodersOnBeer"])
        _eventName.text = @"JustBeer";
    else
        _eventName.text = @"CodersOnBeer";
}

- (IBAction)hide:(id)sender {
    [UIView animateWithDuration:0.5f animations:^{
        _hideButton.hidden = YES;
    }];

}

@end
