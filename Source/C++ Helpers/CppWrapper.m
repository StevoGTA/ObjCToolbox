//
//  CppWrapper.m
//  ObjC Toolbox
//
//  Created by Stevo on 7/4/23.
//

#import "CppWrapper.h"

//----------------------------------------------------------------------------------------------------------------------
// MARK: CppWrapper

@interface CppWrapper ()

@property (nonatomic, assign)	const	void*	_object;
@property (nonatomic, copy)				void	(^deleteProc)(const void* object);

@end

@implementation CppWrapper

// MARK: Properties

//----------------------------------------------------------------------------------------------------------------------
- (const void*) object
{
	return self._object;
}

// MARK: Class methods

//----------------------------------------------------------------------------------------------------------------------
+ (instancetype) wrapperWith:(const void*) object deleteProc:(void (^)(const void* object)) deleteProc
{
	return [[CppWrapper alloc] initWith:object deleteProc:deleteProc];
}

//----------------------------------------------------------------------------------------------------------------------
+ (instancetype) wrapperWith:(const void*) object
{
	return [[CppWrapper alloc] initWith:object];
}

// MARK: Lifecycle methods

//----------------------------------------------------------------------------------------------------------------------
- (instancetype) initWith:(const void*) object deleteProc:(void (^)(const void* object)) deleteProc
{
	// Do super
	self = [super init];
	if (self) {
		// Store
		self._object = object;
		self.deleteProc = deleteProc;
	}

	return self;
}

//----------------------------------------------------------------------------------------------------------------------
- (instancetype) initWith:(const void*) object
{
	// Do super
	self = [super init];
	if (self) {
		// Store
		self._object = object;
	}

	return self;
}

//----------------------------------------------------------------------------------------------------------------------
- (void) dealloc
{
	// Check for deleteProc
	if (self.deleteProc != nil)
		// Cleanup
		self.deleteProc(self._object);
}

@end
