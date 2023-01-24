//
//  AppController.h
//  Calculator
//
//  Created by Basil Nikityuk on 11/10/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppController : NSObject
{
    IBOutlet NSTextField    *display;
}
@property (assign) IBOutlet NSTextField *display;

- (IBAction)clear:(id)sender;
- (IBAction)clearAll:(id)sender;
- (IBAction)enterDigit:(id)sender;
- (IBAction)enterPoint:(id)sender;
- (IBAction)enterOperation:(id)sender;
- (IBAction)enterEqual:(id)sender;
- (IBAction)invertSign:(id)sender;

@end
