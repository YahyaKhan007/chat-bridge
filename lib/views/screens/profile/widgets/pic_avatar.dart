import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget picAvatar({required Size size}) {
  return CircleAvatar(
    radius: 50.r,
    backgroundImage: const NetworkImage(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRS2NzkYeMmu4mFeDeu4YBeFehLXSzdXU8wag&s'),
  );
}
