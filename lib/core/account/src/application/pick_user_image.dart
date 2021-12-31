import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@injectable
class PickUserImage {
  final ImagePicker _imagePicker;
  PickUserImage(
    this._imagePicker,
  );

  Future<Option<XFile>> call() async {
    final optionImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (optionImage != null) return some(optionImage);
    return none();
  }
}