part of '../excursions.dart';

class _EditExcursionForm extends StatefulWidget {
  final Excursion excursion;
  final int index;
  const _EditExcursionForm({
    Key? key,
    required this.excursion,
    required this.index,
  }) : super(key: key);

  @override
  State<_EditExcursionForm> createState() => _EditExcursionFormState();
}

class _EditExcursionFormState extends State<_EditExcursionForm> {
  Map<String, bool> activities = {};
  List<String> imagesURLs = [];
  List<String> types = [];

  @override
  void initState() {
    types = widget.excursion.types;
    imagesURLs = widget.excursion.images;
    activities = widget.excursion.activities.toMap();
    super.initState();
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
            key: forms.editExcursionState,
            initialValue: {
              'name': widget.excursion.name,
              'address': widget.excursion.address,
              'description': widget.excursion.description,
              'isPopular': widget.excursion.isPopular,
              'lat': widget.excursion.lat.toString(),
              'lng': widget.excursion.lng.toString(),
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Edit ${widget.excursion.name}',
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
                  'Please update the following information',
                  style: AppText.l2,
                ),
                Space.y1!,
                Text(
                  'Destination Information',
                  style: AppText.b2b,
                ),
                Space.y!,
                CustomTextField(
                  name: 'name',
                  hint: 'Destination Name',
                  textInputType: TextInputType.name,
                  validatorFtn: FormBuilderValidators.required(
                    context,
                    errorText: 'Name cannot be empty',
                  ),
                ),
                Space.y!,
                CustomTextField(
                  name: 'address',
                  hint: 'Destination address',
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
                    if (imagesURLs.isNotEmpty)
                      ...imagesURLs.map(
                        (e) => Stack(
                          children: [
                            Container(
                              width: AppDimensions.normalize(50),
                              height: AppDimensions.normalize(50),
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: NetworkImage(e),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    imagesURLs.remove(e);
                                  });
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
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
                  'What types of divings are available at this destination',
                  style: AppText.l2,
                ),
                Space.y!,
                if (widget.excursion.types.isNotEmpty) ...[
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
                ],
                Space.y!,
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
                        String? value = forms.editExcursionState.currentState!
                            .fields['type']!.value;
                        if (value != null && value.toString().isNotEmpty) {
                          setState(() {
                            types.add(value.toString().trim());
                          });
                          forms.editExcursionState.currentState!.fields['type']!
                              .reset();
                        }
                      },
                      icon: const Icon(
                        Icons.add,
                      ),
                    ),
                  ],
                ),
                Space.y!,
                BlocConsumer<ExcursionCubit, ExcursionState>(
                  listener: (context, state) {
                    if (state.update is ExcursionUpdateSuccess ||
                        state.update is ExcursionUpdateSuccess) {
                      imgProv.reset();
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    if (state.update is ExcursionUpdateLoading) {
                      return const LinearProgressIndicator();
                    }
                    return const SizedBox();
                  },
                ),
                Space.y!,
                AppButton(
                  child: Text(
                    'Update Excursion',
                    style: AppText.b2b!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    if (forms.editExcursionState.currentState!.validate()) {
                      final fields =
                          forms.editExcursionState.currentState!.fields;

                      Excursion exc = Excursion(
                        id: widget.excursion.id,
                        name: fields['name']!.value.toString().trim(),
                        address: fields['address']!.value.toString().trim(),
                        description:
                            fields['description']!.value.toString().trim(),
                        lat: double.parse(
                            fields['lat']!.value.toString().trim()),
                        lng: double.parse(
                            fields['lng']!.value.toString().trim()),
                        types: types,
                        reviews: widget.excursion.reviews,
                        images: widget.excursion.images,
                        activities: Activities.fromMap(activities),
                        isPopular: fields['isPopular']!.value,
                        numberOfAdults: 0,
                      );

                      ExcursionCubit.c(context).update(
                        exc,
                        imgProv.images,
                        widget.index,
                      );
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
