import 'package:flutter/material.dart';
import 'transition_window.dart';
import 'transition_row_data_container.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  static const double _textContainerSpacing = 20;
  final List<TransitionRowDataContainer> _transitionRows = [
    // TransitionRowDataContainer(
    //   fromState: TransitionToggleFieldDataContainer(initValue: "q0", options: ["q0", "q1"], onChanged: (value) {}),
    //   withInput: TransitionToggleFieldDataContainer(initValue: "0", options: ["0", "1"], onChanged: (value) {}),
    //   toState: TransitionToggleFieldDataContainer(initValue: "q1", options: ["q0", "q1"], onChanged: (value) {}),
    //   withOutput: TransitionToggleFieldDataContainer(initValue: "1", options: ["0", "1"], onChanged: (value) {})
    // ),
    // TransitionRowDataContainer(
    //     fromState: TransitionToggleFieldDataContainer(initValue: "q1", options: ["q0", "q1"], onChanged: (value) {}),
    //     withInput: TransitionToggleFieldDataContainer(initValue: "0", options: ["0", "1"], onChanged: (value) {}),
    //     toState: TransitionToggleFieldDataContainer(initValue: "q1", options: ["q0", "q1"], onChanged: (value) {}),
    //     withOutput: TransitionToggleFieldDataContainer(initValue: "1", options: ["0", "1"], onChanged: (value) {})
    // ),
  ];

  void _deleteRow(int index) {
    setState(() {
      _transitionRows.removeAt(index);
    });
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

                      }),
                    ),
                    SizedBox(width: _textContainerSpacing),
                    Expanded(
                      child: _textContainer("Input Alphabet (∑):", "a, b, ...", (value) {

                      }),
                    ),
                  ],
                ),
                SizedBox(height: _textContainerSpacing),
                Row(
                  children: [
                    Expanded(
                      child: _textContainer("Output Alphabet (∆):", "0, 1, ...", (value) {

                      }),
                    ),
                    SizedBox(width: _textContainerSpacing),
                    Expanded(
                      child: _textContainer("Start State (q0):", "e.g. S0", (value) {

                      }),
                    ),
                  ],
                ),

                SizedBox(height: _textContainerSpacing),

                TransitionWindow(
                  transitionRows: _transitionRows,
                  onDeleteRow: _deleteRow,
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

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4F46E5), // button color
                      foregroundColor: Colors.white, // text color
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
                        "Visited States: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("states visited"),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Output Produced: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("sample output"),
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
            ),
          ),
        ],
      ),
    );
  }
}