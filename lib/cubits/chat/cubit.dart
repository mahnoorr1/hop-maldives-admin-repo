import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:hop_maldives_admin/models/message.dart';

part 'state.dart';
part 'repository.dart';
part 'data_provider.dart';

class ChatCubit extends Cubit<ChatState> {
  static ChatCubit c(BuildContext context, [bool listen = false]) =>
      BlocProvider.of<ChatCubit>(context, listen: listen);

  ChatCubit() : super(const ChatStateDefault());

  final repo = ChatRepository();

  Future<void> send(Message message) async {
    emit(state.copyWith(
      send: const ChatSendLoading(),
    ));
    try {
      await repo.send(message);
      emit(state.copyWith(
        send: const ChatSendSuccess(),
      ));
    } catch (e) {
      emit(state.copyWith(
        send: ChatSendFailed(message: e.toString()),
      ));
    }
  }

  Future<void> clean(String doc) async {
    emit(state.copyWith(
      clean: const ChatCleanLoading(),
    ));
    try {
      await repo.clean(doc);
      emit(state.copyWith(
        clean: const ChatCleanSuccess(),
      ));
    } catch (e) {
      emit(state.copyWith(
        clean: ChatCleanFailed(message: e.toString()),
      ));
    }
  }

  Future<void> fetch() async {
    emit(state.copyWith(
      fetch: const ChatFetchLoading(),
    ));
    try {
      repo.fetch().listen(
        (event) {
          Map<String, List<Message>> chats = {};

          for (var e in event.docs) {
            String key = e.data()['uid'];
            chats[key] = [];
          }

          emit(state.copyWith(
            fetch: ChatFetchSuccess(data: event, chats: chats),
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        fetch: ChatFetchFailed(message: e.toString()),
      ));
    }
  }

  Future<void> openChat(String doc) async {
    emit(state.copyWith(
      open: const OpenChatLoading(),
    ));
    try {
      repo.openChat(doc).listen(
        (event) {
          emit(state.copyWith(
            open: OpenChatSuccess(data: event),
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        open: OpenChatFailed(message: e.toString()),
      ));
    }
  }
}
// end-cubit
