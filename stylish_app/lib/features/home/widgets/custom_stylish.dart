import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/assets_app.dart';

class CustomStylish extends StatelessWidget {
  const CustomStylish({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 39,
          height: 31,
          child: SvgPicture.asset(AssetsApp.icons.logo.path, fit: BoxFit.fill),
        ),
        Text(
          'Stylish',
          style: TextStyle(
            fontFamily: 'LibreCaslon',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xff4392F9),
          ),
        ),
      ],
    );
  }
}
