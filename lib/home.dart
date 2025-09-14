import 'package:flutter/material.dart';
import 'package:mealy_machine/transition_toggle_field_data_container.dart';
import 'transition_window.dart';
import 'transition_row_data_container.dart';
import 'transition_map.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  static const double _textContainerSpacing = 20;
  final List<TransitionRowDataContainer> _transitionRows = [];
  TransitionRowDataContainer? _toggleFieldInitValues;

  List<String> _states = [];
  List<String> _inputAlphabet = [];
  List<String> _outputAlphabet = [];
  String _startState = "";

  TransitionMap _map = TransitionMap();

  void _updateToggleFieldInitValues() {
    _toggleFieldInitValues = TransitionRowDataContainer(
      fromState: TransitionToggleFieldDataContainer(
        initValue: _states.isNotEmpty ? _states.first : "",
        options: _states,
        onChanged: (val) {},
      ),
      withInput: TransitionToggleFieldDataContainer(
        initValue: _inputAlphabet.isNotEmpty ? _inputAlphabet.first : "",
        options: _inputAlphabet,
        onChanged: (val) {},
      ),
      toState: TransitionToggleFieldDataContainer(
        initValue: _states.isNotEmpty ? _states.first : "",
        options: _states,
        onChanged: (val) {},
      ),
      withOutput: TransitionToggleFieldDataContainer(
        initValue: _outputAlphabet.isNotEmpty ? _outputAlphabet.first : "",
        options: _outputAlphabet,
        onChanged: (val) {},
      ),
    );
  }

  void _addTransition() {
    setState(() {
      _updateToggleFieldInitValues(); // refresh options from current state/alphabet
      _transitionRows.add(
        TransitionRowDataContainer(
          fromState: TransitionToggleFieldDataContainer(
              initValue: _toggleFieldInitValues!.fromState.initValue,
              options: _states,
              onChanged: (val) {}),
          withInput: TransitionToggleFieldDataContainer(
              initValue: _toggleFieldInitValues!.withInput.initValue,
              options: _inputAlphabet,
              onChanged: (val) {}),
          toState: TransitionToggleFieldDataContainer(
              initValue: _toggleFieldInitValues!.toState.initValue,
              options: _states,
              onChanged: (val) {}),
          withOutput: TransitionToggleFieldDataContainer(
              initValue: _toggleFieldInitValues!.withOutput.initValue,
              options: _outputAlphabet,
              onChanged: (val) {}),
        ),
      );
    });
  }

  void _deleteRow(int index) {
    setState(() {
      _transitionRows.removeAt(index);
    });
  }

  @override
  void initState() {
    super.initState();
    _updateToggleFieldInitValues();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFF3F7FF),
      body: Padding(
        padding: MediaQuery.of(context).size.width >= 800
            ? MediaQuery.of(context).size.width > 1300
              ? EdgeInsets.symmetric(horizontal: screenWidth * 0.25, vertical: 30)
              : EdgeInsets.symmetric(horizontal: screenWidth * 0.1, vertical: 30)
            : const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ]
            ),
            child: Column(
              children: [
                Text(
                  "Mealy Machine Simulator",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 25),

                Row(
                  children: [
                    Expanded(
                      child: _textContainer("States (Q):", "q1, q2, ...", (value) {
                        setState(() {
                          _states = _appendInputToList(_states, value);
                          _updateToggleFieldInitValues();
                        });
                      }),
                    ),
                    SizedBox(width: _textContainerSpacing),
                    Expanded(
                      child: _textContainer("Input Alphabet (∑):", "0, 1, ...", (value) {
                        setState(() {
                          _inputAlphabet = _appendInputToList(_inputAlphabet, value);
                          _updateToggleFieldInitValues();
                        });
                      }),
                    ),
                  ],
                ),
                SizedBox(height: _textContainerSpacing),
                Row(
                  children: [
                    Expanded(
                      child: _textContainer("Output Alphabet (∆):", "a, b, ...", (value) {
                        setState(() {
                          _outputAlphabet = _appendInputToList(_outputAlphabet, value);
                          _updateToggleFieldInitValues();
                        });
                      }),
                    ),
                    SizedBox(width: _textContainerSpacing),
                    Expanded(
                      child: _textContainer("Start State (q0):", "e.g. q0", (value) {
                        setState(() {
                          _startState = value;
                          _updateToggleFieldInitValues();
                        });
                      }),
                    ),
                  ],
                ),

                SizedBox(height: _textContainerSpacing),

                TransitionWindow(
                  transitionRows: _transitionRows,
                  toggleFieldInitValue: _toggleFieldInitValues ?? TransitionRowDataContainer(
                    fromState: TransitionToggleFieldDataContainer(initValue: "", options: [], onChanged: (val) {}),
                    withInput: TransitionToggleFieldDataContainer(initValue: "", options: [], onChanged: (val) {}),
                    toState: TransitionToggleFieldDataContainer(initValue: "", options: [], onChanged: (val) {}),
                    withOutput: TransitionToggleFieldDataContainer(initValue: "", options: [], onChanged: (val) {}),
                  ),
                  onDeleteRow: _deleteRow,
                  onAddTransition: _addTransition,
                ),

                SizedBox(height: _textContainerSpacing),

                _textContainer(
                    "Input String:",
                    "e.g., 'abba'",
                        (value) {

                    }
                ),

                SizedBox(height: _textContainerSpacing),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      debugPrint("States: $_states");
                      debugPrint("Input Alphabet: $_inputAlphabet");
                      debugPrint("Output Alphabet: $_outputAlphabet");
                      debugPrint("Start State: $_startState");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4F46E5), // button color
                      foregroundColor: Colors.white, // text color
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5), // rounded corners
                      ),
                      elevation: 0, // <-- removes shadow
                      shadowColor: Colors.transparent, // extra safety
                    ),
                    child: const Text(
                      "Simulate",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),

                SizedBox(height: _textContainerSpacing),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFFBFDBFE),
                  width: 1, // stroke thickness
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Simulation Results",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 17),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Visited States:    ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("states visited", style: TextStyle(color: Color(0xFF4F46E5)),),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Output Produced:    ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("sample output", style: TextStyle(color: Color(0xFF4F46E5)),),
                    ],
                  )
                ],
              ),
            ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textContainer(String title, String hint, ValueChanged<String> onChanged) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFBFDBFE),
          width: 1, // stroke thickness
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0,2)
                ),
              ],
            ),
            child: TextField(
              style: TextStyle(fontSize: 14),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),

                hintText: hint,
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),

                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  List<String> _appendInputToList(List<String> list, String value) {
    return list = value.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
  }
}