import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_app/core/helper/navigation_helper.dart';
import 'package:stylish_app/core/helper/status_bar_helper.dart';
import 'package:stylish_app/features/auth/view/login_view.dart';
import 'package:stylish_app/features/auth/view/register_view.dart';

import '../viewmodel/get_start_cubit.dart';
import '../widgets/get_start_actions.dart';

class GetStartView extends StatelessWidget {
  static const String routeName = '/getStart';
  const GetStartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StatusBarHelper.setTransparentStatusBar();
    return BlocProvider(
      create: (_) => GetStartCubit(),
      child: BlocBuilder<GetStartCubit, GetStartState>(
        builder: (context, state) {
          final cubit = context.read<GetStartCubit>();
          return Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
            body: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(cubit.slide.imagePath, fit: BoxFit.cover),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: GetStartActions(
                      onLogin: () {
                        cubit.completeGetStart();
                        NavigationHelper.pushAndRemoveUntilTo(
                          context,
                          const LoginView(),
                        );
                      },
                      onRegister: () {
                        cubit.completeGetStart();
                        NavigationHelper.pushAndRemoveUntilTo(
                          context,
                          const RegisterView(),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
