//----------------------------------------------------------------------------------------------------------------------
//	NSString+C++.mm			©2021 Stevo Brock	All rights reserved.
//----------------------------------------------------------------------------------------------------------------------

#import "NSString+C++.h"

//----------------------------------------------------------------------------------------------------------------------
// MARK: NSString extension

@implementation NSString (Cpp)

// MARK: Instance methods

//----------------------------------------------------------------------------------------------------------------------
- (NSString*) stringByReplacingOccurrencesOfCString:(const CString&) target withCString:(const CString&) replacement
{
	return [self stringByReplacingOccurrencesOfString:(__bridge NSString*) target.getOSString()
			withString:(__bridge NSString*) replacement.getOSString()];
}

@end
