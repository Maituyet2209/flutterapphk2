import 'package:flutter/material.dart';

class CreateEventForm extends StatefulWidget {
  @override
  _CreateEventFormState createState() => _CreateEventFormState();
}

class _CreateEventFormState extends State<CreateEventForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String? _selectedLabel;
  List<String> _labels = ['High', 'Medium', 'Low'];
  String? _selectedGuest;
  List<String> _guests=['Johnny Doe', 'Adrian', 'Fiona','None'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Select Date',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(DateTime.now().year + 10),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      _selectedDate = selectedDate;
                    });
                  }
                },
                validator: (value) {
                  if (_selectedDate == null) {
                    return 'Please select a date';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Start Time',
                        suffixIcon: Icon(Icons.access_time),
                      ),
                      onTap: () async {
                        final selectedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (selectedTime != null) {
                          setState(() {
                            _startTime = selectedTime;
                          });
                        }
                      },
                      validator: (value) {
                        if (_startTime == null) {
                          return 'Please select start time';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'End Time',
                        suffixIcon: Icon(Icons.access_time),
                      ),
                      onTap: () async {
                        final selectedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (selectedTime != null) {
                          setState(() {
                            _endTime = selectedTime;
                          });
                        }
                      },
                      validator: (value) {
                        if (_endTime == null) {
                          return 'Please select end time';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField(
                      value: _selectedGuest,
                      items: _guests.map((guest) {
                        return DropdownMenuItem(value: guest, child: Text(guest),);
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedGuest = value as String?;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Select Guest',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty || value == 'None') {
                          return 'Please select a guest';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 10), // Thêm khoảng cách giữa DropdownButtonFormField
                  Expanded(
                    child: DropdownButtonFormField(
                      value: _selectedLabel,
                      items: _labels.map((label) {
                        return DropdownMenuItem(
                          value: label,
                          child: Text(label),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedLabel = value as String?;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Select Label',
                      ),
                      validator: (value) {
                        if (_selectedLabel == null) {
                          return 'Please select a label';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Form is validated, do something with the data
                    // For example, you can access the form fields using _titleController.text, _selectedDate, _startTime, _endTime, _selectedLabel
                  }
                },
                child: Text('Create Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}