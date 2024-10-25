import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    super.key,
    this.controller,
    required this.onSubmitted,
  });

  final TextEditingController? controller;
  final void Function(String value) onSubmitted;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late final TextEditingController _textController;

  @override
  void initState() {
    _textController = widget.controller ?? TextEditingController();
    super.initState();
  }

  void _clearText() {
    _textController.clear();
    widget.onSubmitted('');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      onSubmitted: widget.onSubmitted,
      decoration: InputDecoration(
        filled: true,
        hintText: "Search",
        contentPadding: const EdgeInsets.all(16).copyWith(bottom: 22, top: 22),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        suffixIcon: _textController.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: _clearText,
              )
            : null,
      ),
    );
  }
}
