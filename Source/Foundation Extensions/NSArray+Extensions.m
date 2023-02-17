//----------------------------------------------------------------------------------------------------------------------
//	NSArray+Extensions.m			©2023 Stevo Brock	All rights reserved.
//----------------------------------------------------------------------------------------------------------------------

#import "NSArray+Extensions.h"

//----------------------------------------------------------------------------------------------------------------------
// MARK: NSArray extension

@implementation NSArray (Extensions)

//----------------------------------------------------------------------------------------------------------------------
- (nullable NSObject*) firstObjectPassingTest:(BOOL (^)(NSObject* object, BOOL* stop)) block
{
	// Iterate elements
	for (NSUInteger i = 0; i < self.count; i++) {
		// Check this element
		BOOL	stop = NO;
		BOOL	result = block(self[i], &stop);
		if (result)
			// Success
			return self[i];
		else if (stop)
			// Stop
			break;
	}

	return nil;
}

@end
