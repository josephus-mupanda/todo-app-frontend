import 'package:flutter/material.dart';

class DatePickerWidget extends StatefulWidget {
  final String? topLabel;
  final String? hintText;
  final IconData? prefixIcon;
  final String? errorText;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final ValueChanged<DateTime?>? onDateSelected;
  final FormFieldValidator<String>? validator;

  const DatePickerWidget({
    super.key,
    this.topLabel,
    this.hintText,
    this.prefixIcon,
    this.errorText,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onDateSelected,
    this.validator,
  });

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime? selectedDate;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
    if (selectedDate != null) {
      _controller.text = _formatDate(selectedDate!);
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: widget.firstDate ?? DateTime(2020),
      lastDate: widget.lastDate ?? DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _controller.text = _formatDate(picked);
        if (widget.onDateSelected != null) {
          widget.onDateSelected!(picked);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle hintStyle = theme.inputDecorationTheme.hintStyle ??
        TextStyle(
          color: theme.colorScheme.onSurface.withOpacity(0.5),
          fontWeight: FontWeight.normal,
          fontSize: 12,
        );

    final TextStyle errorStyle = theme.inputDecorationTheme.errorStyle ??
        TextStyle(
          fontSize: 12,
          height: 1,
          color: theme.colorScheme.error,
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.topLabel != null && widget.topLabel!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              widget.topLabel!,
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 12,
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ),
        Container(
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: TextFormField(
            controller: _controller,
            readOnly: true,
            decoration: InputDecoration(
              prefixIcon: widget.prefixIcon != null
                  ? Icon(
                widget.prefixIcon,
                color: theme.colorScheme.onSurface.withOpacity(0.5),
              )
                  : null,
              hintText: widget.hintText,
              hintStyle: hintStyle,
              errorText: widget.errorText,
              errorStyle: errorStyle,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: theme.dividerColor.withOpacity(0.2),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: theme.colorScheme.primary,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: theme.colorScheme.error,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: theme.colorScheme.error,
                ),
              ),
            ),
            onTap: () => _selectDate(context),
            validator: widget.validator,
          ),
        ),
      ],
    );
  }
}
