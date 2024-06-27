import "dart:convert";
import "package:dart_amqp/dart_amqp.dart";


class NotificationItem {
  final String title;
  final String description;

  NotificationItem(this.title, this.description);
}

class NotificationService {

  // List to hold registered observers
  final List<Function(NotificationItem)> _observers = [];

  // Method to register an observer
  void addObserver(Function(NotificationItem) observer) {
    _observers.add(observer);
  }

  // Method to remove an observer
  void removeObserver(Function(NotificationItem) observer) {
    _observers.remove(observer);
  }

  // Method to notify all observers about a new notification
  void _notifyObservers(NotificationItem notification) {
    for (final observer in _observers) {
      observer(notification);
    }
  }


  bool _shouldListen = true; // Flag to control listening

  NotificationItem parseMessage(String message) {
    final parsedJson = json.decode(message);
    final title = parsedJson['title'] as String;
    final description = parsedJson['description'] as String;
    return NotificationItem(title, description);
  }

  void startListeningForNotifications(Function(NotificationItem) callback) async {
    final client = Client(
      settings: ConnectionSettings(
        host: 'your_rabbitmq_host',
        authProvider: PlainAuthenticator('your_username', 'your_password'),
      ),
    );
    try {
      final connection = await client.connect();
      final channel = await connection.channel();

      final queueName = 'your_queue_name';
      final queue = await channel.queue(queueName);

      final consumer = await queue.consume();
      consumer.listen((message) async {
        if (!_shouldListen) {
          await consumer.cancel(); // Cancel the consumer
          await connection.close(); // Close the connection
          return;
        }

        final messageBody = utf8.decode(message.payload);

        // Acknowledge the message
        await message.ack();

        // Parse the message and pass it to the callback
        final parsedMessage = parseMessage(messageBody);
        if (parsedMessage != null) {
          _notifyObservers(parsedMessage); // Notify the observers about the new notification
          callback(parsedMessage); // Also pass the notification to the provided callback
        }
      });
    } catch (e) {
      print('Error connecting to RabbitMQ: $e');
    }
  }

  // Stop listening for notifications
  void stopListening() {
    _shouldListen = false;
  }
}
