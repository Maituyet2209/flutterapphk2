import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todolistproject/screens/home/components/resultsearch.dart';
import '../../../constants.dart';

class SearchField extends StatefulWidget {
  final token;
  const SearchField({
    Key? key,
    this.token,
  }) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  TextEditingController _searchController = TextEditingController();

  Future<void> searchTask(String query) async {
    try {
      var response = await http.get(Uri.parse('http://localhost:3000/searchTasksByName?searchQuery=$query'));

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var tasks = jsonResponse['tasks'];

        if (tasks.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchResultPage(tasks: tasks),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('No results found for "$query"'),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to search for tasks. Status code: ${response.statusCode}'),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        child: TextFormField(
          controller: _searchController,
          onFieldSubmitted: (value) {
            searchTask(value);
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: kSecondaryColor.withOpacity(0.1),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            border: searchOutlineInputBorder,
            focusedBorder: searchOutlineInputBorder,
            enabledBorder: searchOutlineInputBorder,
            hintText: "Search task",
            prefixIcon: const Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}

const searchOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(12)),
  borderSide: BorderSide.none,
);
