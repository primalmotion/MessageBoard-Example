/*
 * AppController.j
 * StackView
 *
 * Created by You on September 24, 2010.
 * Copyright 2010, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>
@import "MessageBoard/MessageBoard.j"

@implementation AppController : CPObject
{
    CPView      _stackView;
    CPArray     _stackDatasource;
    CPTextField _textFieldPadding;
    CPTextField _textFieldWidth;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask];
    var contentView = [theWindow contentView];
    
    
    
    // stack view    
    _stackDatasource =    [
                    [self generateDummyView:"toto" height:30 color:[CPColor greenColor]], 
                    [self generateDummyView:@"titi" height:60 color:[CPColor yellowColor]], 
                    [self generateDummyView:@"tutu" height:50 color:[CPColor redColor]]
                ];
    
    
    _stackView = [[TNStackView alloc] initWithFrame:CGRectMake(10, 50, 300, 600)];
    
    [_stackView setBackgroundColor:[CPColor colorWithHexString:@"c7c7c7"]];
    [_stackView setDataSource:_stackDatasource];
    [_stackView reload];
    [contentView addSubview:_stackView];
    
    
    // controls
    var buttonAdd = [[CPButton alloc] initWithFrame:CGRectMake(10, 10, 100, 24)];
    [buttonAdd setTitle:@"Add dummy"];
    [buttonAdd setTarget:self];
    [buttonAdd setAction:@selector(addDummy:)];
    [contentView addSubview:buttonAdd];    

    var _textFieldPadding = [CPTextField textFieldWithStringValue:@"1" placeholder:@"padding" width:100];
    [_textFieldPadding setFrame:CGRectMake(150, 6, 100, 30)];
    [_textFieldPadding setFloatValue:[_stackView padding]];
    [_textFieldPadding setTarget:self];
    [_textFieldPadding setAction:@selector(setPadding:)];
    [contentView addSubview:_textFieldPadding];
    
    var buttonPadding = [[CPButton alloc] initWithFrame:CGRectMake(250, 10, 100, 24)];
    [buttonPadding setTitle:@"Set padding"];
    [buttonPadding setTarget:self];
    [buttonPadding setAction:@selector(setPadding:)];
    [contentView addSubview:buttonPadding];
    
    
    var _textFieldWidth = [CPTextField textFieldWithStringValue:@"100" placeholder:@"width" width:100];
    [_textFieldWidth setFrame:CGRectMake(370, 6, 100, 30)];
    [_textFieldWidth setTarget:self];
    [_textFieldWidth setAction:@selector(setWidth:)];
    [_textFieldWidth setFloatValue:[_stackView frameSize].width];
    [contentView addSubview:_textFieldWidth];
    
    var buttonWidth = [[CPButton alloc] initWithFrame:CGRectMake(470, 10, 100, 24)];
    [buttonWidth setTitle:@"Set width"];
    [buttonWidth setTarget:self];
    [buttonWidth setAction:@selector(setWidth:)];
    [contentView addSubview:buttonWidth];
    
    
    var buttonReverse = [[CPButton alloc] initWithFrame:CGRectMake(600, 10, 100, 24)];
    [buttonReverse setTitle:@"Reverse"];
    [buttonReverse setTarget:self];
    [buttonReverse setAction:@selector(reverse:)];
    [contentView addSubview:buttonReverse];
    
    [theWindow orderFront:self];
}


- (CPView)generateDummyView:(CPString)aLabel height:(int)aHeight color:(CPColor)aColor
{
    var dummy = [[CPView alloc] initWithFrame:CGRectMake(0,0,100, aHeight)];
    var label = [[CPTextField alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];
    
    [dummy setBackgroundColor:aColor];
    [label setStringValue:aLabel];
    
    [dummy addSubview:label];
    
    return dummy;
    
}

- (IBAction)addDummy:(id)sender
{
    [_stackDatasource addObject:[self generateDummyView:@"generated!" height:30 color:[CPColor grayColor]]];
    [_stackView reload];
}

- (IBAction)setPadding:(id)sender
{
    [_stackView setPadding:[_textFieldPadding floatValue]];
    [_stackView reload];
}

- (IBAction)setWidth:(id)sender
{
    var size = [_stackView frameSize];
    size.width = [_textFieldWidth floatValue];
    
    [_stackView setFrameSize:size];
}

- (IBAction)reverse:(id)sender
{
    [_stackView reverse:sender];
}
@end
