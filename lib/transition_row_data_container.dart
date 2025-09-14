import 'transition_toggle_field_data_container.dart';

class TransitionRowDataContainer {
  TransitionToggleFieldDataContainer fromState;
  TransitionToggleFieldDataContainer withInput;
  TransitionToggleFieldDataContainer toState;
  TransitionToggleFieldDataContainer withOutput;

  TransitionRowDataContainer({
    required this.fromState,
    required this.withInput,
    required this.toState,
    required this.withOutput
  });
}