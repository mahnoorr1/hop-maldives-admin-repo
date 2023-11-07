---
to: lib/cubits/<%= h.changeCase.snake(name) %>/cubit.dart
---
<% pascal = h.changeCase.pascal(name) %>
<% cubit = pascal+"Cubit" %>
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

<% args.forEach(function(arg){ %>
import 'package:hop_maldives_admin/models/<%= h.changeCase.snake(arg.model) %>.dart';
<% }); %>

part 'state.dart';
part 'repository.dart';
part 'data_provider.dart';

class <%= cubit %> extends Cubit< <%= pascal %>State> {
  static <%= cubit %> c(BuildContext context, [bool listen = false]) =>
      BlocProvider.of< <%= cubit %>>(context, listen: listen);

  <%= cubit %>() : super(const <%= pascal %>StateDefault());

  final repo = <%= pascal %>Repository();

<% args.forEach(function(arg){ %>
<% baseClass = pascal+h.changeCase.pascal(arg.module) %>
  Future<void> <%= h.changeCase.camel(arg.module) %>() async {
    emit(state.copyWith(
      <%= h.changeCase.camel(arg.state) %>: const <%= baseClass %>Loading(),
    ));
    try {
      final data = await repo.<%= h.changeCase.camel(arg.module) %>();
      emit(state.copyWith(
        <%= h.changeCase.camel(arg.state) %>: <%= baseClass %>Success(data: data),
      ));
    } catch (e) {
      emit(state.copyWith(
        <%= h.changeCase.camel(arg.state) %>: <%= baseClass %>Failed(message: e.toString()),
      ));
    }
  }
<% }); %>
}
// end-cubit
