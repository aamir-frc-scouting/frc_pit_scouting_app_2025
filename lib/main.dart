import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(title: 'Reefscape Pit Scouting App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

const List<String> drivetrainList = <String>[
  '',
  'No Swerve',
  'Swerve',
];

const List<String> swerveList = <String>[
  '',
  'Thrifty Bot',
  'REV',
  'WCP',
  'SDS',
  'Custom :)'
];

const List<String> SDSList = <String>['', 'L1', 'L2', 'L3', 'L4'];
const List<String> WCPList = <String>['', 'X', 'X2'];
const List<String> thriftyBotList = <String>[
  '',
  'Full Kraken',
  'Kraken Drive',
  '8mm Keyed Drive'
];

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;
  String data = "";
  final TextEditingController scoutName = TextEditingController();
  final TextEditingController teamName = TextEditingController();
  final TextEditingController teamNumber = TextEditingController();
  final TextEditingController weight = TextEditingController();
  final TextEditingController dimensions = TextEditingController();
  final TextEditingController cycles = TextEditingController();
  final TextEditingController mechanisms = TextEditingController();
  final TextEditingController drivetrainMotors = TextEditingController();
  String drivetrainValue = drivetrainList.first;
  String? swerveValue = swerveList.first;
  String? SDSValue = SDSList.first;
  String? WCPValue = WCPList.first;
  String? thriftyBotValue = thriftyBotList.first;
  bool troughValue = false;
  bool L2Value = false;
  bool L3Value = false;
  bool L4Value = false;
  bool netValue = false;
  bool processorValue = false;
  bool takeOffAlgaeValue = false;

  String printBoolean(bool value) {
    return value ? 'Yes' : 'No';
  }

  void formatData() {
    setState(() {
      data = "";
    });
  }

  void resetData() {
    setState(() {
      data = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_left),
              onPressed: () {
                setState(() {
                  if (currentPageIndex > 0) {
                    currentPageIndex--; // Decrement the page index
                  }
                });
              },
              tooltip: 'Back',
            ),
            IconButton(
              icon: const Icon(Icons.arrow_right),
              onPressed: () {
                setState(() {
                  // Increment the page index (add logic if there's a max index limit)
                  currentPageIndex++;
                });
              },
              tooltip: 'Next',
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: <Widget>[
        Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: scoutName,
                  cursorColor: Colors.amber,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber, width: 2.0),
                    ),
                    border: OutlineInputBorder(),
                    hintText: 'Scout Name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: teamName,
                  cursorColor: Colors.amber,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber, width: 2.0),
                    ),
                    border: OutlineInputBorder(),
                    hintText: 'Team Name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: teamNumber,
                  cursorColor: Colors.amber,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber, width: 2.0),
                    ),
                    border: OutlineInputBorder(),
                    hintText: 'Team Number',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: weight,
                        cursorColor: Colors.amber,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.amber, width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'Weight?',
                        ),
                      ),
                    ),
                    SizedBox(width: 10), // Space between the text fields
                    Expanded(
                      child: TextField(
                        controller: dimensions,
                        cursorColor: Colors.amber,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.amber, width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'Dimensions?',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: mechanisms,
                  cursorColor: Colors.amber,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber, width: 2.0),
                    ),
                    border: OutlineInputBorder(),
                    hintText: '# of mechanisms/subsystems?',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DropdownButton<String>(
                      value: drivetrainValue,
                      icon: const Icon(Icons.arrow_drop_down),
                      onChanged: (String? value) {
                        setState(() {
                          drivetrainValue = value!;
                          // Optionally reset the second dropdown when the first is changed
                          if (drivetrainValue != 'Swerve') {
                            swerveValue =
                                null; // Clear second dropdown selection
                          }
                        });
                      },
                      items: drivetrainList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    // Show the second dropdown only if a specific option is selected
                    if (drivetrainValue == 'Swerve')
                      DropdownButton<String>(
                        value: swerveValue,
                        icon: const Icon(Icons.arrow_drop_down),
                        onChanged: (String? value) {
                          setState(() {
                            swerveValue = value!;
                            if (swerveValue != 'SDS') {
                              SDSValue =
                                  null; // Clear second dropdown selection
                            }
                            if (swerveValue != 'WCP') {
                              WCPValue =
                                  null; // Clear second dropdown selection
                            }
                            if (swerveValue != 'Thrifty Bot') {
                              thriftyBotValue =
                                  null; // Clear second dropdown selection
                            }
                          });
                        },
                        items: swerveList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    if (swerveValue == 'SDS')
                      DropdownButton<String>(
                        value: SDSValue,
                        icon: const Icon(Icons.arrow_drop_down),
                        onChanged: (String? value) {
                          setState(() {
                            SDSValue = value!;
                          });
                        },
                        items: SDSList.map<DropdownMenuItem<String>>(
                            (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    if (swerveValue == 'WCP')
                      DropdownButton<String>(
                        value: WCPValue,
                        icon: const Icon(Icons.arrow_drop_down),
                        onChanged: (String? value) {
                          setState(() {
                            WCPValue = value!;
                          });
                        },
                        items: WCPList.map<DropdownMenuItem<String>>(
                            (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    if (swerveValue == 'Thrifty Bot')
                      DropdownButton<String>(
                        value: thriftyBotValue,
                        icon: const Icon(Icons.arrow_drop_down),
                        onChanged: (String? value) {
                          setState(() {
                            thriftyBotValue = value!;
                          });
                        },
                        items: thriftyBotList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: drivetrainMotors,
                  cursorColor: Colors.amber,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber, width: 2.0),
                    ),
                    border: OutlineInputBorder(),
                    hintText: 'Drivetrain motors?',
                  ),
                ),
              ),
            ],
          ),
        ),
        Card(
            shadowColor: Colors.transparent,
            margin: const EdgeInsets.all(8.0),
            child: Column(children: [
              Row(
                children: [
                  Checkbox(
                    value: troughValue,
                    activeColor: Colors.amber,
                    onChanged: (newValue) {
                      setState(() {
                        troughValue = newValue!;
                      });
                    },
                  ),
                  Text("Trough?"),
                ],
              ),
            ])),
        Card(
            shadowColor: Colors.transparent,
            margin: const EdgeInsets.all(8.0),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: cycles,
                  cursorColor: Colors.amber,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber, width: 2.0),
                    ),
                    border: OutlineInputBorder(),
                    hintText: 'Cycles?',
                  ),
                ),
              ),
            ]))
      ][currentPageIndex],
    );
  }
}
