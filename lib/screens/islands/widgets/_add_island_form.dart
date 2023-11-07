part of '../islands.dart';

class _AddIslandForm extends StatefulWidget {
  const _AddIslandForm({Key? key}) : super(key: key);

  @override
  State<_AddIslandForm> createState() => _AddIslandFormState();
}

class _AddIslandFormState extends State<_AddIslandForm> {
  Map<String, bool> facilities = {};
  List<Hotel> hotels = [];
  List<Diving> divings = [];
  List<Excursion> excursions = [];

  bool emptyHotel = false;
  bool emptyDivingDestinations = false;
  bool emptyExcursion = false;

  @override
  void initState() {
    facilities = Map.fromIterable(
      AppUtils.facilities.map(
        (e) => e,
      ),
      value: (value) => false,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final forms = FormProvider.state(context);
    final hotelCubit = HotelsCubit.c(context);
    final divingCubit = DivingCubit.c(context);
    final excursionCubit = ExcursionCubit.c(context);
    final imgProv = Provider.of<ImagePickerProvider>(context);

    return Material(
      color: Colors.transparent,
      child: Container(
        height: double.infinity,
        decoration: UIProps.boxCard,
        child: SingleChildScrollView(
          padding: Space.all(1),
          child: FormBuilder(
            key: forms.addIslandState,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add New Island',
                      style: AppText.h2b,
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.close,
                      ),
                    )
                  ],
                ),
                Text(
                  'Please enter the following information',
                  style: AppText.l1,
                ),
                Space.y1!,
                CustomTextField(
                  name: 'name',
                  hint: 'Island Name',
                  textInputType: TextInputType.name,
                  validatorFtn: FormBuilderValidators.required(
                    context,
                    errorText: 'Name cannot be empty',
                  ),
                ),
                Space.y!,
                CustomTextField(
                  name: 'address',
                  hint: 'Island address',
                  textInputType: TextInputType.text,
                  validatorFtn: FormBuilderValidators.required(
                    context,
                    errorText: 'Location cannot be empty',
                  ),
                ),
                Space.y!,
                CustomMultiLineTextField(
                  name: 'description',
                  hint: 'Write about Island...',
                  textInputAction: TextInputAction.newline,
                  validatorFtn: FormBuilderValidators.required(
                    context,
                    errorText: 'About cannot be empty',
                  ),
                ),
                Space.y1!,
                Text(
                  'Location',
                  style: AppText.b2b,
                ),
                Text(
                  'This will be a pin shown on map',
                  style: AppText.l2,
                ),
                Space.y!,
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        name: 'lat',
                        hint: 'Latitude',
                        textInputType: TextInputType.number,
                        validatorFtn: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            context,
                            errorText: 'Latitude cannot be empty',
                          ),
                          FormBuilderValidators.numeric(
                            context,
                            errorText: 'Latitude can only be decimal number',
                          ),
                        ]),
                      ),
                    ),
                    Space.x!,
                    Expanded(
                      child: CustomTextField(
                        name: 'lng',
                        hint: 'Longitude',
                        textInputType: TextInputType.number,
                        validatorFtn: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            context,
                            errorText: 'Longitude cannot be empty',
                          ),
                          FormBuilderValidators.numeric(
                            context,
                            errorText: 'Longitude can only be decimal number',
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
                Space.y1!,
                Text(
                  'Images',
                  style: AppText.b2b,
                ),
                Text(
                  'Put some nice images to catch customer attention.',
                  style: AppText.l2,
                ),
                Space.y!,
                Wrap(
                  spacing: AppDimensions.normalize(5),
                  runSpacing: AppDimensions.normalize(5),
                  children: [
                    ...imgProv.images.map(
                      (e) => Stack(
                        children: [
                          Container(
                            width: AppDimensions.normalize(50),
                            height: AppDimensions.normalize(50),
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: NetworkImage(
                                  e.path,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              onPressed: () => imgProv.delete(e),
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () => imgProv.pickImages(),
                      child: Container(
                        width: AppDimensions.normalize(50),
                        height: AppDimensions.normalize(50),
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                            size: AppDimensions.normalize(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Space.y1!,
                Text(
                  'Facilities Available',
                  style: AppText.b2b,
                ),
                Space.y!,
                Wrap(
                  children: facilities.entries
                      .map(
                        (e) => SizedBox(
                          width: AppDimensions.normalize(50),
                          child: FormBuilderCheckbox(
                            onChanged: (value) => setState(() {
                              facilities[e.key] = value!;
                            }),
                            initialValue: e.value,
                            name: e.key,
                            title: Text(toBeginningOfSentenceCase(e.key)!),
                          ),
                        ),
                      )
                      .toList(),
                ),
                Space.y1!,
                Row(
                  children: [
                    Text(
                      'Hotels',
                      style: AppText.b2b,
                    ),
                    if (emptyHotel) ...[
                      Space.x!,
                      Text(
                        'Please add some hotels to Island',
                        style: AppText.l2b!.copyWith(
                          color: Colors.red,
                        ),
                      )
                    ],
                  ],
                ),
                Space.y!,
                BlocBuilder<HotelsCubit, HotelsState>(
                  builder: (context, state) {
                    if (state.fetch is HotelsFetchLoading) {
                      return const LinearProgressIndicator();
                    } else if (state.fetch is HotelsFetchSuccess) {
                      return DropdownButton(
                        onChanged: (value) {},
                        underline: const SizedBox(),
                        isDense: true,
                        isExpanded: true,
                        hint: Text(
                          'Select Hotels',
                          style: AppText.l1,
                        ),
                        items: hotelCubit.state.fetch!.data!
                            .map(
                              (e) => DropdownMenuItem(
                                onTap: () {
                                  setState(() {
                                    hotels.add(e);
                                  });
                                },
                                value: e.id,
                                child: Text(
                                  e.name,
                                  style: AppText.l1,
                                ),
                              ),
                            )
                            .toList(),
                      );
                    }
                    return const SizedBox();
                  },
                ),
                if (hotels.isNotEmpty) ...[
                  Space.y!,
                  Wrap(
                    spacing: AppDimensions.normalize(5),
                    runSpacing: AppDimensions.normalize(5),
                    children: hotels
                        .map(
                          (e) => Chip(
                            backgroundColor: AppTheme.c!.primary,
                            label: Text(
                              e.name,
                              style: AppText.l2!.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            onDeleted: () {
                              setState(() {
                                hotels.remove(e);
                              });
                            },
                            deleteIcon: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: AppDimensions.normalize(6),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
                Space.y1!,
                Row(
                  children: [
                    Text(
                      'Diving Destinations',
                      style: AppText.b2b,
                    ),
                    if (emptyDivingDestinations) ...[
                      Space.x!,
                      Text(
                        'Please add some diving destinations to Island',
                        style: AppText.l2b!.copyWith(
                          color: Colors.red,
                        ),
                      )
                    ],
                  ],
                ),
                Space.y!,
                BlocBuilder<DivingCubit, DivingState>(
                  builder: (context, state) {
                    if (state.fetch is DivingFetchLoading) {
                      return const LinearProgressIndicator();
                    } else if (state.fetch is DivingFetchSuccess) {
                      return DropdownButton(
                        onChanged: (value) {},
                        underline: const SizedBox(),
                        isDense: true,
                        isExpanded: true,
                        hint: Text(
                          'Select Diving Destinations',
                          style: AppText.l1,
                        ),
                        items: divingCubit.state.fetch!.data!
                            .map(
                              (e) => DropdownMenuItem(
                                onTap: () {
                                  setState(() {
                                    divings.add(e);
                                  });
                                },
                                value: e.id,
                                child: Text(
                                  e.name,
                                  style: AppText.l1,
                                ),
                              ),
                            )
                            .toList(),
                      );
                    }
                    return const SizedBox();
                  },
                ),
                if (divings.isNotEmpty) ...[
                  Space.y!,
                  Wrap(
                    spacing: AppDimensions.normalize(5),
                    runSpacing: AppDimensions.normalize(5),
                    children: divings
                        .map(
                          (e) => Chip(
                            backgroundColor: AppTheme.c!.primary,
                            label: Text(
                              e.name,
                              style: AppText.l2!.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            onDeleted: () {
                              setState(() {
                                divings.remove(e);
                              });
                            },
                            deleteIcon: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: AppDimensions.normalize(6),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
                Space.y1!,
                Row(
                  children: [
                    Text(
                      'Excursions',
                      style: AppText.b2b,
                    ),
                    if (emptyDivingDestinations) ...[
                      Space.x!,
                      Text(
                        'Please add some excursions to Island',
                        style: AppText.l2b!.copyWith(
                          color: Colors.red,
                        ),
                      )
                    ],
                  ],
                ),
                Space.y!,
                BlocBuilder<ExcursionCubit, ExcursionState>(
                  builder: (context, state) {
                    if (state.fetch is ExcursionFetchLoading) {
                      return const LinearProgressIndicator();
                    } else if (state.fetch is ExcursionFetchSuccess) {
                      return DropdownButton(
                        onChanged: (value) {},
                        underline: const SizedBox(),
                        isDense: true,
                        isExpanded: true,
                        hint: Text(
                          'Select Excursions',
                          style: AppText.l1,
                        ),
                        items: excursionCubit.state.fetch!.data!
                            .map(
                              (e) => DropdownMenuItem(
                                onTap: () {
                                  setState(() {
                                    excursions.add(e);
                                  });
                                },
                                value: e.id,
                                child: Text(
                                  e.name,
                                  style: AppText.l1,
                                ),
                              ),
                            )
                            .toList(),
                      );
                    }
                    return const SizedBox();
                  },
                ),
                if (excursions.isNotEmpty) ...[
                  Space.y!,
                  Wrap(
                    spacing: AppDimensions.normalize(5),
                    runSpacing: AppDimensions.normalize(5),
                    children: excursions
                        .map(
                          (e) => Chip(
                            backgroundColor: AppTheme.c!.primary,
                            label: Text(
                              e.name,
                              style: AppText.l2!.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            onDeleted: () {
                              setState(() {
                                excursions.remove(e);
                              });
                            },
                            deleteIcon: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: AppDimensions.normalize(6),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
                Space.y1!,
                Text(
                  'If this place is a popular place or not',
                  style: AppText.l2,
                ),
                FormBuilderCheckbox(
                  name: 'isPopular',
                  title: Text(
                    'Popular Place',
                    style: AppText.l1b,
                  ),
                ),
                Space.y1!,
                BlocConsumer<IslandsCubit, IslandsState>(
                  listener: (context, state) {
                    if (state.add is IslandAddSuccess ||
                        state.add is IslandAddFailed) {
                      imgProv.reset();
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    if (state.add is IslandAddLoading) {
                      return const LinearProgressIndicator();
                    }
                    return const SizedBox();
                  },
                ),
                Space.y!,
                AppButton(
                  child: Text(
                    'Add Island',
                    style: AppText.b2b!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    if (forms.addIslandState.currentState!.validate()) {
                      final fields = forms.addIslandState.currentState!.fields;

                      if (hotels.isEmpty) {
                        setState(() {
                          emptyHotel = true;
                        });
                      } else {
                        setState(() {
                          emptyHotel = false;
                        });

                        Island island = Island(
                          id: App.id(),
                          name: fields['name']!.value.toString().trim(),
                          address: fields['address']!.value.toString().trim(),
                          description:
                              fields['description']!.value.toString().trim(),
                          lat: double.parse(
                              fields['lat']!.value.toString().trim()),
                          lng: double.parse(
                              fields['lng']!.value.toString().trim()),
                          reviews: [],
                          images: [],
                          facilities: Facilities.fromMap(facilities),
                          isPopular: fields['isPopular']!.value ?? false,
                          hotels: hotels.map((e) => e.id).toList(),
                          divingDestinations: divings.map((e) => e.id).toList(),
                          excursions: excursions.map((e) => e.id).toList(),
                        );

                        IslandsCubit.c(context).add(island, imgProv.images);
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
