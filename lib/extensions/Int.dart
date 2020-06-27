import 'package:flutter_screenutil/flutter_screenutil.dart';

extension UIScale on int {
  double dp() => ScreenUtil.pixelRatio * this;
}
