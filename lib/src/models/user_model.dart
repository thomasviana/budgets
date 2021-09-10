import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String lastName;
  final String? image;

  UserModel(this.id, this.name, this.lastName, {this.image});

  @override
  // TODO: implement props
  List<Object?> get props => [id];

  Map<String, Object?> toFirebaseMap({String? newImage}) {
    return <String, Object?>{
      'id': id,
      'name': name,
      'lastName': lastName,
      'image': newImage ?? image,
    };
  }

  UserModel.fromFirebaseMap(Map<String, Object?> data)
      : id = data['id'] as String,
        name = data['name'] as String,
        lastName = data['lastName'] as String,
        image = data['image'] as String;
}
