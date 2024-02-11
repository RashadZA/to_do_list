import 'package:flutter/material.dart';
import 'package:to_do_list/core/utils/design_utils.dart';

class Unknown404Screen extends StatelessWidget {
  const Unknown404Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryShadowColor,
      body: Center(
        child: Text(
          '404',
          style: AppTextTheme.text18,
        ).defaultContainer(),
      ),
    );
  }
}