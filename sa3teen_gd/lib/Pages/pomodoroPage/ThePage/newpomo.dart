import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/customAppBar.dart';

import '../../BottomAppBar/BottomBar.dart';



// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: PomodoroTimer(),));
// }
void main() {
   SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Color(0xFF3C8243)));
  runApp( MaterialApp(
       
    debugShowCheckedModeBanner: false,
    home: PomodoroTimer(),
  ));
}


// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(
//         const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
//     return MaterialApp(
      
//       // title: 'Pomodoro Timer',
//       // theme: ThemeData(
//       //   primarySwatch: Colors.blue,
//       // ),
//       home: PomodoroTimer(),
//     );
//   }
// }

class PomodoroTimer extends StatefulWidget {
  @override
  _PomodoroTimerState createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer> {
  int _studyTime = 25;
  int _breakTime = 5;
  int _longBreakTime = 15;
  int _currentTimer = 0;
  int _iterations = 0;
  int _longBreakInterval = 3; // Default interval
  bool _isRunning = false;
  bool _showPauseButton = false;
  bool _showContinueButton = false;
  String _timerText = '25:00'; //////////////////////////////////
  int _remainingSeconds = 0;

  Timer? _timer;
void _resetValues() {
    setState(() {
      _studyTime = 25;
      _breakTime = 5;
      _longBreakTime = 15;
      _currentTimer = 0;
      _iterations = 0;
      _longBreakInterval = 3;
      _isRunning = false;
      _showPauseButton = false;
      _showContinueButton = false;
      _timerText = '25:00';
      _remainingSeconds = 0;
    });}




Widget _buildResetButton() {
    if (!_isRunning && !_showPauseButton && !_showContinueButton) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: ElevatedButton(
          onPressed: _resetValues,
           style: ElevatedButton.styleFrom(
                       
                        backgroundColor: kprimaryColourGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
          child: Text('Restore Defualt',style: TextStyle(color: Colors.white),),
        ),
      );
    } else {
      return SizedBox(); // Return an empty SizedBox if the conditions are not met
    }
  }





