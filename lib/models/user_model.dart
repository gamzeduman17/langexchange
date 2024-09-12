class UserModel {
  final String userId;
  final String username;
  final String nativeLanguage;
  final Map<String, String> otherLanguages; //dil seviyesi
  final List<String> learningLanguages;

// JSON'dan veriyi UserModel'e dönüştür
  UserModel(
      {required this.userId,
      required this.username,
      required this.nativeLanguage,
      required this.otherLanguages,
      required this.learningLanguages});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        userId: json['userId'],
        username: json['username'],
        nativeLanguage: json['nativeLanguage'],
        otherLanguages: json['otherLanguages'],
        learningLanguages: json['learningLanguages']);
  }

  //Veriyi JSON'a dönüştürmek için
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'nativeLanguage': nativeLanguage,
      'otherLanguages': otherLanguages,
      'learningLanguages': learningLanguages
    };
  }
}
