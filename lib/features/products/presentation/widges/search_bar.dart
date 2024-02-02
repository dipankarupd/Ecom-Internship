import 'package:flutter/material.dart';

class GoodsSearchBar extends StatelessWidget {

  final TextEditingController searchController;
  final ValueChanged<String> onSearchQueryChanged;


  const GoodsSearchBar({
    super.key,
    required this.searchController,
    required this.onSearchQueryChanged
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      onChanged: (query) => onSearchQueryChanged(query),
      decoration: const InputDecoration(
          suffixIcon: Icon(Icons.search),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: .6, color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          focusedBorder: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
          hintText: "Search for goods..."),
    );
  }
}
