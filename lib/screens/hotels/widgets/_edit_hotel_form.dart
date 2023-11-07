part of '../hotels.dart';

class _EditHotelForm extends StatefulWidget {
  final Hotel hotel;
  final int index;
  const _EditHotelForm({
    Key? key,
    required this.hotel,
    required this.index,
  }) : super(key: key);

  @override
  State<_EditHotelForm> createState() => _EditHotelFormState();
}

class _EditHotelFormState extends State<_EditHotelForm> {
  Map<String, bool> facilities = {};
  List<String> imagesURLs = [];

  @override
  void initState() {
    imagesURLs = widget.hotel.images;
    facilities = widget.hotel.facilities.toMap();
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
            key: forms.editHotelState,
            initialValue: {
              'name': widget.hotel.name,
              'address': widget.hotel.address,
              'description': widget.hotel.description,
              'isPopular': widget.hotel.isPopular,
              'lat': widget.hotel.lat.toString(),
              'lng': widget.hotel.lng.toString(),
              'price': widget.hotel.perNightPrice.toString(),
              'charges': widget.hotel.inclusiveCharges.toString(),
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Edit ${widget.hotel.name}',
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
                Space.y!,
                BlocConsumer<HotelsCubit, HotelsState>(
                  listener: (context, state) {
                    if (state.update is HotelUpdateSuccess ||
                        state.update is HotelUpdateSuccess) {
                      imgProv.reset();
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    if (state.update is HotelUpdateLoading) {
                      return const LinearProgressIndicator();
                    }
                    return const SizedBox();
                  },
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
                AppButton(
                  child: Text(
                    'Update Hotel',
                    style: AppText.b2b!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    if (forms.editHotelState.currentState!.validate()) {
                      final fields = forms.editHotelState.currentState!.fields;

                      Hotel hotel = Hotel(
                        id: widget.hotel.id,
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
                        reviews: widget.hotel.reviews,
                        images: widget.hotel.images,
                        facilities: Facilities.fromMap(facilities),
                        isPopular: fields['isPopular']!.value,
                        inclusiveCharges: double.parse(
                            fields['charges']!.value.toString().trim()),
                      );

                      HotelsCubit.c(context).update(
                        hotel,
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
