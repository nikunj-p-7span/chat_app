import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    this.buttonState = ButtonState.normal,
    this.progressColor = Colors.white,
    this.child,
    this.color,
    this.textColor,
    this.elevation,
    this.radius,
    this.borderColor,
    this.customHeight,
    this.customWidth,
  });

  /// Callback when this button is pressed
  final Function? onPressed;

  /// State of the button.
  ///
  /// Defaults to [ButtonState.normal]
  final ButtonState buttonState;

  /// Child of the button to show when the
  /// state is [ButtonState.normal]
  final Widget? child;

  /// Color for [CircularProgressIndicator] which will be shown
  /// when state is [ButtonState.inProgress]
  ///
  /// Defaults to [Colors.white]
  final Color progressColor;

  /// Color of the button
  final Color? color;

  /// Text color
  final Color? textColor;

  /// Elevation
  final double? elevation;

  /// radius
  final double? radius;

  /// Color of the border
  final Color? borderColor;

  /// Height
  final double? customHeight;

  /// width
  final double? customWidth;

  @override
  Widget build(BuildContext context) {
    // Get the default radius if it's not done yet
    final defaultRadius = _getDefaultRadius(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final height = customHeight ?? 70;
        final padding = Theme.of(context).buttonTheme.padding;
        final width = customWidth ?? constraints.maxWidth;

        // When in progress mode, we want to convert the button
        // to circle so the height and width should be same
        final widthToSet = buttonState == ButtonState.normal ? width : height;

        // Set the radius to the half of the height in order to
        // convert the button to circle when in progress mode
        final radiusToSet =
        buttonState == ButtonState.normal ? defaultRadius : height / 2;

        // Remove the padding when in the progress mode
        final paddingToSet =
        buttonState == ButtonState.normal ? padding : EdgeInsets.zero;

        // Show progress bar when in the progress mode instead
        // of actual child of this button
        final childToSet = buttonState == ButtonState.normal
            ? child
            : SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(progressColor),
          ),
        );

        return AnimatedContainer(
          width: widthToSet,
          height: height,
          duration: const Duration(
            milliseconds: 300,
          ),
          curve: Curves.linearToEaseOut,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.transparent,
              side: BorderSide(
                color: borderColor ?? Colors.transparent,
                width: 0.5,
              ),
              backgroundColor: color ?? Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radiusToSet),
              ),
              padding: paddingToSet,
              //  textStyle: TextStyle(color: textColor, fontWeight: FontWeight.w500),
              elevation: elevation ?? 0,
            ),
            onPressed: onPressed as void Function()?,
            child: childToSet,
          ),
        );
      },
    );
    //return getErrorAnimatedBuilder();
  }

  double _getDefaultRadius(BuildContext context) {
    final shape = Theme.of(context).buttonTheme.shape;
    if (shape is RoundedRectangleBorder) {
      final borderRadius = shape.borderRadius;
      if (borderRadius is BorderRadius) return radius ?? 4;
    }

    return 0;
  }
}

enum ButtonState {
  /// Indicates the button is showing in progress
  inProgress,

  /// Indicates the normal state
  normal,
}
