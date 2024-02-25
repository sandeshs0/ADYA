class Journal {
  int id;
  String title;
  String content;
  DateTime modifiedTime;

  Journal({
    required this.id,
    required this.title,
    required this.content,
    required this.modifiedTime,
  });
}

List<Journal> sampleNotes = [
  // Journal(
  //   id: 0,
  //   title: 'Happy',
  //   content:
  //   'Embracing the sunshine, I tackled tasks with gusto, shared laughter with colleagues, caught up with a friend over lunch, indulged in an evening yoga session, and ended the day feeling abundantly grateful for lifes simple joys',
  //   modifiedTime: DateTime(2024,2,20,34,5),
  // ),
  // Journal(
  //   id: 1,
  //   title: 'Sad',
  //   content:
  //   'The day wears a somber cloak, weighed down by the echoes of a shattered romance, navigating through the debris of dreams, seeking solace in the bittersweet melodies of memories, and finding strength in the promise of resilience and self-discovery that lies beyond the horizon.',
  //   modifiedTime: DateTime(2024,2,21,34,5),
  // ),
];
