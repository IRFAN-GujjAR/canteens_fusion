import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final class ProviderUtils<T> {
  T getProvider({required BuildContext context, bool listen = false}) {
    return Provider.of<T>(context, listen: listen);
  }
}
