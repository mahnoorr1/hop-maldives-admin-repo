import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class FormProvider extends ChangeNotifier {
  static FormProvider state(BuildContext context, [listen = false]) =>
      Provider.of<FormProvider>(context, listen: listen);

  final chatFormState = GlobalKey<FormBuilderState>();
  final loginFormState = GlobalKey<FormBuilderState>();
  final forgotPassFormState = GlobalKey<FormBuilderState>();

  // islands
  final addIslandState = GlobalKey<FormBuilderState>();
  final editIslandState = GlobalKey<FormBuilderState>();

  // hotels
  final addHotelState = GlobalKey<FormBuilderState>();
  final editHotelState = GlobalKey<FormBuilderState>();

  // resorts
  final addResortState = GlobalKey<FormBuilderState>();
  final editResortState = GlobalKey<FormBuilderState>();

  // discover
  final discoverFormState = GlobalKey<FormBuilderState>();

  // tours
  final addTourState = GlobalKey<FormBuilderState>();
  final editTourState = GlobalKey<FormBuilderState>();

  // diving
  final addDivingState = GlobalKey<FormBuilderState>();
  final editDivingState = GlobalKey<FormBuilderState>();

  // excursion
  final addExcursionState = GlobalKey<FormBuilderState>();
  final editExcursionState = GlobalKey<FormBuilderState>();
}
