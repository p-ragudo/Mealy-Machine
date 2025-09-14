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

  TransitionMap _transitionMap = TransitionMap();

  String _inputString = "";
  String _outputString = "";
  List<String> _visitedStates = [];

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
              onChanged: (val) {
                setState(() {
                  _transitionRows.last.fromState.initValue = val ?? "";
                });
              },),
          withInput: TransitionToggleFieldDataContainer(
              initValue: _toggleFieldInitValues!.withInput.initValue,
              options: _inputAlphabet,
              onChanged: (val) {
                setState(() {
                  _transitionRows.last.withInput.initValue = val ?? "";
                });
              },),
          toState: TransitionToggleFieldDataContainer(
              initValue: _toggleFieldInitValues!.toState.initValue,
              options: _states,
              onChanged: (val) {
                setState(() {
                  _transitionRows.last.toState.initValue = val ?? "";
                });
              },),
          withOutput: TransitionToggleFieldDataContainer(
              initValue: _toggleFieldInitValues!.withOutput.initValue,
              options: _outputAlphabet,
              onChanged: (val) {
                setState(() {
                  _transitionRows.last.withOutput.initValue = val ?? "";
                });
              }),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth >= 1300
                ? screenWidth * 0.25   // large desktop
                : screenWidth >= 800
                ? screenWidth * 0.03  // medium screens / small desktops
                : screenWidth * 0.02, // phones
            vertical: screenWidth >= 800 ? 30 : 20, // slightly smaller vertical padding for phones
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(screenWidth >= 800 ? 30 : 10),
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
                    SizedBox(height: 10),
                    Text(
                      "Mealy Machine Simulator",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      "by Group 7",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),

                    SizedBox(height: 35),

                    Row(
                      children: [
                        Expanded(
                          child: _textContainer("States (Q):", "q0, q1, ...", (value) {
                            setState(() {
                              _states = _appendInputToList(value);
                              _updateToggleFieldInitValues();
                            });
                          }),
                        ),
                        SizedBox(width: _textContainerSpacing),
                        Expanded(
                          child: _textContainer("Input Alphabet (∑):", "0, 1, ...", (value) {
                            setState(() {
                              _inputAlphabet = _appendInputToList(value);
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
                          child: _textContainer("Output Alphabet (O):", "a, b, ...", (value) {
                            setState(() {
                              _outputAlphabet = _appendInputToList(value);
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
                          setState(() {
                            _inputString = value;
                          });
                        }
                    ),

                    SizedBox(height: _textContainerSpacing),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _buildTransitionMap();

                          final result = _transitionMap.simulate(_inputString, _startState, _transitionMap.map);

                          setState(() {
                            _outputString = result.output;
                            _visitedStates = result.visitedStates;
                          });
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
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Visited States:         ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  _visitedStates.join(" → "),
                                  style: TextStyle(
                                      color: Color(0xFF4F46E5)
                                  ),
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Output Produced:    ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  _outputString,
                                  style: TextStyle(
                                    color: Color(0xFF4F46E5)
                                  ),
                                  softWrap: true,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                    SizedBox(height: 20),
                  ],
                ),
              ),

              SizedBox(height: 50),

              Text(
                "Aringo, Althea Trisha Mae",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
              Text(
                "Deleña, Kenjie Aeron",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
              Text(
                "De Leon, Roselle Jean",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
              Text(
                "Ragudo, Paolo",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  void _buildTransitionMap() {
    final newMap = <String, Map<String, Map<String, String>>>{};

    for (var row in _transitionRows) {
      final from = row.fromState.initValue;
      final input = row.withInput.initValue;
      final to = row.toState.initValue;
      final output = row.withOutput.initValue;

      if (!newMap.containsKey(from)) {
        newMap[from] = {};
      }

      newMap[from]![input] = {
        "nextState": to,
        "output": output,
      };
    }

    setState(() {
      _transitionMap.map = newMap;
    });
  }

  List<String> _appendInputToList(String value) {
    return value
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
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
}