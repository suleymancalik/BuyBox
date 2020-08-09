import 'import.dart';

class ScrGoalDetail extends StatefulWidget {
  @override
  _ScrGoalDetailState createState() => _ScrGoalDetailState();
}

class _ScrGoalDetailState extends State<ScrGoalDetail> {
  bool working = false;
  double dropAmount = 0;

  @override
  Widget build(BuildContext context) {
    Goal goal = Goal.currentGoal;

    String title = 'Hedef: ' + goal.totalAmount.toString();
    double progress = goal.reachedAmount / goal.totalAmount;

    List<Widget> children = [
      Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 40)),
          Text(title),
          LinearProgressIndicator(value: progress),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              onChanged: (value) {
                dropAmount = double.parse(value);
              },
            ),
          ),
          MaterialButton(
            color: Colors.blueAccent,
            textColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Text('Kaydet', style: TextStyle(fontSize: 20)),
            ),
            onPressed: () {
              if (dropAmount > 0) {
                addNewDrop(dropAmount);
              } else {}
            },
          )
        ],
      )
    ];

    return Scaffold(
      appBar: new AppBar(
        title: new Text('Buy Box'),
      ),
      body: Center(
        child: Stack(
          children: children,
        ),
      ),
    );
  }

  addNewDrop(double amount) {
    setState(() {
      working = true;
    });
    Goal.currentGoal.addNewDrop(dropAmount).then((goal) {
      Goal.currentGoal = goal;
      setState(() => working = false);
    });
  }
}
