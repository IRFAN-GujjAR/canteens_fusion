import 'package:canteens_fusion/core/constants/app_colors.dart';
import 'package:canteens_fusion/core/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final class CustomTextFormFieldWidget extends StatelessWidget {
  final bool _enabled;
  final TextEditingController? _controller;
  final String? _hintText;
  final String _labelText;
  final IconData? _prefixIcon;
  final IconData? _suffixIcon;
  final Widget? _suffixWidget;
  final bool _obscureText;
  final String _autofillHint;
  final String? Function(String?)? _validator;
  final ValueChanged<String>? _onChanged;
  final String? _headingText;
  final List<TextInputFormatter>? _inputFormatters;
  final int? _maxLength;
  final int _maxLines;

  const CustomTextFormFieldWidget(
      {Key? key,
      bool enabled = true,
      TextEditingController? controller,
      String? hintText,
      required String labelText,
      IconData? prefixIcon,
      IconData? suffixIcon,
      Widget? suffixWidget,
      bool obscureText = false,
      String? Function(String?)? validator,
      ValueChanged<String>? onChanged,
      required String autofillHint,
      String? headingText,
      List<TextInputFormatter>? inputFormatters,
      int? maxLength,
      int maxLines = 1})
      : _enabled = enabled,
        _controller = controller,
        _hintText = hintText,
        _labelText = labelText,
        _prefixIcon = prefixIcon,
        _suffixIcon = suffixIcon,
        _suffixWidget = suffixWidget,
        _obscureText = obscureText,
        _validator = validator,
        _onChanged = onChanged,
        _autofillHint = autofillHint,
        _headingText = headingText,
        _inputFormatters = inputFormatters,
        _maxLength = maxLength,
        _maxLines = maxLines,
        super(key: key);

  Widget _buildTxtField(BuildContext context) {
    return TextFormField(
      enabled: _enabled,
      controller: _controller,
      autofillHints: [_autofillHint],
      obscureText: _obscureText,
      maxLength: _maxLength,
      maxLines: _maxLines,
      inputFormatters: _inputFormatters,
      decoration: InputDecoration(
          contentPadding:
              EdgeInsets.only(left: 20.h, top: 17.v, bottom: 17.v, right: 20.h),
          prefixIcon: _prefixIcon != null
              ? Icon(
                  _prefixIcon,
                )
              : null,
          suffixIcon: _suffixWidget ??
              (_suffixIcon != null
                  ? Padding(
                      padding: EdgeInsets.only(right: 24.h),
                      child: Icon(
                        _suffixIcon,
                      ),
                    )
                  : null),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              borderSide: BorderSide(color: Color(AppColors.seedColor))),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              borderSide: BorderSide(color: Colors.grey)),
          hintText: _hintText,
          labelText: _labelText,
          labelStyle: const TextStyle(fontSize: 14)),
      validator: _validator,
      onChanged: _onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _headingText != null
        ? Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 8.h, bottom: 12.v),
                  child: Text(_headingText),
                ),
              ),
              _buildTxtField(context),
            ],
          )
        : _buildTxtField(context);
  }
}
