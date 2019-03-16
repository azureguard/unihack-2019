import 'package:flutter/material.dart';

// The Emergency Task Card
class EmergencyTaskCard extends StatefulWidget {
  const EmergencyTaskCard({
    Key key,
    @required this.title,
    @required this.numberOfPeople,
    @required this.description,
    @required this.dndStatus,
  });

  final String title;
  final int numberOfPeople;
  final String description;
  final bool dndStatus;

  @override
  _EmergencyTaskCardState createState() => _EmergencyTaskCardState();
}

class _EmergencyTaskCardState extends State<EmergencyTaskCard> {
  @override
  Widget build(BuildContext context) {
    // Put style here
    return Card(
      child: Container(
        height: 168,
        width: 200,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.title,
                style: Theme.of(context).textTheme.title,
              ),
              Text(
                widget.description,
                style: Theme.of(context).textTheme.body1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "0 / ${widget.numberOfPeople}",
                    style: Theme.of(context).textTheme.headline,
                  ),
                  RaisedButton(
                    // TODO: change the on pressed behaviour
                    onPressed: () => {print("yo")},
                    child: Text('Submit'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmergencyWidget extends StatefulWidget {
  EmergencyWidget({Key key}) : super(key: key);

  @override
  _EmergencyWidgetState createState() => _EmergencyWidgetState();
}

class _EmergencyWidgetState extends State<EmergencyWidget> {
  Widget build(BuildContext context) {
    const details = [
      {
        "title": "hello",
        "numberOfPeople": 5,
        "description": "Taking out some trash to people out theere yeayy okoko",
        "dndStatus": true,
      },
      {
        "title": "hello",
        "numberOfPeople": 5,
        "description": "Taking out some trash to people out theere yeayy okoko",
        "dndStatus": true,
      },
      {
        "title": "hello",
        "numberOfPeople": 5,
        "description": "Taking out some trash to people out theere yeayy okoko",
        "dndStatus": true,
      },
      {
        "title": "hello",
        "numberOfPeople": 5,
        "description": "Taking out some trash to people out theere yeayy okoko",
        "dndStatus": true,
      },
      {
        "title": "hello",
        "numberOfPeople": 5,
        "description": "Taking out some trash to people out theere yeayy okoko",
        "dndStatus": true,
      }
    ];

    final cards = <EmergencyTaskCard>[];

    for (var i = 0; i < details.length; i++) {
      cards.add(EmergencyTaskCard(
        title: details[i]["title"],
        numberOfPeople: details[i]["numberOfPeople"],
        description: details[i]["description"],
        dndStatus: details[i]["dndStatus"],
      ));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: _buildEmergencyCard(cards),
    );
  }

  Widget _buildEmergencyCard(List<EmergencyTaskCard> cards) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => cards[index],
      itemCount: cards.length,
    );
  }
}
