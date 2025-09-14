class TransitionMap {
  Map<String, Map<String, Map<String, String>>> map = {};

  String simulate(String text, String initialState, Map<String, Map<String, Map<String, String>>> transitions) {
    List<String> input = text.split('');
    StringBuffer output = StringBuffer();
    String currentState = initialState;

    for (String currentInputChar in input) {
      Map<String,
          Map<String, String>> currentStateInMap = transitions[currentState]!;
      Map<String,
          String> currentInputInMap = currentStateInMap[currentInputChar]!;

      output.write(currentInputInMap["output"]!);
      currentState = currentInputInMap["nextState"]!;
    }

    return output.toString();
  }
}