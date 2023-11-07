part of '../tours.dart';

class _EditTourForm extends StatefulWidget {
  final Tour tour;
  const _EditTourForm({
    Key? key,
    required this.tour,
  }) : super(key: key);

  @override
  State<_EditTourForm> createState() => _EditTourFormState();
}

class _EditTourFormState extends State<_EditTourForm> {
  List<String> imagesURLs = [];

  @override
  void initState() {
    imagesURLs = widget.tour.images;
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
            key: forms.editTourState,
            initialValue: {
              'name': widget.tour.name,
              'place': widget.tour.place,
              'description': widget.tour.description,
              'policy': widget.tour.policy,
              'deadline': widget.tour.deadline,
              'price': widget.tour.price.toString(),
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Update ${widget.tour.name}',
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
                  'Tour Information',
                  style: AppText.b2b,
                ),
                Space.y!,
                CustomTextField(
                  name: 'name',
                  hint: 'Package Name',
                  textInputType: TextInputType.name,
                  validatorFtn: FormBuilderValidators.required(
                    context,
                    errorText: 'Title cannot be empty',
                  ),
                ),
                Space.y!,
                BlocConsumer<TourCubit, TourState>(
                  listener: (context, state) {
                    if (state.add is TourAddSuccess ||
                        state.add is TourAddFailed) {
                      imgProv.reset();
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    if (state.add is TourAddLoading) {
                      return const LinearProgressIndicator();
                    }
                    return const SizedBox();
                  },
                ),
                Space.y!,
                CustomTextField(
                  name: 'place',
                  hint: 'Enter place name',
                  textInputType: TextInputType.name,
                  validatorFtn: FormBuilderValidators.required(
                    context,
                    errorText: 'Place cannot be empty',
                  ),
                ),
                Space.y!,
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
                Space.y!,
                Text(
                  'Tour description',
                  style: AppText.b2b,
                ),
                Text(
                  'Add all the required stuff, important dates, what is included in the tour etc.',
                  style: AppText.l2,
                ),
                Space.y!,
                CustomMultiLineTextField(
                  name: 'description',
                  hint: 'What this tour is all about...',
                  validatorFtn: FormBuilderValidators.required(context),
                ),
                Space.y!,
                Space.y!,
                Text(
                  'Terms & Policy of Tour',
                  style: AppText.b2b,
                ),
                Text(
                  'This includes the cancellation policies and terms regarding the tour',
                  style: AppText.l2,
                ),
                Space.y!,
                CustomMultiLineTextField(
                  name: 'policy',
                  hint: 'Enter Terms & Policies regarding this tour...',
                  validatorFtn: FormBuilderValidators.required(context),
                ),
                Space.y!,
                Text(
                  'Deadline',
                  style: AppText.l2b,
                ),
                Text(
                  'Last date before anyone can send request for this tour',
                  style: AppText.l2,
                ),
                Space.y!,
                CustomDateTextField(
                  name: 'deadline',
                  hint: 'Deadline date',
                  validatorFtn: FormBuilderValidators.required(
                    context,
                    errorText: 'Deadline date cannot be empty',
                  ),
                ),
                Space.y!,
                Text(
                  'Price/Charges',
                  style: AppText.b2b,
                ),
                Space.y!,
                CustomTextField(
                  name: 'price',
                  hint: '\$2,500',
                  textInputType: TextInputType.number,
                  validatorFtn: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      context,
                      errorText: 'Price cannot be empty',
                    ),
                    FormBuilderValidators.numeric(
                      context,
                      errorText: 'Price must some numbers',
                    )
                  ]),
                ),
                Space.y!,
                BlocConsumer<TourCubit, TourState>(
                  listener: (context, state) {
                    if (state.update is TourUpdateSuccess ||
                        state.update is TourUpdateFailed) {
                      imgProv.reset();
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    if (state.update is TourUpdateLoading) {
                      return const LinearProgressIndicator();
                    }
                    return const SizedBox();
                  },
                ),
                Space.y!,
                AppButton(
                  child: Text(
                    'Update Tour',
                    style: AppText.b2b!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    if (forms.editTourState.currentState!.validate()) {
                      final fields = forms.editTourState.currentState!.fields;

                      Tour tour = Tour(
                        id: widget.tour.id,
                        name: fields['name']!.value.toString().trim(),
                        place: fields['place']!.value.toString().trim(),
                        deadline: fields['deadline']!.value,
                        price: double.parse(fields['price']!.value.toString()),
                        policy: fields['policy']!.value.toString().trim(),
                        images: imagesURLs,
                        description:
                            fields['description']!.value.toString().trim(),
                        reviews: widget.tour.reviews,
                      );

                      TourCubit.c(context).update(tour, imgProv.images);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
