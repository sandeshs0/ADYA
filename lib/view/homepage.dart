import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fit_frenzyy/components/cusButton.dart';
import 'package:fit_frenzyy/models/note_item.dart';
import 'package:fit_frenzyy/view/edit.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user=FirebaseAuth.instance.currentUser!;
  List<Journal> filteredNotes = [];
  bool sorted = false;
  final databaseReference = FirebaseDatabase.instance.reference();


  @override
  void initState() {
    super.initState();
    // _getNotes();
  }
  // void _getNotes() async {
  //   DataSnapshot snapshot = await databaseReference.child('users/${user.uid}/notes').once();
  //   Map<dynamic, dynamic> notesMap = snapshot.value;
  //   notesMap.forEach((key, value) {
  //     Journal note = Journal.fromMap(value);
  //     setState(() {
  //       filteredNotes.add(note);
  //     });
  //   });
  // }
  void LogOut(){
    FirebaseAuth.instance.signOut();
  }
  List<Journal> sortNotesByModifiedTime(List<Journal> notes) {
    if (sorted) {
      notes.sort((a, b) => a.modifiedTime.compareTo(b.modifiedTime));
    } else {
      notes.sort((b, a) => a.modifiedTime.compareTo(b.modifiedTime));
    }
    sorted = !sorted;
    return notes;
  }
  void onSearchTextChanged(String searchText) {
    setState(() {
      filteredNotes = sampleNotes
          .where((note) =>
      note.content.toLowerCase().contains(searchText.toLowerCase()) ||
          note.title.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  void deleteNote(int index) {
    setState(() {
      Journal note = filteredNotes[index];
      sampleNotes.remove(note);
      filteredNotes.removeAt(index);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'ADYA', //meaning: yesterday lai yaha, today lai adya, tomorow lai shvaha
                  style: TextStyle(fontSize: 30, color: Colors.indigo, fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () {
                      LogOut();
                    },
                    padding: const EdgeInsets.all(0),
                    icon: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Color(0xFF7FC7D9).withOpacity(.8),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(
                        Icons.logout_rounded,
                        color: Colors.white,
                      ),
                    ))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: onSearchTextChanged,
              style: const TextStyle(fontSize: 16, color: Colors.white),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                hintText: "Search notes...",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                fillColor: Colors.grey.shade50,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 30),
                  itemCount: filteredNotes.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 20),
                      color: Color(0xFFF1FADA),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListTile(
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    EditScreen(note: filteredNotes[index]),
                              ),
                            );
                            if (result != null) {
                              setState(() {
                                int originalIndex =
                                sampleNotes.indexOf(filteredNotes[index]);

                                sampleNotes[originalIndex] = Journal(
                                    id: sampleNotes[originalIndex].id,
                                    title: result[0],
                                    content: result[1],
                                    modifiedTime: DateTime.now());

                                filteredNotes[index] = Journal(
                                    id: filteredNotes[index].id,
                                    title: result[0],
                                    content: result[1],
                                    modifiedTime: DateTime.now());
                              });
                            }
                          },
                          title: RichText(
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                                text: '${DateFormat('EEEE MMM d | yyyy').format(filteredNotes[index].modifiedTime)} \n',
                                style: const TextStyle(
                                    color: Color(0xFF265073),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19,
                                    height: 1.5),
                                children: [
                                  TextSpan(
                                    text: filteredNotes[index].content,
                                    style: const TextStyle(
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14,
                                        height: 1.5),
                                  )
                                ]),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Mood: ${filteredNotes[index].title}',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey.shade800),
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () async {
                              final result = await confirmDialog(context);
                              if (result != null && result) {
                                deleteNote(index);
                              }
                            },
                            icon: const Icon(
                              Icons.delete,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const EditScreen(),
            ),
          );

          if (result != null) {
            setState(() {
              sampleNotes.add(Journal(
                  id: sampleNotes.length,
                  title: result[0],
                  content: result[1],
                  modifiedTime: DateTime.now()));
              filteredNotes = sampleNotes;
            });
          }
        },
        elevation: 10,
        backgroundColor: Color(0xFF40679E),
        child: const Icon(
          Icons.add,
          size: 38,
        ),
      ),
    );
  }
}

Future<dynamic> confirmDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade900,
          icon: const Icon(
            Icons.info,
            color: Colors.grey,
          ),
          title: const Text(
            'Are you sure you want to delete?',
            style: TextStyle(color: Colors.white),
          ),
          content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green),
                    child: const SizedBox(
                      width: 60,
                      child: Text(
                        'Yes',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const SizedBox(
                      width: 60,
                      child: Text(
                        'No',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              ]),
        );
      });
}
