import "package:flutter/material.dart";
import "package:flutter_quill/flutter_quill.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

class TestDataEntryScreen extends StatefulWidget {
  const TestDataEntryScreen({super.key});

  @override
  State<TestDataEntryScreen> createState() => _TestDataEntryScreenState();
}

class _TestDataEntryScreenState extends State<TestDataEntryScreen> {
  QuillController _controller = QuillController.basic();
  final _focusNode = FocusNode();
  final _scrollController = ScrollController();

  Future<void> _submitData() async {
    try {
      // Convert the Quill document to a JSON-compatible format
      var jsonContent = _controller.document.toDelta().toJson();

      // Send the data to Firestore
      await FirebaseFirestore.instance.collection('test').add({
        'content': jsonContent,
        'timestamp': Timestamp.now(), // Optional: Add a timestamp
      });

      // Show confirmation message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data submitted successfully!')),
      );

      // Clear the editor after submission
      _controller.clear();
    } catch (e) {
      // Handle any errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit data: $e')),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.readOnly = false;
    return Column(
      children: [
        QuillToolbar.simple(controller: _controller),
        Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.5,
          child: QuillEditor(
            controller: _controller,
            scrollController: _scrollController,
            focusNode: _focusNode,
            configurations: const QuillEditorConfigurations(
              scrollable: true,
              padding: EdgeInsets.all(10),
              autoFocus: true,
              expands: true,
            ),
          ),
        ),
        TextButton(
          onPressed: _submitData,
          child: Text("SUBMIT"),
        )
      ],
    );
  }
}
