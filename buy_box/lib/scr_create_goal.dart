import 'import.dart';

class ScrCreateGoal extends StatefulWidget {
  @override
  _ScrCreateGoalState createState() => _ScrCreateGoalState();
}

class _ScrCreateGoalState extends State<ScrCreateGoal> {
  bool working = false;
  double amount = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Text(
              'Hedefini Gir',
              style: TextStyle(fontSize: 30),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              onChanged: (value) {
                amount = double.parse(value);
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
              if (amount > 0) {
                createNewGoal();
              } else {}
            },
          )
        ],
      )
    ];

    if (working) {
      children.add(CircularProgressIndicator());
    }

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

  createNewGoal() {
    setState(() => working = true);
    Goal.createOrUpdate(amount: amount).then((goal) {
      if (goal != null) {
        print('Goal created succesfully');
        Goal.currentGoal = goal;
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => ScrGoalDetail()));
      } else {
        print('Goal NOT created !!!');
        setState(() => working = false);
      }
    });
  }
}
