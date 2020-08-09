import 'import.dart';

class ScrCompleted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Buy Box'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 40)),
            Text('Tebrikler Hedefinize Ulaştınız.'),
            MaterialButton(
              color: Colors.blueAccent,
              textColor: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child:
                    Text('Yeni Hedef Belirle', style: TextStyle(fontSize: 20)),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => ScrCreateGoal()));
              },
            )
          ],
        ),
      ),
    );
  }
}
