import 'package:flutter/material.dart';
import 'package:perso/app/utils/chat_client.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat screen'),
      ),
      body: StreamChat(client: chatClient, child: const ChannelListPage()),
    );
  }
}

class ChannelListPage extends StatefulWidget {
  const ChannelListPage({super.key});

  @override
  State<ChannelListPage> createState() => _ChannelListPageState();
}

class _ChannelListPageState extends State<ChannelListPage> {
  late final _controller = StreamChannelListController(
    client: chatClient,
    // filter: Filter.in_(
    //   'members',
    //   [StreamChat.of(context).currentUser!.id],
    // ),
    channelStateSort: const [SortOption('last_message_at')],
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        body: RefreshIndicator(
          onRefresh: _controller.refresh,
          child: StreamChannelListView(
            controller: _controller,
            onChannelTap: (channel) {
              //TODO: Change to gorouter
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      StreamChannel(
                        channel: channel,
                        child: const ChannelPage(),
                      ),
                ),
              );
            },
          ),
        ),
      );
}

class ChannelPage extends StatelessWidget {
  const ChannelPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamChat(
      client: chatClient,
      child: StreamChatTheme(
        data: StreamChatThemeData.dark(),
        child: const Scaffold(
          appBar: StreamChannelHeader(),
          body: Column(
            children: <Widget>[
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