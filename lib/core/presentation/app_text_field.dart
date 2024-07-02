
import 'package:flutter/material.dart';
import 'package:new_store/core/presentation/custom_svg_icon.dart';
import 'package:new_store/theme/collections/colorCollection.dart';
import 'package:new_store/theme/collections/svgCollection.dart';

class AppTextField extends StatefulWidget {
  final bool isPassword;
  final TextEditingController textEditingController;
  final String labelText;
  const AppTextField(
      {super.key,
      this.isPassword = false,
      required this.textEditingController,
      required this.labelText, });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  TextTheme get theme => Theme.of(context).textTheme;
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      
      style: theme.titleMedium,
      obscureText: widget.isPassword ? _obscureText : false,
      controller: widget.textEditingController,
      decoration: InputDecoration(
        filled: true,
        fillColor:  ColorCollection.input,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon:  CustomSvgIcon(
                          assetName: _obscureText
                              ? SvgCollection.eye_off
                              : SvgCollection.eye,
                        )   ,  
                        
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
          focusedBorder:  OutlineInputBorder(
            borderRadius:const  BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(
                color: ColorCollection.primary.withOpacity(0),
                width: 3), // Убираем границу, оставляя только закругления
          ),
          enabledBorder:  OutlineInputBorder(
            borderRadius:const BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(
                color: ColorCollection.primary.withOpacity(0),
                width: 1), // Убираем границу, оставляя только закругления
          ),
          hintText: widget.labelText,
          hintStyle: Theme.of(context).textTheme.bodyMedium,
          floatingLabelStyle:
              theme.bodyLarge!.copyWith(color: ColorCollection.primary),
          contentPadding:
              const EdgeInsets.only(left: 20, top: 16, bottom: 16, right: 16),
          
          border: const OutlineInputBorder()),
    );
  }
}