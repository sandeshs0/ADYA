import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fit_frenzyy/models/note_item.dart';


class EditScreen extends StatefulWidget {
  final Journal? note;
  const EditScreen({super.key, this.note});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    if (widget.note != null) {
      _titleController = TextEditingController(text: widget.note!.title);
      _contentController = TextEditingController(text: widget.note!.content);
    }

    super.initState();
  }

  Future<String?> getCurrentUserId() async {
    // Get the current user from Firebase Authentication
    User? user = FirebaseAuth.instance.currentUser;

    // Return the user ID if available, otherwise return null
    return user?.uid;
  }
  void saveNote() async {
    String title = _titleController.text;
    String content = _contentController.text;

    if (title.isNotEmpty && content.isNotEmpty) {
      try {
        String? userId = await getCurrentUserId();
        if (userId != null) {
          DatabaseReference databaseReference = FirebaseDatabase.instance
              .reference()
              .child('Users')
              .child(userId)
              .child('Notes');

          String key = databaseReference.push().key!;
          Map<String, dynamic> noteData = {
            'title': title,
            'content': content,
            'timestamp': ServerValue.timestamp,
          };

          await databaseReference.child(key).set(noteData);
          Navigator.pop(context);
        } else {
          print('User ID is null');
          // Handle the case when the user ID is null (user not authenticated)
        }
      } catch (e) {
        print('Error saving note: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving note. Please try again later.'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Title and content cannot be empty.'),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  padding: const EdgeInsets.all(0),
                  icon: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.black .withOpacity(.8),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                  ))
            ],
          ),
          Expanded(
              child: ListView(
                children: [
                  TextField(
                    controller: _titleController,
                    style: const TextStyle(color: Colors.black, fontSize: 40),
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Title',
                        hintStyle: TextStyle(color: Colors.black, fontSize: 50)),
                  ),
                  TextField(
                    controller: _contentController,
                    style: const TextStyle(
                        color: Colors.black,fontSize:22
                    ),
                    maxLines: null,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type something here',
                        hintStyle: TextStyle(
                          color: Colors.black,
                        )),
                  ),
                ],
              ))
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          saveNote();
          Navigator.pop(
              context, [_titleController.text, _contentController.text]);
        },
        elevation: 10,
        backgroundColor: const Color(0xFFF5E6CC),
        child: const Icon(Icons.save),
      ),
    );
  }
}