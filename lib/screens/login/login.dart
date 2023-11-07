import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hop_maldives_admin/app_routes.dart';
import 'package:hop_maldives_admin/configs/app.dart';
import 'package:hop_maldives_admin/configs/configs.dart';
import 'package:hop_maldives_admin/cubits/auth/cubit.dart';
import 'package:hop_maldives_admin/providers/form_provider.dart';
import 'package:hop_maldives_admin/utils/utils.dart';
import 'package:hop_maldives_admin/widgets/app_button.dart';
import 'package:hop_maldives_admin/widgets/text_fields/custom_text_field.dart';
import 'package:hop_maldives_admin/widgets/overlay_snackbars/overlay_snackbars.dart';
import 'package:hop_maldives_admin/widgets/screen/screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool invalidUser = false;

  @override
  Widget build(BuildContext context) {
    App.init(context);

    final forms = FormProvider.state(context);

    return Screen(
      overlaySnackbar: [
        if (invalidUser)
          const OverlaySnackbar(
            message: 'Invalid admin credentials. Please try again!',
            success: false,
          ),
        BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthLoginSuccess) {
              Navigator.pushNamed(context, AppRoutes.dashboard);
            }
          },
          builder: (context, state) {
            if (state is AuthLoginFailed) {
              return OverlaySnackbar(
                message: state.message!,
                success: false,
              );
            }
            return Container();
          },
        )
      ],
      child: Scaffold(
        body: Center(
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Image.asset(
                  StaticAssets.fullLogo,
                ),
              ),
              Space.xf(2),
              Expanded(
                child: Container(
                  height: AppDimensions.normalize(200),
                  decoration: UIProps.boxCard,
                  padding: Space.all(1.5, 2),
                  child: FormBuilder(
                    key: forms.loginFormState,
                    initialValue: const {
                      'email': 'admin@hopmaldives.com',
                      'password': 'admin123',
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Admin Login',
                          style: AppText.h1b,
                        ),
                        Space.y!,
                        Text(
                          'Enter the admin credentials as following:',
                          style: AppText.b2,
                        ),
                        Space.y2!,
                        CustomTextField(
                          name: 'email',
                          hint: 'Enter email address',
                          prefixIcon: const Icon(
                            CommunityMaterialIcons.email,
                          ),
                          textInputType: TextInputType.emailAddress,
                          validatorFtn: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                              context,
                              errorText: 'Email is required',
                            ),
                            FormBuilderValidators.email(
                              context,
                              errorText: 'Invalid email format',
                            ),
                          ]),
                        ),
                        Space.y1!,
                        CustomTextField(
                          name: 'password',
                          hint: 'Enter password',
                          prefixIcon: const Icon(
                            CommunityMaterialIcons.lock,
                          ),
                          textInputType: TextInputType.text,
                          isPass: true,
                          validatorFtn: FormBuilderValidators.required(
                            context,
                            errorText: 'Password is required',
                          ),
                        ),
                        Space.y1!,
                        AppButton(
                          child: BlocBuilder<AuthCubit, AuthState>(
                            builder: (context, state) {
                              if (state is AuthLoginLoading) {
                                return AppUtils.loader(Colors.white);
                              }
                              return Text(
                                'Login',
                                style: AppText.b1!.copyWith(
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                          onPressed: () {
                            if (forms.loginFormState.currentState!.validate()) {
                              String email = forms.loginFormState.currentState!
                                  .fields['email']!.value
                                  .toString()
                                  .trim();

                              String password = forms.loginFormState
                                  .currentState!.fields['password']!.value
                                  .toString()
                                  .trim();

                              if (email.contains('admin@hopmaldives.com') ||
                                  password.contains('admin123')) {
                                AuthCubit.cubit(context).login(email, password);
                              } else {
                                setState(() {
                                  invalidUser = true;
                                });
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Space.xf(10),
            ],
          ),
        ),
      ),
    );
  }
}
