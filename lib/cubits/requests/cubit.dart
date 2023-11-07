import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hop_maldives_admin/models/booking_requests.dart';

import 'package:hop_maldives_admin/models/request.dart';

part 'state.dart';
part 'repository.dart';
part 'data_provider.dart';

class RequestsCubit extends Cubit<RequestsState> {
  static RequestsCubit c(BuildContext context, [bool listen = false]) =>
      BlocProvider.of<RequestsCubit>(context, listen: listen);

  RequestsCubit() : super(const RequestsStateDefault());

  final repo = RequestsRepository();

  Future<void> fetch() async {
    emit(state.copyWith(
      fetch: const RequestsFetchLoading(),
    ));
    try {
      repo.fetch().listen((event) {
        List<BookingRequests> data = event.docs.map((e) {
          final id = e.id;
          List req = e.data()['requests'];

          List<Request> requests = List.generate(
            req.length,
            (index) => Request.fromMap(
              req[index],
            ),
          );

          return BookingRequests.fromMap({
            'uid': id,
            'requests': requests,
          });
        }).toList();

        emit(state.copyWith(
          fetch: RequestsFetchSuccess(data: data),
        ));
      });
    } catch (e) {
      emit(state.copyWith(
        fetch: RequestsFetchFailed(message: e.toString()),
      ));
    }
  }

  Future<void> updateRequest(Request request, int index) async {
    emit(state.copyWith(
      approve: const RequestUpdateLoading(),
    ));
    try {
      await repo.approveRequest(request, index);

      emit(state.copyWith(
        approve: const RequestUpdateSuccess(),
      ));
    } catch (e) {
      emit(state.copyWith(
        approve: RequestUpdateFailed(message: e.toString()),
      ));
    }
  }
}
// end-cubit
