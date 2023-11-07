import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:hop_maldives_admin/models/hotel.dart';
import 'package:image_picker/image_picker.dart';

part 'state.dart';
part 'repository.dart';
part 'data_provider.dart';

class HotelsCubit extends Cubit<HotelsState> {
  static HotelsCubit c(BuildContext context, [bool listen = false]) =>
      BlocProvider.of<HotelsCubit>(context, listen: listen);

  HotelsCubit() : super(const HotelsStateDefault());

  final repo = HotelsRepository();

  Future<void> fetch() async {
    emit(state.copyWith(
      fetch: const HotelsFetchLoading(),
    ));
    try {
      repo.fetch().listen((event) {
        List data = event.data()!['hotels'];

        List<Hotel> hotels = List.generate(
          data.length,
          (i) => Hotel.fromMap(
            data[i],
          ),
        );

        emit(state.copyWith(
          fetch: HotelsFetchSuccess(data: hotels),
        ));
      });
    } catch (e) {
      emit(state.copyWith(
        fetch: HotelsFetchFailed(message: e.toString()),
      ));
    }
  }

  Future<void> add(Hotel hotel, List<XFile>? images) async {
    emit(state.copyWith(
      add: const HotelAddLoading(),
    ));
    try {
      await repo.add(hotel, images);
      emit(state.copyWith(
        add: const HotelAddSuccess(),
      ));
    } catch (e) {
      emit(state.copyWith(
        add: HotelAddFailed(message: e.toString()),
      ));
    }
  }

  Future<void> update(Hotel hotel, List<XFile>? images, int index) async {
    emit(state.copyWith(
      update: const HotelUpdateLoading(),
    ));
    try {
      await repo.update(hotel, images, index);
      emit(state.copyWith(
        update: const HotelUpdateSuccess(),
      ));
    } catch (e) {
      emit(state.copyWith(
        update: HotelUpdateFailed(message: e.toString()),
      ));
    }
  }

  Future<void> delete(int index) async {
    emit(state.copyWith(
      delete: const HotelDeleteLoading(),
    ));
    try {
      await repo.delete(index);
      emit(state.copyWith(
        delete: const HotelDeleteSuccess(),
      ));
    } catch (e) {
      emit(state.copyWith(
        delete: HotelDeleteFailed(message: e.toString()),
      ));
    }
  }
}
// end-cubit
