import 'package:flutter/material.dart';
import 'package:perso/app/utils/chat_client.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatChannelScreen extends StatelessWidget {
  const ChatChannelScreen({
    required this.channel,
    super.key,
  });

  final Channel channel;

  @override
  Widget build(BuildContext context) {
    return StreamChat(
      client: chatClient!,
      child: StreamChannel(
        channel: channel,
        child: const Scaffold(
          appBar: StreamChannelHeader(),
          body: Column(
            children: [
              Expanded(
                child: StreamMessageListView(),
              ),
              StreamMessageInput(),
            ],
          ),
        ),
      ),
    );
  }
}
