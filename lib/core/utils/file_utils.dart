import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as p;

class FileUtils {
  static String getFileName({required XFile file, required String fileName}) {
    return 'main_image${p.extension(file.path)}';
  }
}
