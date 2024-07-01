import 'dart:async';

import 'package:flutter/material.dart';
import 'package:new_store/theme/collections/colorCollection.dart';

class AppFilledButton extends StatefulWidget {
  final FutureOr<void> Function()? onTap;
  final String text;
  final bool isLoading;

  const AppFilledButton({
    super.key,
    required this.onTap,
    required this.text,required this.isLoading,
  });

  @override
  State<AppFilledButton> createState() => _AppFilledButtonState();
}

class _AppFilledButtonState extends State<AppFilledButton> {
  double? _childHeight;

  final _childBoxKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => setState(
        () => _childHeight = _childBoxKey.currentContext?.size?.height));
  }



  

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: FilledButton(
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 18),
              shadowColor: Colors.amber.withOpacity(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 0.0,
              disabledBackgroundColor:
                  ColorCollection.primary.withOpacity(0.12),
              backgroundColor: ColorCollection.primary,
            ),
            onPressed: !widget.isLoading ? widget.onTap : null,
            child: SizedBox(
              key: _childBoxKey,
              height: _childHeight,
              child: !widget.isLoading
                  ? Text(
                      widget.text,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: widget.onTap != null
                                ? ColorCollection.white
                                : ColorCollection.white.withOpacity(0.38),
                          ),
                    )
                  :  const FittedBox(
                      child: CircularProgressIndicator(
                        color: ColorCollection.white,
                        strokeWidth: 4,
                      ),
                    ),
            )));
  }
}
