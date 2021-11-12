import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const FlutterApp());
}

class FlutterApp extends StatelessWidget {
  const FlutterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(title: Text('$number'), actions: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                conclusion,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ]);
        });
  }
  final TextEditingController controller = TextEditingController();
  String conclusion = '';
  int? number;
  String? text;
  String? errorText;
  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Number Shapes'),
          ),
        ),
        body: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsetsDirectional.all(16.0),
              child: Text(
                'Please input a number to see if it is square or triangular.',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.all(16.0),
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onChanged: (String? value) {
                  final String value = controller.text;
                  final double? double_value = double.tryParse(value);
                },
                decoration: InputDecoration(
                  errorText: errorText,
                  hintText: 'Try me',
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: new FloatingActionButton(
            elevation: 0.0,
            child: new Icon(Icons.check),
            backgroundColor: new Color(0xFFE57373),
            onPressed: () {
              int square_flag = 0;
              int triangular_flag = 0;
              final String value = controller.text;
              final int? int_value = int.tryParse(value);
              setState(() {
                if (int_value == null) {
                  errorText = 'please enter a number';
                } else {
                  number = int_value;
                  errorText = null;
                  for (int i = 0; i < int_value / 2; i++) {
                    if (i * i == int_value) {
                      square_flag = 1;
                    }
                  }
                  for (int i = 0; i < int_value / 2; i++) {
                    if (i * i * i == int_value) {
                      triangular_flag = 1;
                    }
                  }
                  if (square_flag == 0 && triangular_flag == 0) {
                    conclusion =
                        "Number $int_value is neither TRIANGULAR or SQUARE.";
                  } else if (square_flag == 1 && triangular_flag == 1) {
                    conclusion =
                        "Number $int_value is both TRIANGULAR and SQUARE.";
                  } else if (square_flag == 1) {
                    conclusion = "Number $int_value is SQUARE.";
                  } else if (triangular_flag == 1) {
                    conclusion = "Number $int_value is TRIANGULAR.";
                  }
                  createAlertDialog(context);
                  controller.clear();
                }
              });
            })
    );
  }
}
