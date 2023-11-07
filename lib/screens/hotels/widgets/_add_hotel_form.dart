part of '../hotels.dart';

class _AddHotelForm extends StatefulWidget {
  const _AddHotelForm({Key? key}) : super(key: key);

  @override
  State<_AddHotelForm> createState() => _AddHotelFormState();
}

class _AddHotelFormState extends State<_AddHotelForm> {
  Map<String, bool> facilities = {};

  @override
  void initState() {
    super.initState();

    facilities = Map.fromIterable(
      AppUtils.facilities.map(
        (e) => e,
      ),
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
            key: forms.addHotelState,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add New Hotel',
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
                  'Hotel Information',
                  style: AppText.b2b,
                ),
                Space.y!,
                CustomTextField(
                  name: 'name',
                  hint: 'Hotel Name',
                  textInputType: TextInputType.name,
                  validatorFtn: FormBuilderValidators.required(
                    context,
                    errorText: 'Name cannot be empty',
                  ),
                ),
                Space.y!,
                CustomTextField(
                  name: 'address',
                  hint: 'Hotel address',
                  textInputType: TextInputType.text,
                  validatorFtn: FormBuilderValidators.required(
                    context,
                    errorText: 'Location cannot be empty',
                  ),
                ),
                Space.y!,
                CustomMultiLineTextField(
                  name: 'description',
                  hint: 'Write what\'s special about this hotel...',
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
                  'Facilities Available',
                  style: AppText.b2b,
                ),
                Text(
                  'Mark all the facilities available.',
                  style: AppText.l2,
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
                  'Charges Per Night',
                  style: AppText.b2b,
                ),
                Text(
                  'This will be calculated based on number of days the customer will check-in and out',
                  style: AppText.l2,
                ),
                Space.y!,
                CustomTextField(
                  name: 'price',
                  hint: 'Per Night charges (\$)',
                  textInputType: TextInputType.name,
                  validatorFtn: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(
                        context,
                        errorText: 'Price cannot be empty',
                      ),
                      FormBuilderValidators.numeric(
                        context,
                        errorText: 'Price can only be number',
                      ),
                    ],
                  ),
                ),
                Space.y1!,
                Text(
                  'Inclusive Charges',
                  style: AppText.b2b,
                ),
                Text(
                  'These charges will be added in the total price',
                  style: AppText.l2,
                ),
                Space.y!,
                CustomTextField(
                  name: 'charges',
                  hint: 'Inclusive charges (\$)',
                  textInputType: TextInputType.name,
                  validatorFtn: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(
                        context,
                        errorText: 'Charges cannot be empty',
                      ),
                      FormBuilderValidators.numeric(
                        context,
                        errorText: 'Charges can only be number',
                      ),
                    ],
                  ),
                ),
                Space.y!,
                BlocConsumer<HotelsCubit, HotelsState>(
                  listener: (context, state) {
                    if (state.add is HotelAddSuccess ||
                        state.add is HotelAddFailed) {
                      imgProv.reset();
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    if (state.add is HotelAddLoading) {
                      return const LinearProgressIndicator();
                    }
                    return const SizedBox();
                  },
                ),
                Space.y!,
                AppButton(
                  child: Text(
                    'Add Hotel',
                    style: AppText.b2b!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    if (forms.addHotelState.currentState!.validate()) {
                      final fields = forms.addHotelState.currentState!.fields;

                      Hotel hotel = Hotel(
                        id: App.id(),
                        name: fields['name']!.value.toString().trim(),
                        address: fields['address']!.value.toString().trim(),
                        description:
                            fields['description']!.value.toString().trim(),
                        lat: double.parse(
                            fields['lat']!.value.toString().trim()),
                        lng: double.parse(
                            fields['lng']!.value.toString().trim()),
                        perNightPrice: double.parse(
                            fields['price']!.value.toString().trim()),
                        reviews: [],
                        images: [],
                        facilities: Facilities.fromMap(facilities),
                        isPopular: fields['isPopular']!.value ?? false,
                        inclusiveCharges: double.parse(
                          fields['charges']!.value.toString().trim(),
                        ),
                      );

                      HotelsCubit.c(context).add(hotel, imgProv.images);
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
