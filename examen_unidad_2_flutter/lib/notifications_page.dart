import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  String _lastTitle = 'Sin notificaciones';
  String _lastBody = '';
  String _fcmToken = 'Sin token';

  @override
  void initState() {
    super.initState();
    _requestNotificationPermission();
    _loadFcmToken();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;

      if (notification != null) {
        setState(() {
          _lastTitle = notification.title ?? 'Sin título';
          _lastBody = notification.body ?? 'Sin contenido';
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Notificación: ${notification.title ?? 'Sin título'}',
            ),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    });
  }

  Future<void> _requestNotificationPermission() async {
    await FirebaseMessaging.instance.requestPermission();
  }

  Future<void> _loadFcmToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    if (token != null && mounted) {
      setState(() {
        _fcmToken = token;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notificaciones')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Última notificación recibida:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(_lastTitle, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(_lastBody.isEmpty ? 'Sin contenido' : _lastBody),
            const SizedBox(height: 24),
            const Text(
              'Envía una notificación de prueba desde Firebase Console para verla aquí cuando la app esté en primer plano.',
            ),
            const SizedBox(height: 24),
            const Text(
              'Token del dispositivo:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SelectableText(_fcmToken),
          ],
        ),
      ),
    );
  }
}
