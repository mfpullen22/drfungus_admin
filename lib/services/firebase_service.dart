import "package:cloud_firestore/cloud_firestore.dart";
import "package:drfungus_admin/models/bug.dart";

Future<List<Bug>> getBugs() async {
  final data = await FirebaseFirestore.instance
      .collection("bugs")
      .get(const GetOptions(source: Source.serverAndCache));
  final List<Bug> bugList = [];

  for (var doc in data.docs) {
    final newBug = Bug(
      name: doc["name"],
      name_lower: doc["name_lower"],
      keywords: doc["keywords"],
      description: doc["description"],
      species: doc["species"],
      clinical: doc["clinical"],
      features: doc["features"],
      precautions: doc["precautions"],
      susceptibility: doc["susceptibility"],
      references: doc["references"],
      trials: doc["trials"],
      editor: doc["editor"],
    );
    bugList.add(newBug);
  }
  bugList.sort((a, b) => a.name.compareTo(b.name));

  return bugList.toList();
}
