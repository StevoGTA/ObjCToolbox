//
//  CppWrapper.h
//  ObjC Toolbox
//
//  Created by Stevo on 7/4/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//----------------------------------------------------------------------------------------------------------------------
// MARK: CppWrapper

@interface CppWrapper : NSObject

// MARK: Properties

- (const void*) object;

// MARK: Class methods

+ (instancetype) wrapperWith:(const void*) object deleteProc:(void (^)(const void* object)) deleteProc;
+ (instancetype) wrapperWith:(const void*) object;

// MARK: Lifecycle methods

- (instancetype) initWith:(const void*) object deleteProc:(void (^)(const void* object)) deleteProc;
- (instancetype) initWith:(const void*) object;

@end

NS_ASSUME_NONNULL_END
