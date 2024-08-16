//----------------------------------------------------------------------------------------------------------------------
//	NSObject+C++.mm			©2024 Stevo Brock	All rights reserved.
//----------------------------------------------------------------------------------------------------------------------

#import "NSObject+C++.h"

#import <objc/objc-runtime.h>

//----------------------------------------------------------------------------------------------------------------------
// MARK: Local data

static	void*	sStorageKey = &sStorageKey;

//----------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------
// MARK: - Storage

@interface Storage : NSObject

@property (nonatomic, strong)	NSMutableDictionary*	dictionary;

@end

@implementation Storage

// MARK: Lifecycle methods

//----------------------------------------------------------------------------------------------------------------------
- (instancetype) init
{
	// Do super
	self = [super init];
	if (self) {
		// Setup
		self.dictionary = [[NSMutableDictionary alloc] init];
	}

	return self;
}

@end

//----------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------
// MARK: - NSObject extension

@implementation NSObject (Cpp)

// MARK: Instance methods

//----------------------------------------------------------------------------------------------------------------------
- (void) storeString:(const CString&) string forKey:(NSString*) key
{
	// Get existing storage
	Storage*	storage = objc_getAssociatedObject(self, sStorageKey);
	if (storage == nil) {
		// Setup storage
		storage = [[Storage alloc] init];
		objc_setAssociatedObject(self, sStorageKey, storage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}

	// Store
	[storage.dictionary setValue:[(__bridge NSString*) string.getOSString() copy] forKey:key];
}

//----------------------------------------------------------------------------------------------------------------------
- (OV<CString>) storedStringForKey:(NSString*) key
{
	// Get storage
	Storage*	storage = objc_getAssociatedObject(self, sStorageKey);
	if (storage == nil)
		// No storage
		return OV<CString>();

	// Get string
	NSString*	string = [storage.dictionary valueForKey:key];
	if (string == nil)
		// No string
		return OV<CString>();

	return OV<CString>(CString((__bridge OSStringType) string));
}

@end
