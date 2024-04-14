import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';

class Custom3 {
  static details(BuildContext context,
      {required String title, required String detail}) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          child: SizedBox(
              width: MediaQuery.of(context).size.width * .36,
              child: Text(title, style: TextStyling.subtitle2)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width * .5,
                child: Text(detail, style: TextStyling.details)),
          ],
        ),
      ],
    );
  }
}
