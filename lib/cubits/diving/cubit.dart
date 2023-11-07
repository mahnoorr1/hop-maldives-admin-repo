import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:hop_maldives_admin/models/diving.dart';
import 'package:image_picker/image_picker.dart';

part 'state.dart';
part 'repository.dart';
part 'data_provider.dart';

class DivingCubit extends Cubit<DivingState> {
  static DivingCubit c(BuildContext context, [bool listen = false]) =>
      BlocProvider.of<DivingCubit>(context, listen: listen);

  DivingCubit() : super(const DivingStateDefault());

  final repo = DivingRepository();

  Future<void> fetch() async {
    emit(state.copyWith(
      fetch: const DivingFetchLoading(),
    ));
    try {
      repo.fetch().listen((event) {
        List data = event.data()!['divings'];

        List<Diving> divings = List.generate(
          data.length,
          (i) => Diving.fromMap(
            data[i],
          ),
        );
        emit(state.copyWith(
          fetch: DivingFetchSuccess(data: divings),
        ));
      }, onDone: () {
        emit(state.copyWith(
          fetch: DivingFetchSuccess(data: state.fetch!.data),
        ));
      }, onError: (e, s) {
        emit(state.copyWith(
          fetch: DivingFetchFailed(message: e.toString()),
        ));
      });
    } catch (e) {
      emit(state.copyWith(
        fetch: DivingFetchFailed(message: e.toString()),
      ));
    }
  }

  Future<void> add(Diving diving, List<XFile>? images) async {
    emit(state.copyWith(
      add: const DivingAddLoading(),
    ));
    try {
      await repo.add(diving, images);
      emit(state.copyWith(
        add: const DivingAddSuccess(),
      ));
    } catch (e) {
      emit(state.copyWith(
        add: DivingAddFailed(message: e.toString()),
      ));
    }
  }

  Future<void> update(Diving diving, List<XFile>? images, int index) async {
    emit(state.copyWith(
      update: const DivingUpdateLoading(),
    ));
    try {
      await repo.update(diving, images, index);
      emit(state.copyWith(
        update: const DivingUpdateSuccess(),
      ));
    } catch (e) {
      emit(state.copyWith(
        update: DivingUpdateFailed(message: e.toString()),
      ));
    }
  }

  Future<void> delete(int index) async {
    emit(state.copyWith(
      delete: const DivingDeleteLoading(),
    ));
    try {
      await repo.delete(index);
      emit(state.copyWith(
        delete: const DivingDeleteSuccess(),
      ));
    } catch (e) {
      emit(state.copyWith(
        delete: DivingDeleteFailed(message: e.toString()),
      ));
    }
  }
}
// end-cubit
