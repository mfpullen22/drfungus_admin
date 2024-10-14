import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";

class AvailableTopicsScreen extends StatefulWidget {
  const AvailableTopicsScreen({super.key});

  @override
  State<AvailableTopicsScreen> createState() => _AvailableTopicsScreenState();
}

class _AvailableTopicsScreenState extends State<AvailableTopicsScreen> {
  final bugsRef = FirebaseFirestore.instance.collection('bugs');

  Future<List<DocumentSnapshot>> fetchBugsWithEmptyEditor() async {
    QuerySnapshot snapshot = await bugsRef.get();
    List<DocumentSnapshot> filteredBugs = snapshot.docs.where((doc) {
      List editor = doc['editor'] ?? [];
      return editor.isNotEmpty && editor[0] == '';
    }).toList();

    filteredBugs.sort((a, b) {
      String nameA = (a.data() as Map<String, dynamic>)['name'].toString();
      String nameB = (b.data() as Map<String, dynamic>)['name'].toString();
      return nameA.compareTo(nameB); // Alphabetical comparison
    });

    return filteredBugs;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Click a topic below to see what data is currently available. If you would like to be the editor responsible for that topic, simply click the "Assign Me" button on that screen and then navigate to the "My Topics" screen to start editing!',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(
            height:
                10), // Add some spacing between the text and the FutureBuilder
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: FutureBuilder<List<DocumentSnapshot>>(
                  future: fetchBugsWithEmptyEditor(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SizedBox(
                          width: 50, // Set a reasonable width
                          height: 50, // Set a reasonable height
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text(
                          'All topics assigned. Check back later!');
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var bug = snapshot.data![index];
                          return Center(
                            child: Container(
                              margin: const EdgeInsets.all(
                                  8.0), // Padding around each ListTile
                              width: MediaQuery.of(context).size.width *
                                  0.25, // 25% of available width
                              decoration: BoxDecoration(
                                color: Colors.lightBlue
                                    .shade100, // Light blue background
                                borderRadius: BorderRadius.circular(
                                    10), // Rounded corners
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(
                                    12.0), // Padding inside the container
                                child: ListTile(
                                  title: Text(
                                    bug['name'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  subtitle:
                                      const Text('Click to view current data'),
                                  onTap: () {
                                    // Define the action when the tile is tapped
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              Expanded(
                child: FutureBuilder<List<DocumentSnapshot>>(
                  future: fetchBugsWithEmptyEditor(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SizedBox(
                          width: 50, // Set a reasonable width
                          height: 50, // Set a reasonable height
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text(
                          'All topics assigned. Check back later!');
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var bug = snapshot.data![index];
                          return Center(
                            child: Container(
                              margin: const EdgeInsets.all(
                                  8.0), // Padding around each ListTile
                              width: MediaQuery.of(context).size.width *
                                  0.25, // 25% of available width
                              decoration: BoxDecoration(
                                color: Colors.lightBlue
                                    .shade100, // Light blue background
                                borderRadius: BorderRadius.circular(
                                    10), // Rounded corners
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(
                                    12.0), // Padding inside the container
                                child: ListTile(
                                  title: Text(
                                    bug['name'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  subtitle:
                                      const Text('Click to view current data'),
                                  onTap: () {
                                    // Define the action when the tile is tapped
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
