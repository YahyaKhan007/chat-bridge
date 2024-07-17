class UserModel {
  final String uid;
  final String fullName;
  final String emailAddress;
  String phoneNumber;
  final bool isVarified;
  String country;
  String city;
  String nativeLanguage;
  List<String> interestedLanguages;

  UserModel({
    required this.uid,
    required this.fullName,
    required this.emailAddress,
    required this.phoneNumber,
    required this.isVarified,
    required this.country,
    required this.city,
    required this.nativeLanguage,
    required this.interestedLanguages,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      fullName: json['fullName'],
      isVarified: json['isVarified'],
      emailAddress: json['emailAddress'],
      phoneNumber: json['phoneNumber'],
      country: json['country'],
      city: json['city'],
      nativeLanguage: json['nativeLanguage'],
      interestedLanguages: List<String>.from(json['interestedLanguages']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'fullName': fullName,
      'isVarified': isVarified,
      'emailAddress': emailAddress,
      'phoneNumber': phoneNumber,
      'country': country,
      'city': city,
      'nativeLanguage': nativeLanguage,
      'interestedLanguages': interestedLanguages,
    };
  }
}
