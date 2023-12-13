import 'package:stream_chat_flutter/stream_chat_flutter.dart';

late StreamChatClient chatClient;
late Channel chatChannel;

class ChatClient {
  static Future<void> initializeClient() async {
    const apiKey = 'nsevqjjfwsgd';
    const userToken =
        '6vq7apsxkj77rdyhctpnzmxcm9nhcvepqcmpjubuj9h3s3qurc34p8ztkmqkpzy5';

    /// Create a new instance of [StreamChatClient] passing the apikey obtained from
    /// your project dashboard.
    chatClient = StreamChatClient(
      apiKey,
      // logLevel: Level.INFO,
    );

    /// Set the current user and connect the websocket.
    /// In a production scenario, this should be done using a backend to generate
    /// a user token using our server SDK.
    /// Please see the following for more information:
    /// https://getstream.io/chat/docs/ios_user_setup_and_tokens/
    await chatClient.connectUser(
      User(
        id: 'peterParker',
      ),
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiUGV0ZXIgUGFya2VyIn0.f7VZ48pPeW5zE7C-fL39pQ7hwMlayLwhYyEHuXaKbX0',
    );
    final channel = chatClient.channel('messaging', id: 'flutter_devs');
    await channel.create();
    await channel.watch();

    chatChannel = channel;
  }
}