  void startTimer(int minutes) {
    int seconds = _remainingSeconds > 0 ? _remainingSeconds : minutes * 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
          int minutes = seconds ~/ 60;
          int remainingSeconds = seconds % 60;
          _timerText = '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
          _remainingSeconds = seconds;
        } else {
          _timer!.cancel();
          if (_currentTimer == 0) {
            _iterations++;
            if (_iterations % _longBreakInterval == 0) {
              _currentTimer = 2;
              _timerText = '$_longBreakTime:00';
            } else {
              _currentTimer = 1;
              _timerText = '$_breakTime:00';
            }
          } else {
            _currentTimer = 0;
            _timerText = '$_studyTime:00';
          }
          _isRunning = false;
          _showPauseButton = false;
          _showContinueButton = false;
        }
      });
    });
    _isRunning = true;
    _showPauseButton = true;
    _showContinueButton = false;
  }

  void pauseTimer() {
    if (_isRunning) {
      _timer?.cancel();
      _isRunning = false;
      _showPauseButton = false;
      _showContinueButton = true;
    }
    setState(() {});
  }

  void restartTimer() {
  pauseTimer();
  setState(() {
    _remainingSeconds = 0;
    if (_currentTimer == 0) {
      _timerText = '$_studyTime:00';
    } else if (_currentTimer == 1) {
      _timerText = '$_breakTime:00';
    } else {
      _timerText = '$_longBreakTime:00';
    }
    _showPauseButton = false;
    _showContinueButton = false;
  });
}


  void continueTimer() {
    if (!_isRunning) {
      _isRunning = true;
      startTimer(_remainingSeconds ~/ 60);
      _showPauseButton = true;
      _showContinueButton = false;
    }
    setState(() {});
  }

  Future<void> _showEditTimeDialog(String title, int initialValue) async {
    TextEditingController controller = TextEditingController(text: initialValue.toString());

    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit $title'),
          content: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Enter time in minutes',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a value';
              }
              return null;
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel',style: TextStyle(color: kprimaryColourGreen),),
            ),
            TextButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  int newValue = int.parse(controller.text);
                  if (newValue > 0) {
                    setState(() {
                      if (title == 'Study Time') {
                        _studyTime = newValue;
                      } else if (title == 'Break Time') {
                        _breakTime = newValue;
                      } else if (title == 'Long Break Time') {
                        _longBreakTime = newValue;
                      }
                      restartTimer();
                    });
                    Navigator.pop(context);
                  }
                }
              },
              child: Text('OK',style: TextStyle(color: kprimaryColourGreen)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kprimaryColourWhite,
      // appBar: AppBar(
      //   title: Text('Pomodoro Timer'),
      // ),
      body: Center(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomAppBar(title: 'Pomodoro'),
                SizedBox(height: 30,),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: CircularProgressIndicator(
                        value: _isRunning
                            ? 1 - (_remainingSeconds / (_currentTimer == 0 ? _studyTime * 60.0 : (_currentTimer == 1 ? _breakTime * 60.0 : _longBreakTime * 60.0)))
                            : 0,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                        strokeWidth: 20,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Add implementation to handle timer click
                      },
                      child: Text(
                        _timerText,
                        style: TextStyle(fontSize: 30, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTimeContainer('Study Time', '$_studyTime minutes'),
                    SizedBox(width: 20),
                    _buildTimeContainer('Break Time', '$_breakTime minutes'),
                    SizedBox(width: 20),
                    _buildTimeContainer('Long Break Time', '$_longBreakTime minutes'),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Long Break Interval: '),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (_longBreakInterval > 1) {
                            _longBreakInterval--;
                          }
                        });
                      },
                      icon: Icon(Icons.remove),
                    ),
                    Text('$_longBreakInterval'),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _longBreakInterval++;
                        });
                      },
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
                SizedBox(height: 13),
                if (!_isRunning && !_showPauseButton && !_showContinueButton)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                           
                            backgroundColor: kprimaryColourGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                    onPressed: () {
                      if (!_isRunning) {
                        startTimer(_currentTimer == 0 ? _studyTime : (_currentTimer == 1 ? _breakTime : _longBreakTime));
                      }
                    },
                    child: Text('Start Timer',style: TextStyle(color: Colors.white),),
                  ),
                if (_showPauseButton)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                           
                            backgroundColor: kprimaryColourGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                      onPressed: pauseTimer,
                      child: Text('Pause Timer',style: TextStyle(color: Colors.white),),
                    ),
                  ),
                if (_showContinueButton)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                           
                            backgroundColor: kprimaryColourGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                      onPressed: continueTimer,
                      child: Text('Continue Timer',style: TextStyle(color: Colors.white),),
                    ),
                  ),
                if (_isRunning || _showPauseButton || _showContinueButton)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                           
                            backgroundColor: kprimaryColourGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                      onPressed: restartTimer,
                      child: Text('Restart Timer',style: TextStyle(color: Colors.white),),
                    ),
                  ),
              SizedBox(height: 20),
                // ElevatedButton(
                //   onPressed: _resetValues,
                //   child: Text('Reset Timer'),
                // ),
                 _buildResetButton(),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),

    );
  }

  Widget _buildTimeContainer(String title, String time) {
    return GestureDetector(
      onTap: () {
        _showEditTimeDialog(title, title == 'Study Time' ? _studyTime : (title == 'Break Time' ? _breakTime : _longBreakTime));
      },
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.green),
            ),
            child: Text(
              time,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  if (!_isRunning) {
                    setState(() {
                      if (title == 'Study Time') {
                        _studyTime++;
                      } else if (title == 'Break Time') {
                        _breakTime++;
                      } else {
                        _longBreakTime++;
                      }
                      restartTimer();
                    });
                  }
                },
                icon: Icon(Icons.add),
              ),
              IconButton(
                onPressed: () {
                  if (!_isRunning) {
                    setState(() {
                      if (title == 'Study Time' && _studyTime > 1) {
                        _studyTime--;
                      } else if (title == 'Break Time' && _breakTime > 1) {
                        _breakTime--;
                      } else if (title == 'Long Break Time' && _longBreakTime > 1) {
                        _longBreakTime--;
                      }
                      restartTimer();
                    });
                  }
                },
                icon: Icon(Icons.remove),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}














// // //sucssess version 6.1 with long timer interval with + - instead of text feild

// import 'dart:async';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Pomodoro Timer',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: PomodoroTimer(),
//     );
//   }
// }

// class PomodoroTimer extends StatefulWidget {
//   @override
//   _PomodoroTimerState createState() => _PomodoroTimerState();
// }

// class _PomodoroTimerState extends State<PomodoroTimer> {
//   int _studyTime = 25;
//   int _breakTime = 5;
//   int _longBreakTime = 15;
//   int _currentTimer = 0;
//   int _iterations = 0;
//   int _longBreakInterval = 3; // Default interval
//   bool _isRunning = false;
//   bool _showPauseButton = false;
//   bool _showContinueButton = false;
//   String _timerText = '25:00';
//   int _remainingSeconds = 0;

//   Timer? _timer;

