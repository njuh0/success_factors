import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class FloatingModal extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final Widget? backgroundWidget;

  const FloatingModal(
      {Key? key,
      required this.child,
      this.backgroundColor,
      Widget? backgroundWidget})
      : backgroundWidget = backgroundWidget ?? const SizedBox(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
        child: Material(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Positioned.fill(
                child: backgroundWidget!,
              ),
              child
            ],
          ),
        ),
      ),
    );
  }
}

Future<T> showFloatingModalBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  Widget? backgroundWidget,
  Color? backgroundColor,
}) async {
  final result = await showCustomModalBottomSheet(
      context: context,
      builder: builder,
      containerWidget: (_, animation, child) => FloatingModal(
            backgroundWidget: backgroundWidget,
            backgroundColor: backgroundColor,
            child: child,
          ),
      expand: false);

  return result;
}
