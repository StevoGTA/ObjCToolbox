//
//  NSObject+NotificationObserver.h
//  ObjC Toolbox
//
//  Created by Stevo on 7/14/23.
//

#import "CNotificationCenter.h"

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//----------------------------------------------------------------------------------------------------------------------
// MARK: NotificationObserver

typedef	void	(^NotificationProc)(const CString& notificationName, const OR<CNotificationCenter::Sender>& sender,
						const CDictionary& info);

typedef NS_ENUM(NSInteger, NotificationObserverOptions) {
	kNotificationObserverOptionsNone			= 0,
	kNotificationObserverOptionsDontUnregister	= 1 << 0,
};

@interface NSObject (NotificationObserver)

// MARK: Instance methods

- (void) registerForNotificationNamed:(const CString&) notificationName
		notificationSender:(const CNotificationCenter::Sender&) notificationSender
		notificationCenter:(CNotificationCenter&) notificationCenter
		notificationObserverOptions:(NotificationObserverOptions) notificationObserverOptions
		with:(NotificationProc) notificationProc;
- (void) registerForNotificationNamed:(const CString&) notificationName
		notificationSender:(const CNotificationCenter::Sender&) notificationSender
		notificationCenter:(CNotificationCenter&) notificationCenter with:(NotificationProc) notificationProc;
- (void) registerForNotificationNamed:(const CString&) notificationName
		notificationCenter:(CNotificationCenter&) notificationCenter
		notificationObserverOptions:(NotificationObserverOptions) notificationObserverOptions
		with:(NotificationProc) notificationProc;
- (void) registerForNotificationNamed:(const CString&) notificationName
		notificationCenter:(CNotificationCenter&) notificationCenter with:(NotificationProc) notificationProc;

- (void) unregisterForNotificationNamed:(const CString&) notificationName
		notificationCenter:(CNotificationCenter&) notificationCenter;

@end

NS_ASSUME_NONNULL_END
