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
    return Scaffold();
  }

  void checkUser(BuildContext context, FirebaseUser authUser) async {
    print('Cheking user...');
    //_checking = true;
    if (authUser == null) {
      final res = await _signInAnonymously();
      if (res.user != null) {
        User.authUser = res.user;
      }
      else {
        print('Can not sign in Anonymously!');
        //_checking = false;
        return;
      }
    }
    else {
      User.authUser = authUser;
    }

    /*
    final goal = await Home.getWithUserId(User.currentUser.uid);
    if (home == null) {
      print('Opening ScrSelectHome');
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => ScrSelectHome()));
    }
    else {
      Home.currentHome = home;
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => ScrHome()));
    }
     */

  }

  Future<AuthResult> _signInAnonymously() async {
    try {
      return FirebaseAuth.instance.signInAnonymously();
    } catch (e) {
      print(e);
      return null;
    }
  }
}
