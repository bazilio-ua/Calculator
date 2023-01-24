//
//  AppController.m
//  Calculator
//
//  Created by Basil Nikityuk on 11/10/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"

#define OP_ADD		1001
#define OP_SUBTRACT	1002
#define OP_MULTIPLY	1003
#define OP_DIVIDE	1004

@implementation AppController
@synthesize display;

BOOL					yFlag, pointFlag, equalFlag, operationFlag;
NSInteger				operation;
NSMutableString			*storex, *storey;

+ (void)initialize
{
	yFlag = NO;
	pointFlag = NO;
	equalFlag = NO;
	operationFlag = NO;
	
	operation = 0;

	storex = [[NSMutableString alloc] initWithString:@""];
	storey = [[NSMutableString alloc] initWithString:@""];
}

- (IBAction)clear:(id)sender 
{
	pointFlag = NO;

	if (yFlag && !equalFlag)
	{
		[storey setString:@""];
		[display setStringValue:storey];
	}
	else
	{
		[storex setString:@""];
		[display setStringValue:storex];
	}
}

- (IBAction)clearAll:(id)sender 
{
	yFlag = NO;
	pointFlag = NO;
	equalFlag = NO;
	operationFlag = NO;

	operation = 0;
	
	[storex setString:@""];
	[storey setString:@""];
	[display setStringValue:storex];
}

- (IBAction)enterDigit:(id)sender
{
	if (equalFlag)
	{
		equalFlag = NO;

		[storex setString:@""];
		[storex appendFormat:@"%d", [[sender selectedCell] tag]];
		[display setStringValue:storex];
	}
	else
	{
		if (operationFlag)
		{
			if (!yFlag)
			{
				yFlag = YES;
				[storey setString:@""];
			}
			[storey appendFormat:@"%d", [[sender selectedCell] tag]];
			[display setStringValue:storey];
		}
		else
		{
			[storex appendFormat:@"%d", [[sender selectedCell] tag]];
			[display setStringValue:storex];
		}
	}
}

- (IBAction)enterPoint:(id)sender
{
	if (pointFlag)
		return;

	pointFlag = YES;

	if (equalFlag)
	{
		equalFlag = NO;
		
		[storex setString:@""];
		[storex appendString:@"."];
		[display setStringValue:storex];
	}
	else
	{
		if (operationFlag)
		{
			if (!yFlag)
			{
				yFlag = YES;
				[storey setString:@""];
			}
			[storey appendString:@"."];
			[display setStringValue:storey];
		}
		else
		{
			[storex appendString:@"."];
			[display setStringValue:storex];
		}
	}
}

- (IBAction)enterOperation:(id)sender
{
	yFlag = NO;
	equalFlag = NO;
	operationFlag = YES;
	pointFlag = NO;

	operation = [[sender selectedCell] tag];
}

- (IBAction)enterEqual:(id)sender
{
	double	x, y;

	x = [storex doubleValue];

	if (yFlag)
		y = [storey doubleValue];
	else
	{
		if (operationFlag)
		{
			y = [storex doubleValue];
			[storey setString:@""];
			[storey appendFormat:@"%g", y];
			yFlag = YES;
		}
		else
			y = [storex doubleValue];
	}

	equalFlag = YES;
	operationFlag = NO;
	pointFlag = NO;

	[storex setString:@""];

	NSLog(@"x: %f, y: %f", x, y); //DEBUG

	switch (operation) 
	{
		case OP_ADD:
			x = x + y;
			break;
			
		case OP_SUBTRACT:
			x = x - y;
			break;
			
		case OP_MULTIPLY:
			x = x * y;
			break;
			
		case OP_DIVIDE:
			x = x / y;
			break;
			
		default:
			break;
	}
	
	[storex appendFormat:@"%g", x];
	[display setStringValue:storex];
}

- (IBAction)invertSign:(id)sender
{
	double	i;
	
	if (yFlag && !equalFlag)
	{
		i = [storey doubleValue];
		[storey setString:@""];
	}
	else
	{
		i = [storex doubleValue];
		[storex setString:@""];
	}
	
	NSLog(@"i: %f", i); //DEBUG
	
	if (i != 0)
		i = -i;
	
	if (yFlag && !equalFlag)
	{
		[storey appendFormat:@"%g", i];
		[display setStringValue:storey];
	}
	else
	{
		[storex appendFormat:@"%g", i];
		[display setStringValue:storex];
	}
}

@end
