import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'image_view.dart';

Widget buildExpandedContainer({
  required String icon,
  required String text,
  required Color backgroundColor,
  required Color borderColor,
  required Color textColor,
}) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: borderColor,
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          ImageView(
            image: icon,
            imageType: ImageType.svg,
          ),
          SizedBox(width: 12.w),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontStyle: FontStyle.normal,
              fontFamily: "Inter",
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    ),
  );
}