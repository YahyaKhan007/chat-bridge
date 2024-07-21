import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class SpecialScreen extends StatelessWidget {
  const SpecialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('SpecialScreen', style: TextStyle(color: AppColors.kcDarkColor),),
      ),
    );
  }
}
