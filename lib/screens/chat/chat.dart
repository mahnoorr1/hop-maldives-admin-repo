import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hop_maldives_admin/configs/app_dimensions.dart';
import 'package:hop_maldives_admin/configs/app_theme.dart';
import 'package:hop_maldives_admin/configs/app_typography.dart';
import 'package:hop_maldives_admin/configs/space.dart';
import 'package:hop_maldives_admin/cubits/chat/cubit.dart';
import 'package:hop_maldives_admin/models/message.dart';
import 'package:hop_maldives_admin/providers/chat_provider.dart';
import 'package:hop_maldives_admin/providers/form_provider.dart';
import 'package:hop_maldives_admin/widgets/app_icon_button.dart';
import 'package:hop_maldives_admin/widgets/text_fields/custom_text_field.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

part 'widgets/_chat_tile.dart';
part 'widgets/_message_bubble.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  ScrollController chatsController = ScrollController();
  ScrollController messagesController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final forms = FormProvider.state(context);
    final provider = Provider.of<ChatProvider>(context);
    final chatCubit = ChatCubit.c(context);
    final chats = chatCubit.state.fetch!.chats;

    return Padding(
      padding: Space.all(1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                'Messages',
                style: AppText.h1b,
              ),
              Space.x!,
              AppIconButton(
                child: const Icon(CommunityMaterialIcons.refresh),
                onPressed: () {
                  chatCubit.fetch();
                },
              ),
            ],
          ),
          Space.y2!,
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: BlocBuilder<ChatCubit, ChatState>(
                    builder: (context, state) {
                      if (state.fetch is ChatFetchLoading) {
                        return const LinearProgressIndicator();
                      }
                      if (state.fetch is ChatFetchSuccess ||
                          state.send is ChatSendSuccess) {
                        if (state.fetch!.data == null ||
                            state.fetch!.data!.docs.isEmpty) {
                          return Center(
                            child: Text(
                              'No New Messages',
                              style: AppText.b2b,
                            ),
                          );
                        }
                        return Container(
                          height: double.infinity,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                width: 0.0,
                                color: AppTheme.c!.primary!,
                              ),
                            ),
                          ),
                          child: SingleChildScrollView(
                            controller: chatsController,
                            padding: Space.h,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children:
                                  state.fetch!.data!.docs.asMap().entries.map(
                                (e) {
                                  bool current =
                                      provider.uid.contains(e.value['uid']);
                                  return _ChatTile(
                                    user: e.value.data(),
                                    current: current,
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        );
                      } else if (state.fetch is ChatFetchFailed) {
                        return Center(
                          child: Text(state.fetch!.message!),
                        );
                      } else if (state.send is ChatSendFailed) {
                        return Center(
                          child: Text(state.send!.message!),
                        );
                      }
                      return const Spacer();
                    },
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      BlocBuilder<ChatCubit, ChatState>(
                        builder: (context, state) {
                          if (state.open is OpenChatSuccess) {
                            if (state.open!.data != null) {
                              chats![provider.uid] = List.generate(
                                state.open!.data!.docs.length,
                                (index) {
                                  final message =
                                      state.open!.data!.docs[index].data();

                                  return Message.fromMap(message);
                                },
                              );
                            }

                            if (chats![provider.uid]!.isEmpty) {
                              return const Spacer();
                            }

                            return Expanded(
                              child: ListView.builder(
                                controller: messagesController,
                                reverse: true,
                                padding: Space.all(),
                                itemCount: chats[provider.uid]!.length,
                                itemBuilder: (context, index) {
                                  return _MessageBubble(
                                    username: provider.username,
                                    message: chats[provider.uid]![index],
                                    isUser: 'YZHcWqfcTnVUoxkfSs21YuTh89p2' ==
                                        chats[provider.uid]![index].from,
                                  );
                                },
                              ),
                            );
                          }
                          return const Spacer();
                        },
                      ),
                      Space.y1!,
                      if (provider.uid.isNotEmpty)
                        Row(
                          children: [
                            Space.x!,
                            Expanded(
                              child: FormBuilder(
                                key: forms.chatFormState,
                                child: const CustomTextField(
                                  name: 'msg',
                                  hint: 'Type something...',
                                  textInputType: TextInputType.text,
                                ),
                              ),
                            ),
                            Space.x!,
                            AppIconButton(
                              color: AppTheme.c!.primary,
                              child: const Icon(
                                CommunityMaterialIcons.send,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                if (forms.chatFormState.currentState!
                                    .validate()) {
                                  String content = forms.chatFormState
                                      .currentState!.fields['msg']!.value
                                      .toString()
                                      .trim();

                                  final message = Message(
                                    to: provider.uid,
                                    from: 'YZHcWqfcTnVUoxkfSs21YuTh89p2',
                                    content: content,
                                    createdAt:
                                        DateTime.now().millisecondsSinceEpoch,
                                  );

                                  setState(() {
                                    chats![provider.uid]!.insert(0, message);
                                  });

                                  chatCubit.send(message);

                                  forms.chatFormState.currentState!.reset();
                                }
                              },
                            )
                          ],
                        )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
