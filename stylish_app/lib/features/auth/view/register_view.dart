import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:stylish_app/core/constants/colors_app.dart';
import 'package:stylish_app/core/constants/text_styles_app.dart';
import 'package:stylish_app/core/helper/my_responsive.dart';

import '../../../config/cache/cache_helper.dart';
import '../../../config/cache/cache_keys.dart';
import '../../../config/localisation/translations_keys.dart';
import '../../../core/constants/assets_app.dart';
import '../../../core/helper/navigation_helper.dart';
import '../../../core/network/api_client.dart';
import '../../home/view/home_view.dart';
import '../repository/auth_repository.dart';
import '../viewmodel/register_cubit.dart';
import '../widgets/auth_text_field.dart';

class RegisterView extends StatefulWidget {
  static const String routeName = '/register';
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              RegisterCubit(repository: AuthRepository(apiClient: ApiClient())),
      child: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) async {
          if (state is RegisterLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(child: CircularProgressIndicator()),
            );
          } else {
            if (Navigator.canPop(context)) Navigator.pop(context);
          }
          if (state is RegisterSuccess) {
            await CacheHelper.saveData(
              key: CacheKeys.userToken,
              value: state.response.token,
            );
            await CacheHelper.saveData(
              key: 'user_email',
              value: _emailController.text.trim(),
            );
            await CacheHelper.saveData(
              key: 'user_name',
              value: _nameController.text.trim(),
            );
            NavigationHelper.pushAndRemoveUntilTo(context, const HomeView());
          } else if (state is RegisterError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
            showDialog(
              context: context,
              builder:
                  (ctx) => AlertDialog(
                    title: const Text('خطأ في التسجيل'),
                    content: Text(state.message),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: const Text('حسناً'),
                      ),
                    ],
                  ),
            );
          }
        },
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MyResponsive.width(context, value: 29),
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MyResponsive.height(context, value: 60)),
                    Text(
                      'Create Account',
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 36,
                        height: 43 / 36,
                        letterSpacing: 0.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: MyResponsive.height(context, value: 40)),
                    AuthTextField(
                      controller: _nameController,
                      hintText: TranslationsKeys.fullName.tr,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: AssetsApp.icons.user.svg(width: 24, height: 24),
                      ),
                      suffixIcon: Icon(
                        Icons.check,
                        color: ColorsApp.primaryColor,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال الاسم';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: MyResponsive.height(context, value: 24)),
                    AuthTextField(
                      controller: _emailController,
                      hintText: TranslationsKeys.email.tr,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: AssetsApp.icons.email.svg(width: 24, height: 24),
                      ),
                      suffixIcon: Icon(
                        Icons.check,
                        color: ColorsApp.primaryColor,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال البريد الإلكتروني';
                        }
                        if (!value.contains('@')) {
                          return 'البريد الإلكتروني غير صالح';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: MyResponsive.height(context, value: 24)),
                    AuthTextField(
                      controller: _passwordController,
                      hintText: TranslationsKeys.password.tr,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: AssetsApp.icons.lock.svg(width: 24, height: 24),
                      ),
                      suffixIcon: Icon(
                        Icons.visibility_off,
                        color: ColorsApp.sconedTextColor,
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال كلمة المرور';
                        }
                        if (value.length < 6) {
                          return 'كلمة المرور قصيرة جداً';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: MyResponsive.height(context, value: 24)),
                    AuthTextField(
                      controller: _confirmPasswordController,
                      hintText: TranslationsKeys.confirmPassword.tr,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: AssetsApp.icons.lock.svg(width: 24, height: 24),
                      ),
                      suffixIcon: Icon(
                        Icons.visibility_off,
                        color: ColorsApp.sconedTextColor,
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى تأكيد كلمة المرور';
                        }
                        if (value != _passwordController.text) {
                          return 'كلمتا المرور غير متطابقتين';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: MyResponsive.height(context, value: 40)),
                    SizedBox(
                      width: MyResponsive.width(context, value: 317),
                      height: MyResponsive.height(context, value: 55),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<RegisterCubit>().register(
                              _nameController.text.trim(),
                              _emailController.text.trim(),
                              _passwordController.text.trim(),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsApp.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 21,
                            horizontal: 109,
                          ),
                        ),
                        child: Text(
                          'Register',
                          style: TextStylesApp.getStartButton.copyWith(
                            color: ColorsApp.textColorLight,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MyResponsive.height(context, value: 24)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(color: ColorsApp.sconedTextColor),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(
                              context,
                            ).pushReplacementNamed('/login');
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(color: ColorsApp.primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
