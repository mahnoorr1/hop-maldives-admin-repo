part of '../chat.dart';

class _ChatTile extends StatelessWidget {
  final Map user;
  final bool current;
  const _ChatTile({
    Key? key,
    required this.user,
    required this.current,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chatCubit = ChatCubit.c(context);
    final provider = Provider.of<ChatProvider>(context);

    return ListTile(
      leading: CircleAvatar(
        backgroundColor:
            current ? Colors.white60 : AppTheme.c!.primary!.withAlpha(180),
        child: Text(
          user['username'].substring(0, 2).toUpperCase(),
          style: AppText.b2,
        ),
      ),
      tileColor: current ? AppTheme.c!.primary : Colors.transparent,
      onTap: () {
        chatCubit.openChat(user['uid']);
        provider.uid = user['uid'];
        provider.username = user['username'];
      },
      trailing: IconButton(
        splashRadius: AppDimensions.normalize(8),
        icon: Icon(
          Icons.delete,
          color: current ? Colors.white : Colors.red,
        ),
        onPressed: () {
          chatCubit.clean(user['uid']);
          provider.uid = '';
          provider.username = '';
        },
      ),
      title: Text(
        user['username'],
        style: AppText.b2!.copyWith(
          color: current ? Colors.white : Colors.black,
        ),
      ),
      subtitle: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          if (state.clean is ChatCleanLoading) {
            return const LinearProgressIndicator();
          }
          return Text(
            'Click to start chat',
            style: AppText.l2!.copyWith(
              color: current ? Colors.white.withAlpha(150) : Colors.black54,
            ),
          );
        },
      ),
    );
  }
}
