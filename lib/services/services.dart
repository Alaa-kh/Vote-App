import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/models/vote.dart';
import 'package:uuid/uuid.dart';

List<Vote> getVoteList() {
  // Mock Data
  List<Vote> voteList = <Vote>[];

  voteList.add(Vote(
    const Uuid().v4(),
    'Best Mobile Frameworks?',
    [
      {'Flutter': 70},
      {'React Native': 10},
      {'Xamarin': 1},
    ],
  ));

  voteList.add(Vote(
    const Uuid().v4(),
    'Best Web Frontend Frameworks?',
    [
      {'React': 80},
      {'Angular': 40},
      {'Vue': 20},
    ],
  ));

  voteList.add(Vote(
    const Uuid().v4(),
    'Best Web Backend Frameworks?',
    [
      {'Django': 50},
      {'Laravel': 30},
      {'Express.js': 50},
    ],
  ));

  return voteList;
}

const String kVotes = 'votes';
const String kTitle = 'title';

void getVoteListFromFirestore(BuildContext context) async {}
