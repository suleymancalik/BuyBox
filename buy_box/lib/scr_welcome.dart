import 'import.dart';


class ScrWelcome extends StatefulWidget {

  @override
  _ScrWelcomeState createState() => _ScrWelcomeState();

}

class _ScrWelcomeState extends State<ScrWelcome> {

  //bool _checking = false;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      FirebaseAuth.instance.currentUser().then((FirebaseUser authUser) {
        checkUser(context, authUser);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //body: Center(child:CircularProgressIndicator()),
      ),
    );
  }

  void checkUser(BuildContext context, FirebaseUser authUser) async {
    print('Cheking user...');
    if (authUser == null) {
      final res = await _signInAnonymously();
      if (res.user != null) {
        User.authUser = res.user;
      }
      else {
        print('Can not sign in Anonymously!');
        return;
      }
    }
    else {
      User.authUser = authUser;
    }

    Goal goal;

    final goalStream = await Goal.getWithUserId(authUser.uid);
    if (goalStream.documents.length > 0) {
      final goalSS = goalStream.documents.first;
      if (goalSS != null) {
        goal = Goal.fromSnapshot(goalSS);
      }
    }

    if (goal == null) {
      print('Opening ScrCreateGoal');
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => ScrCreateGoal()));
    }
    else {
      Goal.currentGoal = goal;
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => ScrGoalDetail()));
    }

  }

  Future<AuthResult> _signInAnonymously() async {
    try {
      return FirebaseAuth.instance.signInAnonymously();
    }
    catch (e) {
      print('_signInAnonymously failed!');
      print(e);
      return null;
    }
  }
}
