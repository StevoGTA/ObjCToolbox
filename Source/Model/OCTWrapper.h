//
//  OCTWrapper.h
//  ObjC Toolbox
//
//  Created by Stevo on 7/4/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//----------------------------------------------------------------------------------------------------------------------
// MARK: OCTWrapper

@interface OCTWrapper : NSObject

// MARK: Properties

- (const void*) object;

// MARK: Class methods

+ (instancetype) wrapperWith:(const void*) object deleteProc:(void (^)(const void* object)) deleteProc;

// MARK: Lifecycle methods

- (instancetype) initWith:(const void*) object deleteProc:(void (^)(const void* object)) deleteProc;

@end

NS_ASSUME_NONNULL_END
