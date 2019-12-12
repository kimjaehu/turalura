import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:turalura/widgets/provider_widget.dart';

class AddView extends StatefulWidget {
  @override
  _AddViewState createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  final db = Firestore.instance;
  TextEditingController _nameController = new TextEditingController();
  DateTime _date = new DateTime.now();
  DateTime _dateOfBirth;
  bool _dateValidator;
  bool _nameValidator;
  List<bool> isSelected;
  String gender = 'boy';
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    isSelected = [true, false];
    _dateValidator = true;
    _nameValidator = false;
    _dateOfBirth = _date;
  }

  Widget genderToggleButton() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ToggleButtons(
            color: isSelected[0] ? Colors.pink : Colors.blue,
            borderColor: isSelected[0] ? Colors.blue : Colors.pink,
            fillColor: isSelected[0] ? Colors.blue : Colors.pink,
            borderWidth: 2,
            selectedBorderColor: isSelected[0] ? Colors.blue : Colors.pink,
            selectedColor: Colors.white,
            renderBorder: false,
            // borderRadius: BorderRadius.circular(5.0),
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.face,
                        size: 80.0,
                      ),
                      Text(
                        'Boy',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
              Padding(
                  padding: const EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.face,
                        size: 80.0,
                      ),
                      Text(
                        'Girl',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
            ],
            onPressed: (int index) {
              FocusScope.of(context).requestFocus(new FocusNode());
              setState(() {
                for (int i = 0; i < isSelected.length; i++) {
                  if (i == index) {
                    isSelected[i] = true;
                    gender = "girl";
                  } else {
                    isSelected[i] = false;
                    gender = "boy";
                  }
                }
              });
            },
            isSelected: isSelected,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('New Baby'),
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            margin: EdgeInsets.only(right: 5.0, left: 5.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: height * 0.05,
                ),
                genderToggleButton(),
                SizedBox(
                  height: height * 0.05,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                  child: TextField(
                    key: _formKey,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        // labelText: "My Baby's Name",
                        alignLabelWithHint: false,
                        errorText:
                            _nameValidator ? 'Name can\'t be empty' : null,
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: "Enter Baby's Name",
                        hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontWeight: FontWeight.bold,
                            fontSize: 35.0)),
                    controller: _nameController,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Date of birth",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                  ),
                ),
                SizedBox(
                  height: height * 0.20,
                  child: CupertinoDatePicker(
                    initialDateTime: _date,
                    minimumDate: _date,
                    maximumDate: _date,
                    maximumYear: _date.year,
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (pickedDate) {
                      print("$pickedDate, $_date");
                      if (pickedDate.isBefore(_date)) {
                        setState(() {
                          _dateValidator = true;
                          _dateOfBirth = pickedDate;
                        });
                      } else {
                        setState(() {
                          _dateValidator = false;
                          _dateOfBirth = null;
                        });
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                

                ClipOval(
              child: Material(
                    color: _dateValidator ? Colors.deepPurple : Colors.grey[400], // button color
                    child: InkWell(
                      splashColor: Colors.white, // inkwell color
                      child:
                          SizedBox(width: 65, height: 65, child: Icon(_dateValidator ? Icons.check : Icons.close,size: 35, color: Colors.white,)),
                      onTap: () async {
                        setState(() {
                      _nameController.text.isEmpty
                          ? _nameValidator = true
                          : _nameValidator = false;
                    });

                    if (_dateValidator || _nameValidator) {
                      final uid =
                          await Provider.of(context).auth.getCurrentUID();
                      await db
                          .collection("babies")
                          .document(uid)
                          .collection('userBabies')
                          .add({
                        'name': _nameController.text,
                        'dob': _dateOfBirth,
                        'gender': gender,
                        'timestamp': _date,
                      });
                      // 1) update user info
                      await db.collection("users").document(uid).updateData({
                        'currentBaby': _nameController.text,
                        'dob': _dateOfBirth,
                      });

                      // 2) create summaries
                      await db
                          .collection("summaries")
                          .document(uid)
                          .collection((_nameController.text).toLowerCase())
                          .document("summary")
                          .setData({
                        'dob': _dateOfBirth,
                        'gender': gender,
                        'milestonesCompleted': null,
                        'milestonesCount': null,
                        'lastUpdated': null,
                        'unit': null,
                        'height': null,
                        'weight': null,
                        'heightPercentile': null,
                        'weightPercentile': null,
                        'name': _nameController.text,
                      });

                      // 3) create milestones
                      await db.collection("milestones").document(uid).setData({
                        "2": {
                          '1': false,
                          '2': false,
                          '3': false,
                          '4': false,
                          '5': false,
                          '6': false,
                          '7': false,
                          '8': false,
                          '9': false,
                          '10': false,
                        },
                        "4": {
                          '1': false,
                          '2': false,
                          '3': false,
                          '4': false,
                          '5': false,
                          '6': false,
                          '7': false,
                          '8': false,
                          '9': false,
                          '10': false,
                          '11': false,
                          '12': false,
                          '13': false,
                          '14': false,
                          '15': false,
                          '16': false,
                          '17': false,
                          '18': false,
                          '19': false,
                        },
                        "6": {
                          '1': false,
                          '2': false,
                          '3': false,
                          '4': false,
                          '5': false,
                          '6': false,
                          '7': false,
                          '8': false,
                          '9': false,
                          '10': false,
                          '11': false,
                          '12': false,
                          '13': false,
                          '14': false,
                          '15': false,
                          '16': false,
                          '17': false,
                        },
                        "9": {
                          '1': false,
                          '2': false,
                          '3': false,
                          '4': false,
                          '5': false,
                          '6': false,
                          '7': false,
                          '8': false,
                          '9': false,
                          '10': false,
                          '11': false,
                          '12': false,
                          '13': false,
                          '14': false,
                          '15': false,
                          '16': false,
                          '17': false,
                          '18': false,
                        },
                        "12": {
                          '1': false,
                          '2': false,
                          '3': false,
                          '4': false,
                          '5': false,
                          '6': false,
                          '7': false,
                          '8': false,
                          '9': false,
                          '10': false,
                          '11': false,
                          '12': false,
                          '13': false,
                          '14': false,
                          '15': false,
                          '16': false,
                          '17': false,
                          '18': false,
                          '19': false,
                          '20': false,
                          '21': false,
                          '22': false,
                          '23': false,
                          '24': false,
                          '25': false,
                          '26': false,
                          '27': false,
                        },
                        "18": {
                          '1': false,
                          '2': false,
                          '3': false,
                          '4': false,
                          '5': false,
                          '6': false,
                          '7': false,
                          '8': false,
                          '9': false,
                          '10': false,
                          '11': false,
                          '12': false,
                          '13': false,
                          '14': false,
                          '15': false,
                          '16': false,
                          '17': false,
                          '18': false,
                          '19': false,
                          '20': false,
                          '21': false,
                          '22': false,
                          '23': false,
                        },
                        "24": {
                          '1': false,
                          '2': false,
                          '3': false,
                          '4': false,
                          '5': false,
                          '6': false,
                          '7': false,
                          '8': false,
                          '9': false,
                          '10': false,
                          '11': false,
                          '12': false,
                          '13': false,
                          '14': false,
                          '15': false,
                          '16': false,
                          '17': false,
                          '18': false,
                          '19': false,
                          '20': false,
                          '21': false,
                          '22': false,
                          '23': false,
                          '24': false,
                          '25': false,
                          '26': false,
                        },
                        "36": {
                          '1': false,
                          '2': false,
                          '3': false,
                          '4': false,
                          '5': false,
                          '6': false,
                          '7': false,
                          '8': false,
                          '9': false,
                          '10': false,
                          '11': false,
                          '12': false,
                          '13': false,
                          '14': false,
                          '15': false,
                          '16': false,
                          '17': false,
                          '18': false,
                          '19': false,
                          '20': false,
                          '21': false,
                          '22': false,
                          '23': false,
                          '24': false,
                          '25': false,
                          '26': false,
                          '27': false,
                          '28': false,
                          '29': false,
                        },
                        "48": {
                          '1': false,
                          '2': false,
                          '3': false,
                          '4': false,
                          '5': false,
                          '6': false,
                          '7': false,
                          '8': false,
                          '9': false,
                          '10': false,
                          '11': false,
                          '12': false,
                          '13': false,
                          '14': false,
                          '15': false,
                          '16': false,
                          '17': false,
                          '18': false,
                          '19': false,
                          '20': false,
                          '21': false,
                          '22': false,
                          '23': false,
                          '24': false,
                        },
                        "60": {
                          '1': false,
                          '2': false,
                          '3': false,
                          '4': false,
                          '5': false,
                          '6': false,
                          '7': false,
                          '8': false,
                          '9': false,
                          '10': false,
                          '11': false,
                          '12': false,
                          '13': false,
                          '14': false,
                          '15': false,
                          '16': false,
                          '17': false,
                          '18': false,
                          '19': false,
                          '20': false,
                          '21': false,
                          '22': false,
                          '23': false,
                        }
                      });

                      // 4) create delays
                      await db.collection("delays").document(uid).setData({
                        "2": {
                          '1': false,
                          '2': false,
                          '3': false,
                          '4': false,
                          '5': false,
                        },
                        "4": {
                          '1': false,
                          '2': false,
                          '3': false,
                          '4': false,
                          '5': false,
                          '6': false,
                          '7': false,
                        },
                        "6": {
                          '1': false,
                          '2': false,
                          '3': false,
                          '4': false,
                          '5': false,
                          '6': false,
                          '7': false,
                          '8': false,
                          '9': false,
                        },
                        "9": {
                          '1': false,
                          '2': false,
                          '3': false,
                          '4': false,
                          '5': false,
                          '6': false,
                          '7': false,
                          '8': false,
                        },
                        "12": {
                          '1': false,
                          '2': false,
                          '3': false,
                          '4': false,
                          '5': false,
                          '6': false,
                          '7': false,
                        },
                        "18": {
                          '1': false,
                          '2': false,
                          '3': false,
                          '4': false,
                          '5': false,
                          '6': false,
                          '7': false,
                          '8': false,
                        },
                        "24": {
                          '1': false,
                          '2': false,
                          '3': false,
                          '4': false,
                          '5': false,
                          '6': false,
                        },
                        "36": {
                          '1': false,
                          '2': false,
                          '3': false,
                          '4': false,
                          '5': false,
                          '6': false,
                          '7': false,
                          '8': false,
                          '9': false,
                        },
                        "48": {
                          '1': false,
                          '2': false,
                          '3': false,
                          '4': false,
                          '5': false,
                          '6': false,
                          '7': false,
                          '8': false,
                          '9': false,
                          '10': false,
                          '11': false,
                        },
                        "60": {
                          '1': false,
                          '2': false,
                          '3': false,
                          '4': false,
                          '5': false,
                          '6': false,
                          '7': false,
                          '8': false,
                          '9': false,
                          '10': false,
                          '11': false,
                          '12': false,
                          '13': false,
                        }
                      });
                      Navigator.of(context).pushReplacementNamed('/home');
                    } else {
                      Text('');
                    }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
