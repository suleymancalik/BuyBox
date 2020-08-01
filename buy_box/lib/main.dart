import 'import.dart';

void main() => runApp(BuyBoxApp());


class BuyBoxApp extends StatefulWidget {
  @override
  _BuyBoxAppState createState() => _BuyBoxAppState();
}

class _BuyBoxAppState extends State<BuyBoxApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScrWelcome(),
    );
  }

}