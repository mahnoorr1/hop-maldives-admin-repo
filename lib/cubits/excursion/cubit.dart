import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:hop_maldives_admin/models/diving.dart';
import 'package:hop_maldives_admin/models/excursion.dart';
import 'package:image_picker/image_picker.dart';

part 'state.dart';
part 'repository.dart';
part 'data_provider.dart';

class ExcursionCubit extends Cubit<ExcursionState> {
  static ExcursionCubit c(BuildContext context, [bool listen = false]) =>
      BlocProvider.of<ExcursionCubit>(context, listen: listen);

  ExcursionCubit() : super(const ExcursionStateDefault());

  final repo = ExcursionRepository();

  Future<void> fetch() async {
    emit(state.copyWith(
      fetch: const ExcursionFetchLoading(),
    ));
    try {
      repo.fetch().listen((event) {
        List data = event.data()!['excursions'];

        List<Excursion> exc = List.generate(
          data.length,
          (i) => Excursion.fromMap(
            data[i],
          ),
        );
        emit(state.copyWith(
          fetch: ExcursionFetchSuccess(data: exc),
        ));
      }, onDone: () {
        emit(state.copyWith(
          fetch: ExcursionFetchSuccess(data: state.fetch!.data),
        ));
      }, onError: (e, s) {
        emit(state.copyWith(
          fetch: ExcursionFetchFailed(message: e.toString()),
        ));
      });
    } catch (e) {
      emit(state.copyWith(
        fetch: ExcursionFetchFailed(message: e.toString()),
      ));
    }
  }

  Future<void> add(Excursion excursion, List<XFile>? images) async {
    emit(state.copyWith(
      add: const ExcursionAddLoading(),
    ));
    try {
      await repo.add(excursion, images);
      emit(state.copyWith(
        add: const ExcursionAddSuccess(),
      ));
    } catch (e) {
      emit(state.copyWith(
        add: ExcursionAddFailed(message: e.toString()),
      ));
    }
  }

  Future<void> update(Excursion exc, List<XFile>? images, int index) async {
    emit(state.copyWith(
      update: const ExcursionUpdateLoading(),
    ));
    try {
      await repo.update(exc, images, index);
      emit(state.copyWith(
        update: const ExcursionUpdateSuccess(),
      ));
    } catch (e) {
      emit(state.copyWith(
        update: ExcursionUpdateFailed(message: e.toString()),
      ));
    }
  }

  Future<void> delete(int index) async {
    emit(state.copyWith(
      delete: const ExcursionDeleteLoading(),
    ));
    try {
      await repo.delete(index);
      emit(state.copyWith(
        delete: const ExcursionDeleteSuccess(),
      ));
    } catch (e) {
      emit(state.copyWith(
        delete: ExcursionDeleteFailed(message: e.toString()),
      ));
    }
  }
}
// end-cubit
