import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/utils/chat_client.dart';
import 'package:perso/app/widgets/app_bar/perso_app_bar.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PersoAppBar(
        title: 'Chat screen',
      ),
      body: _buildStreamChat(),
    );
  }

  Widget _buildStreamChat() {
    if (chatClient == null) {
      return const Center(
        child: Text('No internet connection.'),
      );
    } else {
      return StreamChat(
        client: chatClient!,
        child: const ChannelListPage(),
      );
    }
  }
}

class ChannelListPage extends StatefulWidget {
  const ChannelListPage({super.key});

  @override
  State<ChannelListPage> createState() => _ChannelListPageState();
}

class _ChannelListPageState extends State<ChannelListPage> {
  final _controller = StreamChannelListController(
    client: chatClient!,
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
  Widget build(BuildContext context) => Scaffold(
        body: RefreshIndicator(
          onRefresh: _controller.refresh,
          child: StreamChannelListView(
            controller: _controller,
            onChannelTap: (channel) {
              context.goNamed(
                ScreenNavigationKey.chatChannel,
                extra: channel,
              );
            },
          ),
        ),
      );
}
