import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key,}) : super(key: key);


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool Value = false;
 TextEditingController EmailController = TextEditingController();
 TextEditingController PasswordController = TextEditingController();

 @override
 void initState() {
    // TODO: implement initState
    super.initState();
    _loadUserEmailPassword();
  }
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: EmailController,
              decoration: const InputDecoration(
                hintText: 'Enter Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30,),
            TextField(
              controller: PasswordController,
              decoration: const InputDecoration(
                  hintText: 'Enter Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30,),
            ElevatedButton(
                onPressed: (){
                  setState(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context)=>Home()));
                  });
                },
                child: const Text('login')
            ),
            Row(
              children: [
                Checkbox(
                  value: Value,
                  onChanged: _handleRemeberme

                ),
                const Text('Remember me'),
              ],
            ),
          ],
        ),
      ),
    );
  }
  void _handleRemeberme(bool? value) {
    print("Handle Rember Me");
    Value = value!;
    SharedPreferences.getInstance().then(
          (prefs) {
        prefs.setBool("remember_me", value);
        prefs.setString('email', EmailController.text);
        prefs.setString('password', PasswordController.text);
      },
    );
    setState(() {
      Value = value;
    });
  }

  void _loadUserEmailPassword() async {
    print("Load Email");
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _email = _prefs.getString("email") ?? "";
      var _password = _prefs.getString("password") ?? "";
      var _remeberMe = _prefs.getBool("remember_me") ?? false;

      print(_remeberMe);
      print(_email);
      print(_password);
      if (_remeberMe) {
        setState(() {
          Value = true;
          Navigator.push(context,
              MaterialPageRoute(builder: (context)=>Home()));
        });
        EmailController.text = _email ?? "";
        PasswordController.text = _password ?? "";
      }
    } catch (e) {
      print(e);
    }
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home'),
      ),
    );
  }
}
