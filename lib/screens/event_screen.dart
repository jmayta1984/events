import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events/models/event_detail.dart';
import 'package:flutter/material.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event'),
      ),
      body: EventList(),
    );
  }
}

class EventList extends StatefulWidget {
  EventList({Key key}) : super(key: key);

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  List<EventDetail> details = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: (details != null) ? details.length : 0,
        itemBuilder: (context, position) {
          String sub = 'Date: ${details[position].date}';
          return ListTile(
            title: Text(details[position].description),
            subtitle: Text(sub),
          );
        });
  }

  Stream<List<EventDetail>> getDetailsList() {
    return db
        .collection('event-details')
        .snapshots()
        .map((event) => event.docs.map((e) => EventDetail.fromMap(e.data())).toList());
  }
/*
  Future<List<EventDetail>> getDetailsList() async {
    var data = await db.collection('event-details').get();

    if (data != null) {
      details =
          data.docs.map((document) => EventDetail.fromMap(document.data())).toList();
      print(details.length);
      int i = 0;

      details.forEach((element) {
        element.id = data.docs[i].id;
        i++;
      });
    }

    return details;
  }
  */

  @override
  void initState() {
    if (mounted) {
      getDetailsList();
    }
    super.initState();
  }
}
