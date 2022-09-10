import 'package:flutter/material.dart';
import 'package:onion/onion.dart';

class OniSearchBar extends StatefulWidget {
  final String title;
  final String placeholder;
  /// would be called every single times user typing.
  final ValueChanged<String>? onTextChanged;
  /// would be called when user submit the keyword.
  final ValueChanged<String>? onSubmitted;

  const OniSearchBar({
    required this.title,
    required this.placeholder,
    this.onTextChanged,
    this.onSubmitted,
    super.key,
  });

  @override
  State<OniSearchBar> createState() => _OniSearchBarState();
}

class _OniSearchBarState extends State<OniSearchBar> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final captionStyle = OniTextStyle.caption.copyWith(color: OniColor.white);

    return TextField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: OniColor.white),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: OniColor.white, width: 1),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: OniColor.flamingo, width: 1),
        ),
        labelText: widget.title,
        labelStyle: captionStyle,
        hintText: widget.title,
        hintStyle: captionStyle,
        prefixIcon: const Icon(
          Icons.search,
          color: OniColor.white,
        ),
        prefixText: ' ',
      ),
      style: captionStyle,
      controller: _controller,
      onChanged: widget.onTextChanged,
      onSubmitted: widget.onSubmitted,
      textInputAction: TextInputAction.search,
    );
  }
}
