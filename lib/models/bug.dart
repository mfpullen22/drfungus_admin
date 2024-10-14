class Bug {
  const Bug(
      {required this.name,
      required this.name_lower,
      required this.keywords,
      required this.description,
      required this.species,
      required this.clinical,
      required this.features,
      required this.precautions,
      required this.susceptibility,
      required this.references,
      required this.trials,
      required this.editor});

  final String name;
  final String name_lower;
  final List<dynamic> keywords;
  final String description;
  final String species;
  final String clinical;
  final String features;
  final String precautions;
  final String susceptibility;
  final List<dynamic> references;
  final List<dynamic> trials;
  final List<dynamic> editor;

  factory Bug.fromMap(Map<String, dynamic> map) {
    return Bug(
      name: map['name'] ?? '',
      name_lower: map["name_lower"] ?? '',
      keywords: map['keywords'] ?? [""],
      description: map['description'] ?? '',
      species: map['species'] ?? '',
      clinical: map['clinical'] ?? '',
      features: map['features'] ?? '',
      precautions: map['precautions'] ?? '',
      susceptibility: map['susceptibility'] ?? '',
      references: map['references'] ?? [],
      trials: map['trials'] ?? [],
      editor: map['editor'] ?? [],
    );
  }
}
