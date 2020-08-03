import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

// import 'package:flutter_tts/flutter_tts.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  _showDialogue() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Submitted"),
        );
      },
    );
  }

  final Map<String, HighlightedWord> _highlights = {
    'Male': HighlightedWord(
      onTap: () => print('flutter'),
      textStyle: const TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      ),
    ),
    'Female': HighlightedWord(
      onTap: () => print('voice'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
    'subscribe': HighlightedWord(
      onTap: () => print('subscribe'),
      textStyle: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    ),
    'like': HighlightedWord(
      onTap: () => print('like'),
      textStyle: const TextStyle(
        color: Colors.blueAccent,
        fontWeight: FontWeight.bold,
      ),
    ),
    'comment': HighlightedWord(
      onTap: () => print('comment'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
  };

  stt.SpeechToText _sname, _sgender, _scattles, _smobile;
  bool _isListening = false;
  String _text = '--';
  String _text1 = '--';
  String _text2 = '--';
  String _text3 = '--';
  String _text4 = '--';
  String _text5 = '--';
  String _text6 = '--';
  String _text7 = '--';
  String _text8 = '--';

  double _confidence = 1.0;
  String _flag = "name";

  Future _sequence(String _flag) async {
    print("flag: " + _flag);
    switch (_flag) {
      case "name":
        _speakName("Please Enter your Name");
        // _listenName();
        break;
      case "gender":
        _speakGender("Please tell your Gender");
        // _listenGender();
        break;
      case "cattles":
        _speakCattle("please tell the count of cattles");
        // _listenCattles();
        break;
      case "mobile":
        _speakNumber("Please enter Mobile number");
        // _listenMobile();
        break;
      case "state":
        _speakState("Please enter Your State");
        // _listenMobile();
        break;
      case "district":
        _speakDistrict("Please enter District ");
        // _listenMobile();
        break;
      case "submit":
        _speakSubmit("Speak Submit when ready");
        // _listenMobile();
        break;
      default:
        _speak("Ready to submit");
    }
  }

  Future _speak(String tospeak) async {
    await flutterTts.speak(tospeak);
  }

  Future _speakName(String tospeak) async {
    await flutterTts.speak(tospeak).whenComplete(() => _listenName());
  }

  Future _speakGender(String tospeak) async {
    await flutterTts.speak(tospeak).whenComplete(() => _listenGender());
  }

  Future _speakCattle(String tospeak) async {
    await flutterTts.speak(tospeak).whenComplete(() => _listenCattles());
  }

  Future _speakNumber(String tospeak) async {
    await flutterTts.speak(tospeak).whenComplete(() => _listenMobile());
  }

  Future _speakState(String tospeak) async {
    await flutterTts.speak(tospeak).whenComplete(() => _listenState());
  }

  Future _speakDistrict(String tospeak) async {
    await flutterTts.speak(tospeak).whenComplete(() => _listenDistrict());
  }

  Future _speakSubmit(String tospeak) async {
    await flutterTts.speak(tospeak).whenComplete(() => _listenSubmit());
  }

  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _sname = stt.SpeechToText();
    _sgender = stt.SpeechToText();
    _scattles = stt.SpeechToText();
    _smobile = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Voice Assistance'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AvatarGlow(
          animate: _isListening,
          glowColor: Theme.of(context).primaryColor,
          endRadius: 75.0,
          duration: const Duration(milliseconds: 2000),
          repeatPauseDuration: const Duration(milliseconds: 100),
          repeat: true,
          child: FloatingActionButton(
            onPressed: () async {
              await _sequence(_flag);
            },
            child: Icon(_isListening ? Icons.mic : Icons.mic_none),
          ),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Card(
                child: Row(children: <Widget>[
                  Text("Enter name: ", textScaleFactor: 1.5),
                  TextHighlight(
                      text: _text,
                      words: _highlights,
                      textStyle: const TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                      )),
                ]),
              ),
              Row(
                children: <Widget>[
                  Text(
                    "Gender: ",
                    textScaleFactor: 1.5,
                  ),
                  Text(_text1, textScaleFactor: 1.5)
                ],
              ),
              Row(
                children: <Widget>[
                  Text("Cattles: ", textScaleFactor: 1.5),
                  Text(_text2, textScaleFactor: 1.5)
                ],
              ),
              Row(
                children: <Widget>[
                  Text("Mobilenumber: ", textScaleFactor: 1.5),
                  Text(_text3, textScaleFactor: 1.5)
                ],
              ),
              Row(
                children: <Widget>[
                  Text("State: ", textScaleFactor: 1.5),
                  Text(_text4, textScaleFactor: 1.5)
                ],
              ),
              Row(
                children: <Widget>[
                  Text("District: ", textScaleFactor: 1.5),
                  Text(_text5, textScaleFactor: 1.5)
                ],
              ),
            ],
          ),
        ));
  }

  Future _listenGender() async {
    if (!_isListening) {
      bool available = await _sgender.initialize(
          onStatus: (val) => print('gender onStatus: $val'),
          onError: (val) {
            print('gender onError: $val');
            _speak("please speak again");

            _isListening = false;
            _listenGender();
          });
      if (available) {
        setState(() => _isListening = true);
        _sgender.listen(
          onResult: (val) => setState(() {
            print("gender:" + val.recognizedWords);
            if (val.recognizedWords == " ") {
              _flag = "gender";
            }
            if (val.recognizedWords == "mail" ||
                val.recognizedWords == "male") {
              _text1 = "male";
            } else if (val.recognizedWords == "female") {
              _text1 = "female";
            }
            _flag = "cattles";
            _isListening = false;
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _sgender.stop();
    }
  }

  Future _listenCattles() async {
    if (!_isListening) {
      bool available = await _scattles.initialize(
          onStatus: (val) => print('cattles: onStatus: $val'),
          onError: (val) {
            print('cattles: onError: $val');
            _speak(" please speak again");
            _isListening = false;
            _listenCattles();
          });
      if (available) {
        setState(() => _isListening = true);
        _scattles.listen(
          onResult: (val) => setState(() {
            print("cattles: " + val.recognizedWords);
            if (val.recognizedWords == " ") {
              _flag = "cattles";
            }
            _text2 = val.recognizedWords;
            _flag = "mobile";
            _isListening = false;

            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _scattles.stop();
    }
  }

  Future _listenMobile() async {
    if (!_isListening) {
      bool available = await _smobile.initialize(
          onStatus: (val) => print('mobile: onStatus: $val'),
          onError: (val) {
            print('mobile onError: $val');
            _speak("Sorry Didn't hear that,");
            _isListening = false;
            _listenMobile();
          });
      if (available) {
        setState(() => _isListening = true);
        _smobile.listen(
          onResult: (val) => setState(() {
            print("mobile: " + val.recognizedWords);
            if (val.recognizedWords == " ") {
              _flag = "mobile";
            }
            _text3 = val.recognizedWords;
            _flag = "state";
            setState(() {
              _isListening = false;
            });
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _smobile.stop();
    }
  }

  Future _listenState() async {
    if (!_isListening) {
      bool available = await _sgender.initialize(
          onStatus: (val) => print('gender onStatus: $val'),
          onError: (val) {
            print('gender onError: $val');
            _speak("please speak again");

            _isListening = false;
            _listenGender();
          });
      if (available) {
        setState(() => _isListening = true);
        _sgender.listen(
          onResult: (val) => setState(() {
            print("state:" + val.recognizedWords);
            if (val.recognizedWords == " ") {
              _flag = "state";
            }
            _text4 = val.recognizedWords;
            _flag = "district";
            _isListening = false;
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _sgender.stop();
    }
  }

  Future _listenDistrict() async {
    if (!_isListening) {
      bool available = await _sgender.initialize(
          onStatus: (val) => print('gender onStatus: $val'),
          onError: (val) {
            print('gender onError: $val');
            _speak("please speak again");

            _isListening = false;
            _listenGender();
          });
      if (available) {
        setState(() => _isListening = true);
        _sgender.listen(
          onResult: (val) => setState(() {
            print("district: " + val.recognizedWords);
            _text5 = val.recognizedWords;
            _flag = "submit";
            _isListening = false;
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _sgender.stop();
    }
  }

  Future _listenSubmit() async {
    if (!_isListening) {
      bool available = await _sgender.initialize(
          onStatus: (val) => print('gender onStatus: $val'),
          onError: (val) {
            print('gender onError: $val');
            _speak("please speak again");

            _isListening = false;
            _listenGender();
          });
      if (available) {
        setState(() => _isListening = true);
        _sgender.listen(
          onResult: (val) => setState(() {
            print("submit: " + val.recognizedWords);
            if (val.recognizedWords == " ") {
              _flag = "--";
            }
            _text6 = val.recognizedWords;
            if (_text6 == "submit") {
              print("Submitted");
              _showDialogue();
            }
            _flag = "submit";
            _isListening = false;
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _sgender.stop();
    }
  }

  Future _listenName() async {
    if (!_isListening) {
      bool available = await _sname.initialize(
          onStatus: (val) => print('name :onStatus: $val'),
          onError: (val) {
            print('name onError: $val');
            _speak("please speak again");

            _isListening = false;
            print(_flag);
            switch (_flag) {
              case "name":
                _listenName();
                // _listenName();
                break;
              case "gender":
                _flag = "name";
                _listenName();
                break;
              case "cattles":
                _flag = "gender";
                _listenGender();
                break;
              case "mobile":
                _flag = "cattle";
                _listenCattles();
                break;
              case "state":
                _flag = "mobile";
                _listenMobile();
                break;
              case "district":
                _flag = "state";
                _listenState();
                break;
              case "Submit":
                _flag = "district";
                _listenDistrict();
            }
          });
      if (available) {
        setState(() => _isListening = true);
        _sname.listen(
          onResult: (val) => setState(() {
            print("name: " + val.recognizedWords);
            if (val.recognizedWords == " ") {
              _flag = "name";
            }
            _text = val.recognizedWords;
            _flag = "gender";
            _isListening = false;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _sname.stop();
    }
  }
}
