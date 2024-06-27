import 'package:tempguard_flutter_app/Services/notification_listner.dart';




class PushNotificationObserver {
  final NotificationService _notificationService;
  late Function(NotificationItem) _callback;

  PushNotificationObserver(this._notificationService);

  // Register an observer callback
  void registerObserver(Function(NotificationItem) callback) {
    _callback = callback;
  }

  void _handleNotification(NotificationItem notification) {
    if (_callback != null) {
      _callback(notification);
    }
  }

  void dispose() {
    _notificationService.removeObserver(_handleNotification);
  }
}


