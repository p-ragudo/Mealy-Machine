class TransitionMap {
  Map<String, Map<String, Map<String, String>>> map = {};

  SimulationResult simulate(String text, String initialState, Map<String, Map<String, Map<String, String>>> transitions) {
    List<String> input = text.split('');
    StringBuffer output = StringBuffer();
    String currentState = initialState;

    List<String> statesVisited = [initialState];

    for (String currentInputChar in input) {
      Map<String,
          Map<String, String>> currentStateInMap = transitions[currentState]!;
      Map<String,
          String> currentInputInMap = currentStateInMap[currentInputChar]!;

      output.write(currentInputInMap["output"]!);
      currentState = currentInputInMap["nextState"]!;
      statesVisited.add(currentState);
    }

    SimulationResult result = SimulationResult(
      output: output.toString(),
      visitedStates: statesVisited
    );

    return result;
  }
}

class SimulationResult {
  final String output;
  final List<String> visitedStates;

  SimulationResult({required this.output, required this.visitedStates});
}