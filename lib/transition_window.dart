import 'package:flutter/material.dart';
import 'transition_row_data_container.dart';
import 'transition_toggle_field_data_container.dart';

class TransitionWindow extends StatefulWidget {
  final List<TransitionRowDataContainer> transitionRows;
  final void Function(int index) onDeleteRow;
  final void Function() onAddTransition;

  const TransitionWindow({
    super.key,
    required this.transitionRows,
    required this.onDeleteRow,
    required this.onAddTransition,
  });

  @override
  State<TransitionWindow> createState() => _TransitionWindowState();
}

class _TransitionWindowState extends State<TransitionWindow> {
  late List<TransitionRowDataContainer> _transitionRows;

  @override
  void initState() {
    super.initState();
    _transitionRows = widget.transitionRows;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFBFDBFE),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Transitions (∂ and ℷ)",
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 12),
          ...(_transitionRows.isEmpty
              ? [
            // starting default empty row
            _transitionRow(
              data: TransitionRowDataContainer(
                fromState: TransitionToggleFieldDataContainer(initValue: "", options: [], onChanged: (value) {}),
                withInput: TransitionToggleFieldDataContainer(initValue: "", options: [], onChanged: (value) {}),
                toState: TransitionToggleFieldDataContainer(initValue: "", options: [], onChanged: (value) {}),
                withOutput: TransitionToggleFieldDataContainer(initValue: "", options: [], onChanged: (value) {}),
              ),
              index: -1,
            ),
          ]
              : _transitionRows.asMap().entries.map((entry) {
            final index = entry.key;
            final rowData = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: _transitionRow(data: rowData, index: index),
            );
          }).toList()),

          SizedBox(height: 15),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: widget.onAddTransition,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF6366F1).withValues(alpha: 0.10),
                foregroundColor: Color(0xFF6366F1),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                    color: Color(0xFF6366F1)
                  ),
                ),
                elevation: 0, // <-- removes shadow
                shadowColor: Colors.transparent, // extra safety
              ),
              child: const Text(
                "Add Transition",
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _transitionRow({
    required TransitionRowDataContainer data,
    required int index
  }) {
    const double horizontalSpacing = 10;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // fromState
        _dropdownField(
          value: data.fromState.initValue,
          options: data.fromState.options,
          onChanged: data.fromState.onChanged,
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalSpacing),
          child: Text(
            "with\ninput",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
            ),
          ),
        ),

        // onInput
        _dropdownField(
          value: data.withInput.initValue,
          options: data.withInput.options,
          onChanged: data.withInput.onChanged,
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalSpacing),
          child: Text(
            "goes\nto",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
            ),
          ),
        ),

        // toState
        _dropdownField(
          value: data.toState.initValue,
          options: data.toState.options,
          onChanged: data.toState.onChanged,
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalSpacing),
          child: Text(
            "with\noutput",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
            ),
          ),
        ),

        // output
        _dropdownField(
          value: data.withOutput.initValue,
          options: data.withOutput.options,
          onChanged: data.withOutput.onChanged,
        ),

        SizedBox(width: horizontalSpacing),

        index >= 0
        ? IconButton(
          icon: Icon(Icons.delete, color: Colors.redAccent),
          onPressed: () => widget.onDeleteRow(index),
        )
        : const SizedBox.shrink(),
      ],
    );
  }

  Widget _dropdownField({
    required String value, // current/initial value
    required List<String> options,
    required ValueChanged<String?> onChanged,
  }) {
    return Expanded(
      child: Container(
        width: 100,
        padding: EdgeInsets.symmetric(horizontal: 12),
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
        child:  DropdownButton<String>(
          value: value,
          hint: Text(""),
          isExpanded: true,
          icon: Icon(Icons.arrow_drop_down),
          underline: SizedBox(), // remove underline
          borderRadius: BorderRadius.circular(12),
          items: options.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}