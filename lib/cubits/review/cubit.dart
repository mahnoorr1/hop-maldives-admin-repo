import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hop_maldives_admin/models/hotel.dart';
import 'package:hop_maldives_admin/models/island.dart';
import 'package:hop_maldives_admin/models/resort.dart';

import 'package:hop_maldives_admin/models/review.dart';

part 'data_provider.dart';
part 'repository.dart';
part 'state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  static ReviewCubit cubit(BuildContext context, [bool listen = false]) =>
      BlocProvider.of<ReviewCubit>(context, listen: listen);

  ReviewCubit() : super(ReviewDefault());

  final repo = ReviewRepository();

  Future<void> update(
    String id,
    Review review,
    int index, {
    bool? isHotel,
    bool? isResort,
    bool? isIsland,
  }) async {
    emit(const ReviewUpdateLoading());

    try {
      await repo.update(id, review, index, isHotel, isResort, isIsland);

      emit(const ReviewUpdateSuccess());
    } catch (e) {
      emit(ReviewUpdateFailed(message: e.toString()));
    }
  }
}
