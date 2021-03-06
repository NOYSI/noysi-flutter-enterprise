import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef void OnWidgetSizeChange(Size size);

class TXMeasureSizeRenderObject extends RenderProxyBox {
  Size? oldSize;
  final OnWidgetSizeChange onChange;

  TXMeasureSizeRenderObject(this.onChange);

  @override
  void performLayout() {
    super.performLayout();

    Size? newSize = child?.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onChange(newSize!);
    });
  }
}

class TXMeasureChildSize extends SingleChildRenderObjectWidget {
  final OnWidgetSizeChange onChange;

  const TXMeasureChildSize({
    Key? key,
    required this.onChange,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return TXMeasureSizeRenderObject(onChange);
  }
}
