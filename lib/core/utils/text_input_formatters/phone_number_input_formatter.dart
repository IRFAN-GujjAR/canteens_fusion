import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

final class PhoneNumberInputFormatter {
  final _maskFormatter = MaskTextInputFormatter(
      mask: '+## ##########',
      filter: {"#": RegExp(r'[0-9]')},
      initialText: '+92',
      type: MaskAutoCompletionType.lazy);
  MaskTextInputFormatter get phoneNumberFormatter => _maskFormatter;
}
