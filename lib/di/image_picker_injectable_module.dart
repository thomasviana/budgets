import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ImagePickerInjectableModule {
  @lazySingleton
  ImagePicker get imagePicker => ImagePicker();
}