//   void startTimer(int minutes) {
//     int seconds = _remainingSeconds > 0 ? _remainingSeconds : minutes * 60;
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         if (seconds > 0) {
//           seconds--;
//           int minutes = seconds ~/ 60;
//           int remainingSeconds = seconds % 60;
//           _timerText = '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
//           _remainingSeconds = seconds;
//         } else {
//           _timer!.cancel();
//           if (_currentTimer == 0) {
//             _iterations++;
//             if (_iterations % _longBreakInterval == 0) {
//               _currentTimer = 2;
//               _timerText = '$_longBreakTime:00';
//             } else {
//               _currentTimer = 1;
//               _timerText = '$_breakTime:00';
//             }
//           } else {
//             _currentTimer = 0;
//             _timerText = '$_studyTime:00';
//           }
//           _isRunning = false;
//           _showPauseButton = false;
//           _showContinueButton = false;
//         }
//       });
//     });
//     _isRunning = true;
//     _showPauseButton = true;
//     _showContinueButton = false;
//   }

//   void pauseTimer() {
//     if (_isRunning) {
//       _timer?.cancel();
//       _isRunning = false;
//       _showPauseButton = false;
//       _showContinueButton = true;
//     }
//     setState(() {});
//   }

//   void restartTimer() {
//     pauseTimer();
//     setState(() {
//       _remainingSeconds = 0;
//       _timerText = '$_studyTime:00';
//       _showPauseButton = false;
//       _showContinueButton = false;
//     });
//   }

//   void continueTimer() {
//     if (!_isRunning) {
//       _isRunning = true;
//       startTimer(_remainingSeconds ~/ 60);
//       _showPauseButton = true;
//       _showContinueButton = false;
//     }
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Pomodoro Timer'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Stack(
//               alignment: Alignment.center,
//               children: [
//                 SizedBox(
//                   width: 200,
//                   height: 200,
//                   child: CircularProgressIndicator(
//                     value: _isRunning
//                         ? 1 - (_remainingSeconds / (_currentTimer == 0 ? _studyTime * 60.0 : (_currentTimer == 1 ? _breakTime * 60.0 : _longBreakTime * 60.0)))
//                         : 0,
//                     backgroundColor: Colors.grey[300],
//                     valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
//                     strokeWidth: 20,
//                   ),
//                 ),
//                 Text(
//                   _timerText,
//                   style: TextStyle(fontSize: 30, color: Colors.grey),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 _buildTimeContainer('Study Time', '$_studyTime minutes'),
//                 SizedBox(width: 20),
//                 _buildTimeContainer('Break Time', '$_breakTime minutes'),
//                 SizedBox(width: 20),
//                 _buildTimeContainer('Long Break Time', '$_longBreakTime minutes'),
//               ],
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('Long Break Interval: '),
//                 IconButton(
//                   onPressed: () {
//                     setState(() {
//                       if (_longBreakInterval > 1) {
//                         _longBreakInterval--;
//                       }
//                     });
//                   },
//                   icon: Icon(Icons.remove),
//                 ),
//                 Text('$_longBreakInterval'),
//                 IconButton(
//                   onPressed: () {
//                     setState(() {
//                       _longBreakInterval++;
//                     });
//                   },
//                   icon: Icon(Icons.add),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             if (!_isRunning && !_showPauseButton && !_showContinueButton)
//               ElevatedButton(
//                 onPressed: () {
//                   if (!_isRunning) {
//                     startTimer(_currentTimer == 0 ? _studyTime : (_currentTimer == 1 ? _breakTime : _longBreakTime));
//                   }
//                 },
//                 child: Text('Start Timer'),
//               ),
//             if (_showPauseButton)
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 child: ElevatedButton(
//                   onPressed: pauseTimer,
//                   child: Text('Pause Timer'),
//                 ),
//               ),
//             if (_showContinueButton)
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 child: ElevatedButton(
//                   onPressed: continueTimer,
//                   child: Text('Continue Timer'),
//                 ),
//               ),
//             if (_isRunning || _showPauseButton || _showContinueButton)
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 child: ElevatedButton(
//                   onPressed: restartTimer,
//                   child: Text('Restart Timer'),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTimeContainer(String title, String time) {
//     return Column(
//       children: [
//         Text(
//           title,
//           style: TextStyle(color: Colors.grey),
//         ),
//         SizedBox(height: 5),
//         Container(
//           padding: EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(color: Colors.green),
//           ),
//           child: Text(
//             time,
//             style: TextStyle(color: Colors.grey),
//           ),
//         ),
//         SizedBox(height: 5),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             IconButton(
//               onPressed: () {
//                 if (!_isRunning) {
//                   setState(() {
//                     if (title == 'Study Time') {
//                       _studyTime++;
//                     } else if (title == 'Break Time') {
//                       _breakTime++;
//                     } else {
//                       _longBreakTime++;
//                     }
//                     restartTimer();
//                   });
//                 }
//               },
//               icon: Icon(Icons.add),
//             ),
//             IconButton(
//               onPressed: () {
//                 if (!_isRunning) {
//                   setState(() {
//                     if (title == 'Study Time' && _studyTime > 1) {
//                       _studyTime--;
//                     } else if (title == 'Break Time' && _breakTime > 1) {
//                       _breakTime--;
//                     } else if (title == 'Long Break Time' && _longBreakTime > 1) {
//                       _longBreakTime--;
//                     }
//                     restartTimer();
//                   });
//                 }
//               },
//               icon: Icon(Icons.remove),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }
// }