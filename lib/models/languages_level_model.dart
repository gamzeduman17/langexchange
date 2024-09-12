enum LanguageLevel { Beginner, Intermediate, Advanced, Native }

class Language {
  final String name;

// Dış kaynaktan dilleri çekmek için model
  Language({required this.name});

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(name: json['name']);
  }
}
