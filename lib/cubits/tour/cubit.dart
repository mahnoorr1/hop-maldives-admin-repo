import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:hop_maldives_admin/models/tour.dart';
import 'package:image_picker/image_picker.dart';

part 'state.dart';
part 'repository.dart';
part 'data_provider.dart';

class TourCubit extends Cubit<TourState> {
  static TourCubit c(BuildContext context, [bool listen = false]) =>
      BlocProvider.of<TourCubit>(context, listen: listen);

  TourCubit() : super(const TourStateDefault());

  final repo = TourRepository();

  Future<void> fetch() async {
    emit(state.copyWith(
      fetch: const TourFetchLoading(),
    ));
    try {
      repo.fetch().listen((event) {
        List<Tour> data = List.generate(
          event.docs.length,
          (index) => Tour.fromMap(
            event.docs[index].data(),
          ),
        );
        emit(state.copyWith(
          fetch: TourFetchSuccess(data: data),
        ));
      }, onError: (e) {
        emit(state.copyWith(
          fetch: TourFetchFailed(message: e.toString()),
        ));
      });
    } catch (e) {
      emit(state.copyWith(
        fetch: TourFetchFailed(message: e.toString()),
      ));
    }
  }

  Future<void> add(Tour tour, List<XFile>? images) async {
    emit(state.copyWith(
      add: const TourAddLoading(),
    ));
    try {
      await TourDataProvider.add(tour, images);
      emit(state.copyWith(
        add: const TourAddSuccess(),
      ));
    } catch (e) {
      emit(state.copyWith(
        add: TourAddFailed(message: e.toString()),
      ));
    }
  }

  Future<void> update(
    Tour tour,
    List<XFile>? images,
  ) async {
    emit(state.copyWith(
      update: const TourUpdateLoading(),
    ));
    try {
      await TourDataProvider.update(tour, images);
      emit(state.copyWith(
        update: const TourUpdateSuccess(),
      ));
    } catch (e) {
      emit(state.copyWith(
        update: TourUpdateFailed(message: e.toString()),
      ));
    }
  }

  Future<void> delete(Tour tour) async {
    emit(state.copyWith(
      delete: const TourDeleteLoading(),
    ));
    try {
      await TourDataProvider.delete(tour);
      emit(state.copyWith(
        delete: const TourDeleteSuccess(),
      ));
    } catch (e) {
      emit(state.copyWith(
        delete: TourDeleteFailed(message: e.toString()),
      ));
    }
  }
}
// end-cubit
