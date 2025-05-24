import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:stylish_app/core/constants/assets_app.dart';
import 'package:stylish_app/core/constants/colors_app.dart';
import 'package:stylish_app/core/constants/text_styles_app.dart';
import 'package:stylish_app/core/helper/my_responsive.dart';
import 'package:stylish_app/core/helper/status_bar_helper.dart';
import 'package:stylish_app/features/home/view/home_view.dart';

import '../../../config/cache/cache_helper.dart';
import '../../../config/cache/cache_keys.dart';
import '../../../config/localisation/translations_keys.dart';
import '../../../core/helper/navigation_helper.dart';
import '../../../core/network/api_client.dart';
import '../repository/auth_repository.dart';
import '../viewmodel/login_cubit.dart';
import '../widgets/auth_text_field.dart';

class LoginView extends StatefulWidget {
  static const String routeName = '/login';
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StatusBarHelper.setTransparentStatusBar();
    return BlocProvider(
      create:
          (_) => LoginCubit(repository: AuthRepository(apiClient: ApiClient())),
      child: Builder(
        builder:
            (context) => BlocListener<LoginCubit, LoginState>(
              listener: (context, state) async {
                print('Login state changed: $state');
                if (state is LoginLoading) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder:
                        (_) => const Center(child: CircularProgressIndicator()),
                  );
                } else {
                  if (Navigator.canPop(context)) Navigator.pop(context);
                }
                if (state is LoginSuccess) {
                  print('LoginSuccess, saving token and navigating...');
                  try {
                    await CacheHelper.saveData(
                      key: CacheKeys.userToken,
                      value: state.response.token,
                    );
                    await CacheHelper.saveData(
                      key: 'user_email',
                      value: _emailController.text.trim(),
                    );
                    print('Data saved, navigating to HomeView');
                    NavigationHelper.pushAndRemoveUntilTo(
                      context,
                      const HomeView(),
                    );
                  } catch (e) {
                    print('Error saving cache: $e');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('خطأ في حفظ البيانات: $e')),
                    );
                  }
                } else if (state is LoginError) {
                  print('LoginError: ${state.message}');
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                  showDialog(
                    context: context,
                    builder:
                        (ctx) => AlertDialog(
                          title: const Text('خطأ في تسجيل الدخول'),
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
                body: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MyResponsive.width(context, value: 29),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MyResponsive.height(context, value: 60),
                          ),
                          Text(
                            'Welcome back',
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                              fontSize: 36,
                              height: 43 / 36,
                              letterSpacing: 0.0,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: MyResponsive.height(context, value: 40),
                          ),
                          AuthTextField(
                            controller: _emailController,
                            hintText: TranslationsKeys.email.tr,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: AssetsApp.icons.email.svg(
                                width: 24,
                                height: 24,
                              ),
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
                          SizedBox(
                            height: MyResponsive.height(context, value: 24),
                          ),
                          AuthTextField(
                            controller: _passwordController,
                            hintText: TranslationsKeys.password.tr,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: AssetsApp.icons.lock.svg(
                                width: 24,
                                height: 24,
                              ),
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
                          SizedBox(
                            height: MyResponsive.height(context, value: 40),
                          ),
                          SizedBox(
                            width: MyResponsive.width(context, value: 317),
                            height: MyResponsive.height(context, value: 55),
                            child: ElevatedButton(
                              onPressed: () {
                                print('Login button pressed');
                                if (_formKey.currentState!.validate()) {
                                  print(
                                    'Form validated, calling login with email: ${_emailController.text}',
                                  );
                                  context.read<LoginCubit>().login(
                                    _emailController.text.trim(),
                                    _passwordController.text.trim(),
                                  );
                                } else {
                                  print('Form validation failed');
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
                                'Login',
                                style: TextStylesApp.getStartButton.copyWith(
                                  color: ColorsApp.textColorLight,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MyResponsive.height(context, value: 24),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  color: ColorsApp.sconedTextColor,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(
                                    context,
                                  ).pushReplacementNamed('/register');
                                },
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                    color: ColorsApp.primaryColor,
                                  ),
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
      ),
    );
  }
}
