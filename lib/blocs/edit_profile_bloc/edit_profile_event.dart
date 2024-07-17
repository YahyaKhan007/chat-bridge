part of 'edit_profile_bloc.dart';

sealed class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object> get props => [];
}

class AddProfilePicEvent extends EditProfileEvent {
  final String key;

  const AddProfilePicEvent({required this.key});
}

class UpdateUserDetails extends EditProfileEvent {
  final String country;
  final String city;
  final String nativeLanguage;
  final List<String> interestedLanguages;

  const UpdateUserDetails(
      {required this.country,
      required this.city,
      required this.nativeLanguage,
      required this.interestedLanguages});
}
