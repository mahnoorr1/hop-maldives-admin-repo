import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:hop_maldives_admin/models/user_data.dart';

part 'data_provider.dart';
part 'repository.dart';
part 'state.dart';

class UsersCubit extends Cubit<UsersState> {
  static UsersCubit cubit(BuildContext context, [bool listen = false]) =>
      BlocProvider.of<UsersCubit>(context, listen: listen);

  UsersCubit() : super(UsersDefault());

  final repo = UsersRepository();

  Future<void> fetch() async {
    emit(const UsersFetchLoading());
    try {
      repo.fetch().listen((event) {
        List<UserData> data = event.docs
            .map(
              (e) => UserData.fromMap(
                e.data(),
              ),
            )
            .toList();
        emit(UsersFetchSuccess(data: data));
      });
    } catch (e) {
      emit(UsersFetchFailed(message: e.toString()));
    }
  }
}
