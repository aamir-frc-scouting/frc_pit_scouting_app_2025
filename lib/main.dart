import 'dart:io';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
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

enum BargeLevel { park, shallow, deep }

class _MyHomePageState extends State<MyHomePage> {
  String data = "";
  final TextEditingController scoutName = TextEditingController();
  final TextEditingController teamName = TextEditingController();
  final TextEditingController teamNumber = TextEditingController();
  final TextEditingController weight = TextEditingController();
  final TextEditingController dimensions = TextEditingController();
  final TextEditingController cycles = TextEditingController();
  final TextEditingController mechanisms = TextEditingController();
  final TextEditingController drivetrainMotors = TextEditingController();
  final TextEditingController hotswappable = TextEditingController();
  final TextEditingController climbTime = TextEditingController();
  final TextEditingController autoStart = TextEditingController();
  final TextEditingController visionTracking = TextEditingController();
  final TextEditingController programmingLanguage = TextEditingController();
  final TextEditingController autoInfo = TextEditingController();
  final TextEditingController bestAt = TextEditingController();
  final TextEditingController comments = TextEditingController();
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
  bool groundPickUpValue = false;
  bool stationPickUpValue = false;
  BargeLevel? level = BargeLevel.park;
  bool autoScoreAlgaeValue = false;
  bool autoScoreCoralValue = false;
  bool leaveValue = false;
  bool autoTakeOffAlgae = false;
  bool processorHPValue = false;
  bool stationHPValue = false;
  bool defenseValue = false;
  bool driveTeamSwitchValue = false;
  bool pictureValue = false;
  final ScrollController scrollController = ScrollController();
  late CameraController controller;
  bool isCameraInitialized = false;
  File? savedImage;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.high);
    await controller.initialize();
    setState(() {
      isCameraInitialized = true;
    });
  }

  Future<void> captureAndSaveImage() async {
    if (!controller.value.isInitialized) return;

    final XFile image = await controller.takePicture();
    final Directory dir = await getApplicationDocumentsDirectory();
    final File newImage = File('${dir.path}/captured_image.jpg');

    await File(image.path).copy(newImage.path);
    setState(() {
      savedImage = newImage;
    });

    print("Image saved at: ${newImage.path}");
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void scrollToTop() {
    scrollController.animateTo(
      0.0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

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
      teamName.text = "";
      teamNumber.text = "";
      weight.text = "";
      dimensions.text = "";
      cycles.text = "";
      mechanisms.text = "";
      drivetrainMotors.text = "";
      hotswappable.text = "";
      climbTime.text = "";
      autoStart.text = "";
      visionTracking.text = "";
      programmingLanguage.text = "";
      autoInfo.text = "";
      bestAt.text = "";
      comments.text = "";
      drivetrainValue = drivetrainList.first;
      swerveValue = swerveList.first;
      SDSValue = SDSList.first;
      WCPValue = WCPList.first;
      thriftyBotValue = thriftyBotList.first;
      troughValue = false;
      L2Value = false;
      L3Value = false;
      L4Value = false;
      netValue = false;
      processorValue = false;
      takeOffAlgaeValue = false;
      groundPickUpValue = false;
      stationPickUpValue = false;
      level = BargeLevel.park;
      autoScoreAlgaeValue = false;
      autoScoreCoralValue = false;
      leaveValue = false;
      autoTakeOffAlgae = false;
      processorHPValue = false;
      stationHPValue = false;
      defenseValue = false;
      driveTeamSwitchValue = false;
      pictureValue = false;
      scrollToTop();
    });
  }

  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Action"),
          content: Text(
              "Are you sure you want to save and clear all data? This action cannot be undone."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                resetData(); // Call your function to clear data
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Confirm", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text(
            widget.title,
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
            controller: scrollController,
            child: Column(children: [
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
                            borderSide:
                                BorderSide(color: Colors.amber, width: 2.0),
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
                            borderSide:
                                BorderSide(color: Colors.amber, width: 2.0),
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
                            borderSide:
                                BorderSide(color: Colors.amber, width: 2.0),
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
                                  borderSide: BorderSide(
                                      color: Colors.amber, width: 2.0),
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
                                  borderSide: BorderSide(
                                      color: Colors.amber, width: 2.0),
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
                            borderSide:
                                BorderSide(color: Colors.amber, width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: '# of mechanisms/subsystems?',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: drivetrainMotors,
                        cursorColor: Colors.amber,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.amber, width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'Drivetrain Motors?',
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
                              items: swerveList.map<DropdownMenuItem<String>>(
                                  (String value) {
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Can your robot score in the...",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          Text(
                            "Trough?",
                            style: TextStyle(
                              color: Colors.purpleAccent,
                            ),
                          ),
                          Checkbox(
                            value: L2Value,
                            activeColor: Colors.amber,
                            onChanged: (newValue) {
                              setState(() {
                                L2Value = newValue!;
                              });
                            },
                          ),
                          Text(
                            "L2?",
                            style: TextStyle(
                              color: Colors.purpleAccent,
                            ),
                          ),
                          Checkbox(
                            value: L3Value,
                            activeColor: Colors.amber,
                            onChanged: (newValue) {
                              setState(() {
                                L3Value = newValue!;
                              });
                            },
                          ),
                          Text(
                            "L3?",
                            style: TextStyle(
                              color: Colors.purpleAccent,
                            ),
                          ),
                          Checkbox(
                            value: L4Value,
                            activeColor: Colors.amber,
                            onChanged: (newValue) {
                              setState(() {
                                L4Value = newValue!;
                              });
                            },
                          ),
                          Text(
                            "L4?",
                            style: TextStyle(
                              color: Colors.purpleAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Checkbox(
                            value: netValue,
                            activeColor: Colors.amber,
                            onChanged: (newValue) {
                              setState(() {
                                netValue = newValue!;
                              });
                            },
                          ),
                          Text(
                            "Net?",
                            style: TextStyle(
                              color: Colors.tealAccent,
                            ),
                          ),
                          Checkbox(
                            value: processorValue,
                            activeColor: Colors.amber,
                            onChanged: (newValue) {
                              setState(() {
                                processorValue = newValue!;
                              });
                            },
                          ),
                          Text(
                            "Processor?",
                            style: TextStyle(
                              color: Colors.tealAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Checkbox(
                            value: takeOffAlgaeValue,
                            activeColor: Colors.amber,
                            onChanged: (newValue) {
                              setState(() {
                                takeOffAlgaeValue = newValue!;
                              });
                            },
                          ),
                          Text(
                            "Take off Algae?",
                            style: TextStyle(
                              color: Colors.tealAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Can your robot pick up from the...",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Checkbox(
                            value: groundPickUpValue,
                            activeColor: Colors.amber,
                            onChanged: (newValue) {
                              setState(() {
                                groundPickUpValue = newValue!;
                              });
                            },
                          ),
                          Text("Ground?"),
                          Checkbox(
                            value: stationPickUpValue,
                            activeColor: Colors.amber,
                            onChanged: (newValue) {
                              setState(() {
                                stationPickUpValue = newValue!;
                              });
                            },
                          ),
                          Text("Coral Station?"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: cycles,
                        cursorColor: Colors.amber,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.amber, width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'Cycles?',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: hotswappable,
                        cursorColor: Colors.amber,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.amber, width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'Hot Swappable?',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 8.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                'Climb Level',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12.0),
                              ListTile(
                                title: const Text('Park'),
                                leading: Radio<BargeLevel>(
                                  activeColor: Colors.amber,
                                  value: BargeLevel.park,
                                  groupValue: level,
                                  onChanged: (BargeLevel? value) {
                                    setState(() {
                                      level = value;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text('Shallow (high)'),
                                leading: Radio<BargeLevel>(
                                  activeColor: Colors.amber,
                                  value: BargeLevel.shallow,
                                  groupValue: level,
                                  onChanged: (BargeLevel? value) {
                                    setState(() {
                                      level = value;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text('Deep (low)'),
                                leading: Radio<BargeLevel>(
                                  activeColor: Colors.amber,
                                  value: BargeLevel.deep,
                                  groupValue: level,
                                  onChanged: (BargeLevel? value) {
                                    setState(() {
                                      level = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: climbTime,
                        cursorColor: Colors.amber,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.amber, width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'Climb Time?',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: visionTracking,
                        cursorColor: Colors.amber,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.amber, width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'Vision Tracking?',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: programmingLanguage,
                        cursorColor: Colors.amber,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.amber, width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'Programming Language?',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "What does your auto do...",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Checkbox(
                            value: leaveValue,
                            activeColor: Colors.amber,
                            onChanged: (newValue) {
                              setState(() {
                                leaveValue = newValue!;
                              });
                            },
                          ),
                          Text("Leave?"),
                          Checkbox(
                            value: autoScoreCoralValue,
                            activeColor: Colors.amber,
                            onChanged: (newValue) {
                              setState(() {
                                autoScoreCoralValue = newValue!;
                              });
                            },
                          ),
                          Text(
                            "Score Coral?",
                            style: TextStyle(
                              color: Colors.purpleAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Checkbox(
                            value: autoTakeOffAlgae,
                            activeColor: Colors.amber,
                            onChanged: (newValue) {
                              setState(() {
                                autoTakeOffAlgae = newValue!;
                              });
                            },
                          ),
                          Text(
                            "Take Off Algae?",
                            style: TextStyle(
                              color: Colors.tealAccent,
                            ),
                          ),
                          Checkbox(
                            value: autoScoreAlgaeValue,
                            activeColor: Colors.amber,
                            onChanged: (newValue) {
                              setState(() {
                                autoScoreAlgaeValue = newValue!;
                              });
                            },
                          ),
                          Text(
                            "Score Algae?",
                            style: TextStyle(
                              color: Colors.tealAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: autoStart,
                        cursorColor: Colors.amber,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.amber, width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'Auto Starting Position?',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: autoInfo,
                        cursorColor: Colors.amber,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.amber, width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'Additional Information',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Where do you prefer your HP?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: stationHPValue,
                                activeColor: Colors.amber,
                                onChanged: (newValue) {
                                  setState(() {
                                    stationHPValue = newValue!;
                                  });
                                },
                              ),
                              Text("Coral Station"),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: processorHPValue,
                                activeColor: Colors.amber,
                                onChanged: (newValue) {
                                  setState(() {
                                    processorHPValue = newValue!;
                                  });
                                },
                              ),
                              Text("Processor"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: bestAt,
                        cursorColor: Colors.amber,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.amber, width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'What is your robot best at?',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: driveTeamSwitchValue,
                                activeColor: Colors.amber,
                                onChanged: (newValue) {
                                  setState(() {
                                    driveTeamSwitchValue = newValue!;
                                  });
                                },
                              ),
                              Text("Switch out Drive Team?"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: defenseValue,
                                activeColor: Colors.amber,
                                onChanged: (newValue) {
                                  setState(() {
                                    defenseValue = newValue!;
                                  });
                                },
                              ),
                              Text("Open to Defense?"),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: pictureValue,
                                activeColor: Colors.amber,
                                onChanged: (newValue) {
                                  setState(() {
                                    pictureValue = newValue!;
                                  });
                                },
                              ),
                              Text("Picture?"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          isCameraInitialized
                              ? AspectRatio(
                                  aspectRatio: controller.value.aspectRatio,
                                  child: CameraPreview(controller),
                                )
                              : Center(child: CircularProgressIndicator()),
                          ElevatedButton(
                            onPressed: captureAndSaveImage,
                            child: Text("Capture & Save Image"),
                          ),
                          savedImage != null
                              ? Image.file(savedImage!)
                              : Text("No image captured"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: comments,
                        cursorColor: Colors.amber,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.amber, width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'Comments',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          onPressed: () {
                            showConfirmationDialog(context);
                          },
                          child: const Text(
                            'Save and Clear Data',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ])));
  }
}
