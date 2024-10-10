import 'package:drfungus_admin/screens/auth.dart';
import 'package:drfungus_admin/screens/hub.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Debug statement

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Dr. Fungus Editor Dashboard",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            return const HubScreen();
          }

          return const AuthScreen();
        },
      ),
    );
  }
}
