import "package:flutter/material.dart";
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/models/vote.dart';
import 'package:flutter_application_1/state/vote.dart';
import 'package:provider/provider.dart';

class VoteListWidget extends StatelessWidget {
  const VoteListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Function alternateColor = getAlternate(start: 0);
    return Consumer<VoteState>(
      builder: (context, voteState, child) {
        String activeVoteId = voteState.activeVote.voteId ?? '';

        return Column(
          children: <Widget>[
            for (Vote vote in voteState.voteList)
              Card(
                color: activeVoteId == vote.voteId
                    ? Colors.red[200]
                    : alternateColor(),
                child: ListTile(
                  title: Container(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      vote.voteTitle,
                      style: TextStyle(
                        fontSize: 18,
                        color: activeVoteId == vote.voteId
                            ? Colors.white
                            : Colors.black,
                        fontWeight: activeVoteId == vote.voteId
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                  selected: activeVoteId == vote.voteId ? true : false,
                  onTap: () {
                    voteState.activeVote = vote;
                  },
                ),
              ),
          ],
        );
      },
    );
  }

  Function getAlternate({int start = 0}) {
    int indexNum = start;

    Color getColor() {
      Color color = kPrimaryColor.withOpacity(0.6);

      if (indexNum % 2 == 0) {
        color = Colors.purpleAccent.shade100;
      }
      ++indexNum;
      return color;
    }

    return getColor;
  }
}
