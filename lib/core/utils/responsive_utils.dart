import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

/// Responsive utility class for consistent sizing across the application
///
/// This class provides pre-defined responsive sizes based on flutter_screenutil
/// to ensure consistency throughout the app.
///
/// Design size: 402 x 874 (as defined in main.dart)
///
/// Usage:
/// ```dart
/// import 'package:icd_teacher/core/utils/responsive_utils.dart';
///
/// // Use pre-defined spacing
/// SizedBox(height: RS.spaceM); // 16.h
///
/// // Use direct extensions (already provided by flutter_screenutil)
/// SizedBox(height: 16.h);
/// Text('Hello', style: TextStyle(fontSize: 14.sp));
/// Container(width: 100.w, height: 50.h);
/// ```
class RS {
  RS._();

  // ============= SPACING =============

  /// Extra small spacing (4.0)
  static double get spaceXS => 4.0.h;

  /// Small spacing (8.0)
  static double get spaceS => 8.0.h;

  /// Medium spacing (16.0)
  static double get spaceM => 16.0.h;

  /// Large spacing (24.0)
  static double get spaceL => 24.0.h;

  /// Extra large spacing (32.0)
  static double get spaceXL => 32.0.h;

  /// Extra extra large spacing (48.0)
  static double get spaceXXL => 48.0.h;

  // ============= PADDING =============

  /// Standard horizontal padding for pages
  static EdgeInsets get pagePaddingH => EdgeInsets.symmetric(horizontal: 16.0.w);

  /// Standard vertical padding for pages
  static EdgeInsets get pagePaddingV => EdgeInsets.symmetric(vertical: 16.0.h);

  /// Standard padding for pages (both horizontal and vertical)
  static EdgeInsets get pagePadding => EdgeInsets.symmetric(
        horizontal: 16.0.w,
        vertical: 16.0.h,
      );

  /// Small padding (all sides 8)
  static EdgeInsets get paddingS => EdgeInsets.all(8.0.r);

  /// Medium padding (all sides 16)
  static EdgeInsets get paddingM => EdgeInsets.all(16.0.r);

  /// Large padding (all sides 24)
  static EdgeInsets get paddingL => EdgeInsets.all(24.0.r);

  // ============= FONT SIZES =============

  /// Extra small text (10sp)
  static double get textXS => 10.0.sp;

  /// Small text (12sp)
  static double get textS => 12.0.sp;

  /// Regular text (14sp)
  static double get textM => 14.0.sp;

  /// Medium large text (16sp)
  static double get textL => 16.0.sp;

  /// Large text (18sp)
  static double get textXL => 18.0.sp;

  /// Extra large text (20sp)
  static double get textXXL => 20.0.sp;

  /// Heading 1 (24sp)
  static double get heading1 => 24.0.sp;

  /// Heading 2 (22sp)
  static double get heading2 => 22.0.sp;

  /// Heading 3 (20sp)
  static double get heading3 => 20.0.sp;

  /// Button text size (18sp)
  static double get buttonText => 18.0.sp;

  // ============= BORDER RADIUS =============

  /// Small border radius (4)
  static double get radiusS => 4.0.r;

  /// Medium border radius (8)
  static double get radiusM => 8.0.r;

  /// Large border radius (12)
  static double get radiusL => 12.0.r;

  /// Extra large border radius (16)
  static double get radiusXL => 16.0.r;

  /// Circular border radius (for buttons, etc.)
  static BorderRadius get borderRadiusS => BorderRadius.circular(4.0.r);
  static BorderRadius get borderRadiusM => BorderRadius.circular(8.0.r);
  static BorderRadius get borderRadiusL => BorderRadius.circular(12.0.r);
  static BorderRadius get borderRadiusXL => BorderRadius.circular(16.0.r);

  // ============= ICON SIZES =============

  /// Small icon (16)
  static double get iconS => 16.0.r;

  /// Medium icon (24)
  static double get iconM => 24.0.r;

  /// Large icon (32)
  static double get iconL => 32.0.r;

  /// Extra large icon (48)
  static double get iconXL => 48.0.r;

  // ============= BUTTON SIZES =============

  /// Standard button height
  static double get buttonHeight => 48.0.h;

  /// Small button height
  static double get buttonHeightS => 36.0.h;

  /// Large button height
  static double get buttonHeightL => 56.0.h;

  /// Button padding
  static EdgeInsets get buttonPadding => EdgeInsets.symmetric(
        horizontal: 24.0.w,
        vertical: 12.0.h,
      );

  // ============= COMMON WIDGETS =============

  /// Vertical spacer - Extra Small
  static Widget get vSpaceXS => SizedBox(height: spaceXS);

  /// Vertical spacer - Small
  static Widget get vSpaceS => SizedBox(height: spaceS);

  /// Vertical spacer - Medium
  static Widget get vSpaceM => SizedBox(height: spaceM);

  /// Vertical spacer - Large
  static Widget get vSpaceL => SizedBox(height: spaceL);

  /// Vertical spacer - Extra Large
  static Widget get vSpaceXL => SizedBox(height: spaceXL);

  /// Vertical spacer - Extra Extra Large
  static Widget get vSpaceXXL => SizedBox(height: spaceXXL);

  /// Horizontal spacer - Extra Small
  static Widget get hSpaceXS => SizedBox(width: spaceXS);

  /// Horizontal spacer - Small
  static Widget get hSpaceS => SizedBox(width: spaceS);

  /// Horizontal spacer - Medium
  static Widget get hSpaceM => SizedBox(width: spaceM);

  /// Horizontal spacer - Large
  static Widget get hSpaceL => SizedBox(width: spaceL);

  /// Horizontal spacer - Extra Large
  static Widget get hSpaceXL => SizedBox(width: spaceXL);

  // ============= DIVIDERS =============

  /// Horizontal divider with standard thickness
  static Widget dividerH({Color? color}) => Divider(
        height: 1.0.h,
        thickness: 1.0.h,
        color: color,
      );

  /// Vertical divider with standard thickness
  static Widget dividerV({Color? color}) => VerticalDivider(
        width: 1.0.w,
        thickness: 1.0.w,
        color: color,
      );
}
