import "package:drfungus_admin/screens/home.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class HubScreen extends StatefulWidget {
  const HubScreen({super.key});

  @override
  State<HubScreen> createState() => _HubScreenState();
}

class _HubScreenState extends State<HubScreen> {
  Widget _activePage = const HomeScreen();
  String _activePageTitle = "Home";

  void _selectPage(Widget page, String title) {
    setState(() {
      _activePage = page;
      _activePageTitle = title;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: MediaQuery.of(context).size.width * 0.5),
            Text(_activePageTitle)
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person),
          ),
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      _selectPage(const HomeScreen(), "Home");
                    },
                    child: Text(
                      "Home",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: _activePageTitle == "Home"
                            ? FontWeight.bold
                            : FontWeight.normal,
                        decoration: _activePageTitle == "Home"
                            ? TextDecoration.underline
                            : null,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "My Topics",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: _activePageTitle == "My Topics"
                            ? FontWeight.bold
                            : FontWeight.normal,
                        decoration: _activePageTitle == "My Topics"
                            ? TextDecoration.underline
                            : null,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Available Topics",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: _activePageTitle == "Available Topics"
                            ? FontWeight.bold
                            : FontWeight.normal,
                        decoration: _activePageTitle == "Available Topics"
                            ? TextDecoration.underline
                            : null,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Submit a Case",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: _activePageTitle == "Submit a Case"
                            ? FontWeight.bold
                            : FontWeight.normal,
                        decoration: _activePageTitle == "Submit a Case"
                            ? TextDecoration.underline
                            : null,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Suggest a Topic",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: _activePageTitle == "Suggest a Topic"
                            ? FontWeight.bold
                            : FontWeight.normal,
                        decoration: _activePageTitle == "Suggest a Topic"
                            ? TextDecoration.underline
                            : null,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Vertical Divider
          Container(
            width: 1, // Width of the vertical line
            height: double.infinity, // Makes the line stretch the full height
            color: Colors.grey, // Color of the vertical line
          ),
          Expanded(
            child: _activePage,
          ),
        ],
      ),
    );
  }
}
