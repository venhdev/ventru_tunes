import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class QueueActionsWidget extends StatefulWidget {
  const QueueActionsWidget({super.key});

  @override
  _QueueActionsWidgetState createState() => _QueueActionsWidgetState();
}

class _QueueActionsWidgetState extends State<QueueActionsWidget>
    with TickerProviderStateMixin {
  late List<SlidableController> slidableControllers;

  List<Song> songs = [
    Song(title: "Get Lucky (feat. ...)", artist: "Daft Punk"),
    Song(title: "Blinding Lights", artist: "The Weeknd"),
    Song(title: "Shape of You", artist: "Ed Sheeran"),
    Song(title: "Old Town Road", artist: "Lil Nas X"),
    Song(title: "Get Lucky (feat. ...)", artist: "Daft Punk"),
    Song(title: "Blinding Lights", artist: "The Weeknd"),
    Song(title: "Shape of You", artist: "Ed Sheeran"),
    Song(title: "Old Town Road", artist: "Lil Nas X"),
    Song(title: "Get Lucky (feat. ...)", artist: "Daft Punk"),
    Song(title: "Blinding Lights", artist: "The Weeknd"),
    Song(title: "Shape of You", artist: "Ed Sheeran"),
    Song(title: "Old Town Road", artist: "Lil Nas X"),
    Song(title: "Get Lucky (feat. ...)", artist: "Daft Punk"),
    Song(title: "Blinding Lights", artist: "The Weeknd"),
    Song(title: "Shape of You", artist: "Ed Sheeran"),
    Song(title: "Old Town Road", artist: "Lil Nas X"),
    Song(title: "Get Lucky (feat. ...)", artist: "Daft Punk"),
    Song(title: "Blinding Lights", artist: "The Weeknd"),
    Song(title: "Shape of You", artist: "Ed Sheeran"),
    Song(title: "Old Town Road", artist: "Lil Nas X"),
    Song(title: "Get Lucky (feat. ...)", artist: "Daft Punk"),
    Song(title: "Blinding Lights", artist: "The Weeknd"),
    Song(title: "Shape of You", artist: "Ed Sheeran"),
    Song(title: "Old Town Road", artist: "Lil Nas X"),
    Song(title: "Get Lucky (feat. ...)", artist: "Daft Punk"),
    Song(title: "Blinding Lights", artist: "The Weeknd"),
    Song(title: "Shape of You", artist: "Ed Sheeran"),
    Song(title: "Old Town Road", artist: "Lil Nas X"),
  ];

  bool selectAllMode = false;

  void toggleAllSlidables(bool open) {
    for (var controller in slidableControllers) {
      if (open) {
        controller.openEndActionPane();
      } else {
        controller.close();
      }
    }
  }

  void removeSong(int index) {
    setState(() {
      songs.removeAt(index);
      slidableControllers.removeAt(index);
    });
  }

  void addSong(Song song) {
    setState(() {
      songs.add(song);
      slidableControllers.add(SlidableController(this));
    });
  }

  @override
  void initState() {
    super.initState();
    slidableControllers =
        List.generate(songs.length, (_) => SlidableController(this));
  }

  @override
  void dispose() {
    for (var controller in slidableControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: const Text(
          'Random Access Memories',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shuffle, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.repeat, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  selectAllMode = !selectAllMode;
                  toggleAllSlidables(selectAllMode);
                });
              },
              child: Text(selectAllMode ? 'Deselect All' : 'Select All'),
            ),
          ),
          Expanded(
            child: ReorderableListView.builder(
              itemCount: songs.length,
              itemBuilder: (context, index) {
                return Slidable(
                  key: Key('song_$index'),
                  controller: slidableControllers[index],
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          setState(() {
                            songs.removeAt(index);
                          });
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Remove',
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Icon(Icons.music_note, color: Colors.white),
                    ),
                    title: Text(
                      songs[index].title,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      songs[index].artist,
                      style: TextStyle(color: Colors.grey),
                    ),
                    trailing: ReorderableDragStartListener(
                      index: index,
                      child: Icon(Icons.drag_handle, color: Colors.white),
                    ),
                  ),
                );
              },
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (newIndex > oldIndex) {
                    newIndex -= 1;
                  }
                  final Song item = songs.removeAt(oldIndex);
                  songs.insert(newIndex, item);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Song {
  final String title;
  final String artist;

  Song({required this.title, required this.artist});
}
