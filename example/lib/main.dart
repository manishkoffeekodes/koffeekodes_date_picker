import 'package:custom_date_picker/custom_date_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: DatePickerExample(),
      home: HomePage(),
      // CustomCalendarUI(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime? selectedDate;

  void _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            backgroundColor: Colors.black,
            contentPadding: EdgeInsets.all(0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 390,
                  child: CustomCalendarUI(
                    initialDate: DateTime(2021, 3, 24),
                    onDateSelected: (value) async {
                      setState(() {
                        selectedDate = value;
                      });
                    },
                    firstDate: DateTime(2021),
                    lastDate: DateTime(2025),
                    isButtonShow: false,
                  ),
                ),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Custom Dialog Example")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Selected date: ${selectedDate != null ? selectedDate.toString() : 'None'}",
            ),
            SizedBox(height: 20),
            CustomCalendarUI(
              initialDate: DateTime(2021, 3, 24),
              onDateSelected: (value) async {
                setState(() {
                  selectedDate = value;
                });
              },
              firstDate: DateTime(2021),
              lastDate: DateTime(2025),
              isButtonShow: false,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Show Custom Dialog"),
              onPressed: () => _showCustomDialog(context),
            ),
          ],
        ),
      ),
    );
  }
}
