import 'package:flutter/material.dart';
import 'package:langexchange/models/languages_level_model.dart';
import 'package:langexchange/models/user_model.dart';
import 'package:langexchange/services/language_service.dart';
import 'package:langexchange/validations/user_signIn_validators.dart';
import 'package:langexchange/services/user_service.dart';
import 'package:langexchange/utils/constants.dart';

class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String nativeLanguage = '';
  List<String> learningLanguages = [];
  List<Language> availableLanguages = [];

  final LanguageService _languageService = LanguageService(); // dilleri aldık
  final UserSevice _userService = UserSevice();// Kullanıcı servisi

  @override // sayfa yüklendiği an dilleri al
  void initState() {
    super.initState();
    _loadLanguages();
  }

  @override
  _loadLanguages() async {
    var languages = await _languageService.fetchLanguages();
    setState(() {
      availableLanguages = languages;
    });
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      bool usernameExists = await Validators.checkUsernameExistsInDB(username);
      if (usernameExists) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Username already exists')),
        );
      } else {
        UserModel user = UserModel(
          userId: UuidHelper.generateUuid(),//general string Guid
          username: username,
          nativeLanguage: nativeLanguage,
          otherLanguages: {}, // Dil seviyeleri burada belirtilmeli
          learningLanguages: learningLanguages,
          isActive: true
        );
        await _userService.saveUserInfo(user); // Kullanıcı bilgilerini kaydet
        Navigator.pop(context); // Kullanıcıyı önceki sayfaya döndür
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Information')),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Username'),
              onChanged: (value) => username = value,
              validator: (value) => Validators.validateUsername(value!),
            ),
            DropdownButtonFormField(
              decoration: InputDecoration(labelText: 'Native Language'),
              items: availableLanguages.map((lang) {
                return DropdownMenuItem(
                  value: lang.name,
                  child: Text(lang.name),
                );
              }).toList(),
              onChanged: (value) {
                nativeLanguage = value as String;
              },
            ),
            // Diğer form elemanları
            ElevatedButton(
              onPressed: _submit,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
