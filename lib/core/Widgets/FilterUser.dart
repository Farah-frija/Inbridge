import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Filter Options Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FilterOptionsPage(),
    );
  }
}

class FilterOptionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter Options'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return FilterOptions();
              },
            );
          },
          child: Text('Show Filter Options'),
        ),
      ),
    );
  }
}

class FilterOptions extends StatefulWidget {
  const FilterOptions({Key? key}) : super(key: key);

  @override
  _FilterOptionsState createState() => _FilterOptionsState();
}

class _FilterOptionsState extends State<FilterOptions> {
  final TextEditingController _filterValueController = TextEditingController();
  Map<String, String> filterValues = {};
  bool? isBlocked;
  bool? isVerified;
  bool? isFemale;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildFilterDropdown("Filter By", [
              'Name',
              'Number',
              'Cin',
              'Surname',
              'Email',
              'Creation Date',
              'Last Update',
              'Pseudo',
            ]),
            SizedBox(height: 16),
            TextField(
              controller: _filterValueController,
              decoration: InputDecoration(
                hintText: 'Enter filter value',
              ),
            ),
            SizedBox(height: 16),
            CheckboxListTile(
              title: Text('Blocked'),
              value: isBlocked,
              tristate: true,
              onChanged: (value) {
                setState(() {
                  isBlocked = value;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Verified'),
              value: isVerified,
              tristate: true,
              onChanged: (value) {
                setState(() {
                  isVerified = value;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Female'),
              value: isFemale,
              tristate: true,
              onChanged: (value) {
                setState(() {
                  isFemale = value;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Apply filters using the entered value
                String filterType = filterValues.keys.first;
                String filterValue = _filterValueController.text;

                // Perform filtering using the entered filter type and value
                // Implement your filtering logic here

                // Close the bottom sheet
                Navigator.pop(context);
              },
              child: Text('Apply Filters'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterDropdown(String label, List<String> filters) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
      ),
      value: filterValues.isNotEmpty ? filterValues.keys.first : null,
      onChanged: (String? selectedFilter) {
        setState(() {
          filterValues = {selectedFilter!: ""};
          _filterValueController.text = "";
        });
      },
      items: filters.map<DropdownMenuItem<String>>((String filter) {
        return DropdownMenuItem<String>(
          value: filter,
          child: Text(filter),
        );
      }).toList(),
    );
  }
}
