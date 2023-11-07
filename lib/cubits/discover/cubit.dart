import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:hop_maldives_admin/models/discover_item.dart';
import 'package:image_picker/image_picker.dart';

part 'state.dart';
part 'repository.dart';
part 'data_provider.dart';

class DiscoverCubit extends Cubit<DiscoverState> {
  static DiscoverCubit c(BuildContext context, [bool listen = false]) =>
      BlocProvider.of<DiscoverCubit>(context, listen: listen);

  DiscoverCubit() : super(const DiscoverStateDefault());

  final repo = DiscoverRepository();

  Future<void> fetch() async {
    emit(state.copyWith(
      fetch: const DiscoverFetchLoading(),
    ));
    try {
      repo.fetch().listen((event) {
        List data = event.data()!['images'];

        List<DiscoverItem> imgs = List.generate(
          data.length,
          (i) => DiscoverItem.fromMap(
            data[i],
          ),
        );
        emit(state.copyWith(
          fetch: DiscoverFetchSuccess(data: imgs),
        ));
      }, onError: (e) {
        emit(state.copyWith(
          fetch: DiscoverFetchFailed(message: e.toString()),
        ));
      });
    } catch (e) {
      emit(state.copyWith(
        fetch: DiscoverFetchFailed(message: e.toString()),
      ));
    }
  }

  Future<void> add(String description, XFile image) async {
    emit(state.copyWith(
      add: const DiscoverAddLoading(),
    ));
    try {
      await DiscoverDataProvider.add(description, image);

      emit(state.copyWith(
        add: const DiscoverAddSuccess(),
      ));
    } catch (e) {
      emit(state.copyWith(
        add: DiscoverAddFailed(message: e.toString()),
      ));
    }
  }

  Future<void> delete(int index) async {
    emit(state.copyWith(
      delete: const DiscoverDeleteLoading(),
    ));
    try {
      await DiscoverDataProvider.delete(index);

      emit(state.copyWith(
        delete: const DiscoverDeleteSuccess(),
      ));
    } catch (e) {
      emit(state.copyWith(
        delete: DiscoverDeleteFailed(message: e.toString()),
      ));
    }
  }
}
// end-cubit
