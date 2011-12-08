//
//  ViewController.m
//  mfer
//
//  Created by Chen-Yu Hsu on 12/8/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController()
-(void)dispatchFirstTouchAtPoint:(CGPoint)touchPoint forEvent:(UIEvent *)event;
-(void)dispatchTouchEvent:(UIView *)theView toPosition:(CGPoint)position;
-(void)dispatchTouchEndEvent:(UIView *)theView toPosition:(CGPoint)position;
-(void)animateView:(UIView *)theView toPosition:(CGPoint) thePosition;
-(void)animateFirstTouchAtPoint:(CGPoint)touchPoint forView:(UIImageView *)theView;
@end

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CGRect r=CGRectMake(arc4random()%300, arc4random()%400, 50, 50);
    UIImage *im=[UIImage imageNamed:@"slot.png"];
    slot=[[UIImageView alloc] initWithFrame:r];
    slot.image=im;
    slot.center=CGPointMake(160, 240);
    [self.view addSubview:slot];
    
    im=[UIImage imageNamed:@"code.png"];
    ii=[[UIImageView alloc] initWithFrame:r];
    ii.image=im; 
    [self.view addSubview:ii];
    
}

-(void)dispatchFirstTouchAtPoint:(CGPoint)touchPoint forEvent:(UIEvent *)event
{
	if (CGRectContainsPoint([ii frame], touchPoint)) {
		[self animateFirstTouchAtPoint:touchPoint forView:ii];
	}
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
		[self dispatchFirstTouchAtPoint:[touch locationInView:self.view] forEvent:nil];
	}
    
}

-(void)dispatchTouchEvent:(UIView *)theView toPosition:(CGPoint)position
{
	if (CGRectContainsPoint([ii frame], position)) {
		ii.center = position;
    
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
		[self dispatchTouchEvent:[touch view] toPosition:[touch locationInView:self.view]];
	}
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	for (UITouch *touch in touches) {
		[self dispatchTouchEndEvent:[touch view] toPosition:[touch locationInView:self.view]];
	}
    
    CGFloat xDis=(slot.center.x-ii.center.x);
    CGFloat yDis=(slot.center.y-ii.center.y);
    CGFloat distance=sqrt((xDis * xDis) + (yDis * yDis));
    
    if(distance<25 && distance>0) ii.center=slot.center;
}

-(void)animateView:(UIView *)theView toPosition:(CGPoint)thePosition
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.15];
	
	theView.center = thePosition;
	
	theView.transform = CGAffineTransformIdentity;
	[UIView commitAnimations];	
}

-(void)dispatchTouchEndEvent:(UIView *)theView toPosition:(CGPoint)position
{   
	if (CGRectContainsPoint([ii frame], position)) {
		[self animateView:ii toPosition: position];
	}
}

-(void)animateFirstTouchAtPoint:(CGPoint)touchPoint forView:(UIImageView *)theView 
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.15];
	theView.transform = CGAffineTransformMakeScale(1.1, 1.1);
	[UIView commitAnimations];
}


 


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
