//
//  NSObject+NotificationObserver.mm
//  ObjC Toolbox
//
//  Created by Stevo on 8/18/23.
//

#import "NSObject+NotificationObserver.h"

#import <objc/runtime.h>

//----------------------------------------------------------------------------------------------------------------------
// MARK: NotificationHandler

@interface NotificationHandler : NSObject

@property (nonatomic, assign)	CString*					notificationName;
@property (nonatomic, assign)	CNotificationCenter*		notificationCenter;
@property (nonatomic, copy)		NotificationProc			notificationProc;
@property (nonatomic, assign)	NotificationObserverOptions	notificationObserverOptions;

@end

@implementation NotificationHandler

//----------------------------------------------------------------------------------------------------------------------
- (instancetype) initWithNotificationName:(const CString&) notificationName
		notificationCenter:(CNotificationCenter&) notificationCenter
		notificationObserverOptions:(NotificationObserverOptions) notificationObserverOptions
		notificationProc:(NotificationProc) notificationProc
{
	// Do super
	self = [super init];
	if (self) {
		// Store
		self.notificationName = new CString(notificationName);
		self.notificationCenter = &notificationCenter;
		self.notificationProc = notificationProc;
		self.notificationObserverOptions = notificationObserverOptions;
	}

	return self;
}

//----------------------------------------------------------------------------------------------------------------------
- (void) dealloc
{
	// Check options
	if ((self.notificationObserverOptions & kNotificationObserverOptionsDontUnregister) == 0)
		// Unregister
		self.notificationCenter->unregisterObserver(*self.notificationName, (__bridge const void*) self);

	// Cleanup
	Delete(self.notificationName);
}

@end

//----------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------
// MARK: - Local proc declarations

static	void	sNotificationHandler(const CString& notificationName, const OR<CNotificationCenter::Sender>& sender,
						const CDictionary& info, NotificationHandler* notificationHandler);

//----------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------
// MARK: - NSObject (NotificationObserver)

@implementation NSObject (NotificationObserver)

// MARK: Instance methods

//----------------------------------------------------------------------------------------------------------------------
- (void) registerForNotificationNamed:(const CString&) notificationName
		notificationSender:(const CNotificationCenter::Sender&) notificationSender
		notificationCenter:(CNotificationCenter&) notificationCenter
		notificationObserverOptions:(NotificationObserverOptions) notificationObserverOptions
		with:(NotificationProc) notificationProc
{
	// Setup
	NotificationHandler*	notificationHandler =
									[[NotificationHandler alloc]
											initWithNotificationName:notificationName
													notificationCenter:notificationCenter
													notificationObserverOptions:notificationObserverOptions
													notificationProc:notificationProc];
	objc_setAssociatedObject(self, &notificationName, notificationHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

	// Register observer
	notificationCenter.registerObserver(notificationName, notificationSender,
			CNotificationCenter::Observer((__bridge const void*) notificationHandler,
					(CNotificationCenter::Observer::Proc) sNotificationHandler,
					(__bridge void*) notificationHandler));
}

//----------------------------------------------------------------------------------------------------------------------
- (void) registerForNotificationNamed:(const CString&) notificationName
		notificationSender:(const CNotificationCenter::Sender&) notificationSender
		notificationCenter:(CNotificationCenter&) notificationCenter with:(NotificationProc) notificationProc
{
	// Register
	[self registerForNotificationNamed:notificationName notificationSender:notificationSender
			notificationCenter:notificationCenter notificationObserverOptions:kNotificationObserverOptionsNone
			with:notificationProc];
}

//----------------------------------------------------------------------------------------------------------------------
- (void) registerForNotificationNamed:(const CString&) notificationName
		notificationCenter:(CNotificationCenter&) notificationCenter
		notificationObserverOptions:(NotificationObserverOptions) notificationObserverOptions
		with:(NotificationProc) notificationProc
{
	// Setup
	NotificationHandler*	notificationHandler =
									[[NotificationHandler alloc]
											initWithNotificationName:notificationName
													notificationCenter:notificationCenter
													notificationObserverOptions:notificationObserverOptions
													notificationProc:notificationProc];
	objc_setAssociatedObject(self, &notificationName, notificationHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

	// Register observer
	notificationCenter.registerObserver(notificationName,
			CNotificationCenter::Observer((__bridge const void*) notificationHandler,
					(CNotificationCenter::Observer::Proc) sNotificationHandler,
					(__bridge void*) notificationHandler));
}

//----------------------------------------------------------------------------------------------------------------------
- (void) registerForNotificationNamed:(const CString&) notificationName
		notificationCenter:(CNotificationCenter&) notificationCenter with:(NotificationProc) notificationProc
{
	// Register
	[self registerForNotificationNamed:notificationName notificationCenter:notificationCenter
			notificationObserverOptions:kNotificationObserverOptionsNone with:notificationProc];
}

@end

//----------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------
// MARK: - Local proc definitions

//----------------------------------------------------------------------------------------------------------------------
void sNotificationHandler(const CString& notificationName, const OR<CNotificationCenter::Sender>& sender,
		const CDictionary& info, NotificationHandler* notificationHandler)
//----------------------------------------------------------------------------------------------------------------------
{
	// Call proc
	notificationHandler.notificationProc(notificationName, sender, info);
}
