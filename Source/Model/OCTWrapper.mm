//
//  OCTWrapper.mm
//  ObjC Toolbox
//
//  Created by Stevo on 7/4/23.
//

#import "OCTWrapper.h"

//----------------------------------------------------------------------------------------------------------------------
// MARK: OCTWrapper

@interface OCTWrapper ()

@property (nonatomic, assign)	const	void*	_object;
@property (nonatomic, copy)				void	(^deleteProc)(const void* object);

@end

@implementation OCTWrapper

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
	return [[OCTWrapper alloc] initWith:object deleteProc:deleteProc];
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
- (void) dealloc
{
	self.deleteProc(self._object);
}

@end
