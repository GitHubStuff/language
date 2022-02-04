import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'language.dart';

typedef _ContextWidget = Widget Function(BuildContext context);
typedef _ContextFreeWidget = Widget Function();

mixin LocaleMixin {
  Widget rebuidTreeOnLocaleChange({required dynamic child}) {
    assert(child is _ContextWidget || child is _ContextFreeWidget);
    return BlocBuilder(
        bloc: Language.cubit,
        builder: (context, _) {
          if (child is _ContextWidget) return child(context);
          if (child is _ContextFreeWidget) return child();
          throw FlutterError('Unknown child type: ${child.toString()}');
        });
  }
}
