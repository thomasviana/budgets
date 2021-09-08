import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    this.name,
    this.email,
    this.photo,
  });

  final String id;
  final String? name;
  final String? email;
  final String? photo;

  /// Empty user which represents an unauthenticated user.
  static const empty = User(id: '');

  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [email, id, name, photo];
}