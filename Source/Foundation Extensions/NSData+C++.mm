//----------------------------------------------------------------------------------------------------------------------
//	NSData+C++.mm			©2024 Stevo Brock	All rights reserved.
//----------------------------------------------------------------------------------------------------------------------

#import "NSData+C++.h"

//----------------------------------------------------------------------------------------------------------------------
// MARK: NSData extension

@implementation NSData (Cpp)

// MARK: Class methods

//----------------------------------------------------------------------------------------------------------------------
+ (instancetype) dataWithReferenceTo:(const CData&) data
{
	return [[NSData alloc] initWithBytesNoCopy:(void*) data.getBytePtr() length:data.getByteCount()];
}

//----------------------------------------------------------------------------------------------------------------------
+ (instancetype) dataWithCopyOf:(const CData&) data
{
	return [[NSData alloc] initWithBytes:data.getBytePtr() length:data.getByteCount()];
}

@end
