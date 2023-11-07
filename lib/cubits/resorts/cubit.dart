import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:hop_maldives_admin/models/resort.dart';
import 'package:image_picker/image_picker.dart';

part 'state.dart';
part 'repository.dart';
part 'data_provider.dart';

class ResortsCubit extends Cubit<ResortsState> {
  static ResortsCubit c(BuildContext context, [bool listen = false]) =>
      BlocProvider.of<ResortsCubit>(context, listen: listen);

  ResortsCubit() : super(const ResortsStateDefault());

  final repo = ResortsRepository();

  Future<void> fetch() async {
    emit(state.copyWith(
      fetch: const ResortsFetchLoading(),
    ));
    try {
      repo.fetch().listen((event) {
        List data = event.data()!['resorts'];

        List<Resort> resorts = List.generate(
          data.length,
          (i) => Resort.fromMap(
            data[i],
          ),
        );

        emit(state.copyWith(
          fetch: ResortsFetchSuccess(data: resorts),
        ));
      });
    } catch (e) {
      emit(state.copyWith(
        fetch: ResortsFetchFailed(message: e.toString()),
      ));
    }
  }

  Future<void> add(Resort resort, List<XFile>? images) async {
    emit(state.copyWith(
      add: const ResortAddLoading(),
    ));
    try {
      await repo.add(resort, images);
      emit(state.copyWith(
        add: const ResortAddSuccess(),
      ));
    } catch (e) {
      emit(state.copyWith(
        add: ResortAddFailed(message: e.toString()),
      ));
    }
  }

  Future<void> update(Resort resort, List<XFile>? images, int index) async {
    emit(state.copyWith(
      update: const ResortUpdateLoading(),
    ));
    try {
      await repo.update(resort, images, index);
      emit(state.copyWith(
        update: const ResortUpdateSuccess(),
      ));
    } catch (e) {
      emit(state.copyWith(
        update: ResortUpdateFailed(message: e.toString()),
      ));
    }
  }

  Future<void> delete(int index) async {
    emit(state.copyWith(
      delete: const ResortDeleteLoading(),
    ));
    try {
      await repo.delete(index);
      emit(state.copyWith(
        delete: const ResortDeleteSuccess(),
      ));
    } catch (e) {
      emit(state.copyWith(
        delete: ResortDeleteFailed(message: e.toString()),
      ));
    }
  }
}
// end-cubit
