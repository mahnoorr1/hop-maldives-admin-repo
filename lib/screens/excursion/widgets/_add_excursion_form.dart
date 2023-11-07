part of '../excursions.dart';

class _AddExcursionForm extends StatefulWidget {
  const _AddExcursionForm({Key? key}) : super(key: key);

  @override
  State<_AddExcursionForm> createState() => _AddHotelFormState();
}

class _AddHotelFormState extends State<_AddExcursionForm> {
  Map<String, bool> activities = {};
  List<String> types = [];

  @override
  void initState() {
    super.initState();

    activities = Map.fromIterable(
      AppUtils.activities.map((e) => e),
      value: (value) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final forms = FormProvider.state(context);
    final imgProv = Provider.of<ImagePickerProvider>(context);

    return Material(
      color: Colors.transparent,
      child: Container(
        height: double.infinity,
        decoration: UIProps.boxCard,
        child: SingleChildScrollView(
          padding: Space.all(1),
          child: FormBuilder(
            key: forms.addExcursionState,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add New Excursion',
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
                  style: AppText.l2,
                ),
                Space.y1!,
                Text(
                  'Excursion Information',
                  style: AppText.b2b,
                ),
                Space.y!,
                CustomTextField(
                  name: 'name',
                  hint: 'Excursion Name',
                  textInputType: TextInputType.name,
                  validatorFtn: FormBuilderValidators.required(
                    context,
                    errorText: 'Name cannot be empty',
                  ),
                ),
                Space.y!,
                CustomTextField(
                  name: 'address',
                  hint: 'Excursion address',
                  textInputType: TextInputType.text,
                  validatorFtn: FormBuilderValidators.required(
                    context,
                    errorText: 'Location cannot be empty',
                  ),
                ),
                Space.y!,
                CustomMultiLineTextField(
                  name: 'description',
                  hint: 'Write what\'s special about this place...',
                  textInputAction: TextInputAction.newline,
                  validatorFtn: FormBuilderValidators.required(
                    context,
                    errorText: 'Description cannot be empty',
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
                    if (imgProv.images.length < 5)
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
                  'Activities Available',
                  style: AppText.b2b,
                ),
                Text(
                  'Mark all the activities available.',
                  style: AppText.l2,
                ),
                Space.y!,
                Wrap(
                  children: activities.entries
                      .map(
                        (e) => SizedBox(
                          width: AppDimensions.normalize(50),
                          child: FormBuilderCheckbox(
                            onChanged: (value) => setState(() {
                              activities[e.key] = value!;
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
                Text(
                  'Types Available',
                  style: AppText.b2b,
                ),
                Text(
                  'What types of excursions are available at this destination',
                  style: AppText.l2,
                ),
                Space.y!,
                if (types.isNotEmpty) ...[
                  Wrap(
                    spacing: AppDimensions.normalize(3),
                    runSpacing: AppDimensions.normalize(3),
                    children: types
                        .map(
                          (e) => Chip(
                            label: Text(e),
                            deleteIcon: const Icon(Icons.close),
                            onDeleted: () {
                              setState(() {
                                types.remove(e);
                              });
                            },
                          ),
                        )
                        .toList(),
                  ),
                  Space.y!,
                ],
                Row(
                  children: [
                    const Expanded(
                      child: CustomTextField(
                        name: 'type',
                        hint: 'Type name',
                        textInputType: TextInputType.name,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        String? value = forms
                            .addExcursionState.currentState!.fields['type']!.value;
                        if (value != null && value.toString().isNotEmpty) {
                          setState(() {
                            types.add(value.toString().trim());
                          });
                          forms.addExcursionState.currentState!.fields['type']!
                              .reset();
                        }
                      },
                      icon: const Icon(
                        Icons.add,
                      ),
                    ),
                  ],
                ),
                Space.y1!,
                BlocConsumer<ExcursionCubit, ExcursionState>(
                  listener: (context, state) {
                    if (state.add is ExcursionAddSuccess ||
                        state.add is ExcursionAddFailed) {
                      imgProv.reset();
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    if (state.add is ExcursionAddLoading) {
                      return const LinearProgressIndicator();
                    }
                    return const SizedBox();
                  },
                ),
                Space.y!,
                AppButton(
                  child: Text(
                    'Add Excursion',
                    style: AppText.b2b!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    if (forms.addExcursionState.currentState!.validate()) {
                      final fields = forms.addExcursionState.currentState!.fields;

                      Excursion exc = Excursion(
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
                        activities: Activities.fromMap(activities),
                        isPopular: fields['isPopular']!.value ?? false,
                       
                        types: types,
                        numberOfAdults: 0,
                      );

                      ExcursionCubit.c(context).add(exc, imgProv.images);
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
