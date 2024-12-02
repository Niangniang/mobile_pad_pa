import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WebSocketTest(),
    );
  }
}

class WebSocketTest extends StatefulWidget {
  @override
  _WebSocketTestState createState() => _WebSocketTestState();
}

class _WebSocketTestState extends State<WebSocketTest> {
  final WebSocketChannel channel = WebSocketChannel.connect(
    Uri.parse('ws://bregitsonvm2.francecentral.cloudapp.azure.com:8011/ws'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebSocket Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            StreamBuilder(
              stream: channel.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  debugPrint("Data websocket ===> ${snapshot.data}");
                  return Text('Message reçu: ${snapshot.data}');
                } else {
                  return const Text('En attente de message...');
                }
              },
            ),
            TextField(
              onSubmitted: (text) {
                channel.sink.add(text);
              },
              decoration: const InputDecoration(labelText: 'Envoyer un message'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          channel.sink.close(status.goingAway);
        },
        tooltip: 'Fermer la connexion',
        child: const Icon(Icons.close),
      ),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}
