import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String lastName;
  final String? image;
  final String? email;
  final String? phoneNumber;

  UserModel(this.id, this.name, this.lastName, this.email,
      {this.image, this.phoneNumber});

  @override
  List<Object?> get props => [id];

  Map<String, Object?> toFirebaseMap({String? newImage}) {
    return <String, Object?>{
      'id': id,
      'name': name,
      'lastName': lastName,
      'email': email,
      'image': newImage ?? image,
      'phoneNumber': phoneNumber,
    };
  }

  UserModel.fromFirebaseMap(Map<String, Object?> data)
      : id = data['id'] as String,
        name = data['name'] as String,
        lastName = data['lastName'] as String,
        email = data['email'] as String,
        image = data['image'] as String,
        phoneNumber = data['phoneNumber'] as String;
}
