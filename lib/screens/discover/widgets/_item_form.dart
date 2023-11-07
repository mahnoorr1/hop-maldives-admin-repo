part of '../discover.dart';

class _ItemForm extends StatefulWidget {
  const _ItemForm({Key? key}) : super(key: key);

  @override
  State<_ItemForm> createState() => _ItemFormState();
}

class _ItemFormState extends State<_ItemForm> {
  @override
  Widget build(BuildContext context) {
    final forms = FormProvider.state(context);
    final imgPicker = Provider.of<ImagePickerProvider>(context);
    final discoverCubit = DiscoverCubit.c(context);

    return Material(
      color: Colors.transparent,
      child: Container(
        height: double.infinity,
        decoration: UIProps.boxCard,
        child: SingleChildScrollView(
          padding: Space.all(1),
          child: FormBuilder(
            key: forms.discoverFormState,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add New Item',
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
                const Text('Select the image to upload'),
                Space.y!,
                // FormBuilderRadioGroup(
                //   initialValue: 'Image',
                //   decoration: const InputDecoration(
                //     border: InputBorder.none,
                //   ),
                //   name: 'type',
                //   options: ['Image', 'Video']
                //       .map(
                //         (e) => FormBuilderFieldOption<String>(
                //           value: e,
                //           child: Text(e),
                //         ),
                //       )
                //       .toList(),
                // ),
                // Space.y!,
                if (imgPicker.file != null)
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: AppDimensions.normalize(150),
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(
                              imgPicker.file!.path,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: AppIconButton(
                          onPressed: () => imgPicker.reset(),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      )
                    ],
                  ),
                if (imgPicker.file == null)
                  InkWell(
                    onTap: () => imgPicker.pickImage(),
                    child: Container(
                      height: AppDimensions.normalize(150),
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.add_a_photo,
                          color: Colors.white,
                          size: AppDimensions.normalize(25),
                        ),
                      ),
                    ),
                  ),
                Space.y!,
                Text(
                  'Description',
                  style: AppText.b1b,
                ),
                Space.y!,
                CustomMultiLineTextField(
                  name: 'description',
                  hint: 'Enter some description...',
                  validatorFtn: FormBuilderValidators.required(
                    context,
                    errorText: 'Description cannot be empty!',
                  ),
                ),
                Space.y!,
                BlocConsumer<DiscoverCubit, DiscoverState>(
                  listener: (context, state) {
                    if (state.add is DiscoverAddSuccess) {
                      imgPicker.reset();
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    if (state.add is DiscoverAddLoading) {
                      return const LinearProgressIndicator();
                    }
                    return const SizedBox();
                  },
                ),
                Space.y!,
                AppButton(
                  child: Text(
                    'Add Item',
                    style: AppText.b2b!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    if (forms.discoverFormState.currentState!.validate()) {
                      String desc = forms.discoverFormState.currentState!
                          .fields['description']!.value
                          .toString()
                          .trim();

                      discoverCubit.add(
                        desc,
                        imgPicker.file!,
                      );
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
