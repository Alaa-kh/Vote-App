import "package:flutter/material.dart";
import "package:flutter_application_1/models/vote.dart";
import "package:flutter_application_1/state/vote.dart";
import "package:provider/provider.dart";

class VoteWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<VoteState>(builder: (context, voteState, child) {
      Vote activeVote = voteState.activeVote;
      List<String> options = <String>[];

      for (Map<String, int> option in activeVote.options) {
        option.forEach((title, value) {
          options.add(title);
        });
      }

      return Column(
        children: <Widget>[
          Card(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20),
              child: Text(
                activeVote.voteTitle,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ),
          ),
          for (String option in options)
            Card(
              child: InkWell(
                onTap: () {
                  voteState.selectedOptionInActiveVote = option;
                },
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        constraints: BoxConstraints(minHeight: 60),
                        width: 8,
                        color: Colors.purple,
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 10, right: 5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            option,
                            maxLines: 5,
                            style: TextStyle(fontSize: 22),
                          ),
                          color: voteState.selectedOptionInActiveVote == option
                              ? Colors.purple.shade100
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }
}
