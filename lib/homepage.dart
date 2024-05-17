import 'package:birthday_onboarding/date.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Consumer<ScreenModel>(
                builder: (context, model, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: SizedBox(
                          height: 20,
                          width: 200,
                          child: LinearProgressIndicator(
                            value: model.currentScreen / model.totalScreens,
                            backgroundColor: Colors.grey,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.orange),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text('${model.currentScreen}/${model.totalScreens}'),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'My name is...',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Enter your name',
                  hintText: 'You may change it later',
                ),
                onChanged: (value) {
                  Provider.of<ScreenModel>(context, listen: false)
                      .updateName(value);
                },
              ),
              const SizedBox(height: 610),
              Consumer<ScreenModel>(
                builder: (context, model, child) {
                  return ElevatedButton(
                    onPressed: model.isNameEntered
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DateSelectionPage(),
                              ),
                            );
                          }
                        : null,
                    child: const Text('Continue'),
                    style: ElevatedButton.styleFrom(
                        primary:
                            model.isNameEntered ? Colors.black : Colors.grey,
                        fixedSize: Size(500, 50)),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScreenModel extends ChangeNotifier {
  int currentScreen = 1;
  int totalScreens = 6;
  String name = '';
  bool get isNameEntered => name.isNotEmpty;

  void updateName(String newName) {
    name = newName;
    notifyListeners();
  }
}
