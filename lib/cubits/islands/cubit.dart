import 'dart:async';

import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:image_picker/image_picker.dart';
import 'package:hop_maldives_admin/models/island.dart';

part 'state.dart';
part 'repository.dart';
part 'data_provider.dart';

class IslandsCubit extends Cubit<IslandsState> {
  static IslandsCubit c(BuildContext context, [bool listen = false]) =>
      BlocProvider.of<IslandsCubit>(context, listen: listen);

  IslandsCubit() : super(const IslandsStateDefault());

  final repo = IslandsRepository();

  Future<void> fetch() async {
    emit(state.copyWith(
      fetch: const IslandsFetchLoading(),
    ));
    try {
      repo.fetch().listen((event) {
        List data = event.data()!['islands'];

        List<Island> islands = List.generate(
          data.length,
          (i) => Island.fromMap(
            data[i],
          ),
        );

        emit(state.copyWith(
          fetch: IslandsFetchSuccess(data: islands),
        ));
      });
    } catch (e) {
      emit(state.copyWith(
        fetch: IslandsFetchFailed(message: e.toString()),
      ));
    }
  }

  Future<void> add(Island island, List<XFile>? images) async {
    emit(state.copyWith(
      add: const IslandAddLoading(),
    ));
    try {
      await repo.add(island, images);
      emit(state.copyWith(
        add: const IslandAddSuccess(),
      ));
    } catch (e) {
      emit(state.copyWith(
        add: IslandAddFailed(message: e.toString()),
      ));
    }
  }

  Future<void> update(Island island, List<XFile>? images, int index) async {
    emit(state.copyWith(
      update: const IslandUpdateLoading(),
    ));
    try {
      await repo.update(island, images, index);
      emit(state.copyWith(
        update: const IslandUpdateSuccess(),
      ));
    } catch (e) {
      emit(state.copyWith(
        update: IslandUpdateFailed(message: e.toString()),
      ));
    }
  }

  Future<void> delete(int index) async {
    emit(state.copyWith(
      delete: const IslandDeleteLoading(),
    ));
    try {
      await repo.delete(index);
      emit(state.copyWith(
        delete: const IslandDeleteSuccess(),
      ));
    } catch (e) {
      emit(state.copyWith(
        delete: IslandDeleteFailed(message: e.toString()),
      ));
    }
  }
}
// end-cubit
