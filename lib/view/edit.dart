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

        // Get the current user's ID
        String? userId = await getCurrentUserId();

        if (userId != null) {
          // Get a reference to the Realtime Database
          DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child('Users').child(userId).child('Notes');

          // Generate a new unique key for the note
          String key = databaseReference.push().key!; // Use '!' to assert non-nullability

          // Construct the note data
          Map<String, dynamic> noteData = {
            'title': title,
            'content': content,
            'timestamp': ServerValue.timestamp, // Add a server timestamp
          };

          // Save the note under the generated key
          await databaseReference.child(key).set(noteData);

          // Close the screen
          Navigator.pop(context);
        } else {
          // Handle the case when userId is null
          print('User ID is null');
        }
      } catch (e) {
        print('Error saving note: $e');
        // Optionally, show an error message to the user
      }
    } else {
      // Optionally, show a message indicating that title and content cannot be empty
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9E8C9),
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
                        color: Colors.grey.shade800.withOpacity(.8),
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
                  Center(
                    child: TextField(
                      controller: _titleController,
                      style: const TextStyle(color: Colors.blueGrey, fontSize: 20),
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Mood',
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 20)),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  TextField(
                    controller: _contentController,
                    style: const TextStyle(
                      color: Color(0xFF332941),
                      fontSize: 26,
                    ),
                    maxLines: null,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Start writing your day...',
                        hintStyle: TextStyle(
                          color: Colors.grey,
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
        backgroundColor: Color(0xFF40679E)
        ,
        child: const Icon(Icons.save),
      ),
    );
  }
}