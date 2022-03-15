part of 'profile_sceen_bloc.dart';

abstract class ProfileScreenEvent {}

class ProfileInfoSuscriptionRequested extends ProfileScreenEvent {}

class NameChanged extends ProfileScreenEvent {
  final String name;
  NameChanged({
    required this.name,
  });
}

class PhoneChanged extends ProfileScreenEvent {
  final String phone;
  PhoneChanged({
    required this.phone,
  });
}

class ImagePicked extends ProfileScreenEvent {}

class ProfileInfoUpdated extends ProfileScreenEvent {}
