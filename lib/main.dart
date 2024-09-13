import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Form App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
        ),
      ),
      home: FormPage(),
    );
  }
}

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final _formKey = GlobalKey<FormState>();

  final _panController = TextEditingController();
  final _panTypeController = TextEditingController();
  final _nameController = TextEditingController();
  final _dobController = TextEditingController();
  final _addressController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _bankController = TextEditingController();
  final _accountController = TextEditingController();
  final _ifscController = TextEditingController();

  final List<String> _panTypes = [
    'P: For individuals',
    'B: For Body of Individuals (BOI)',
    'A: For Association of Persons (AOP)',
  ];

  final List<String> _banks = [
    'State Bank of India',
    'HDFC Bank',
    'ICICI Bank',
    'Axis Bank',
    'Punjab National Bank',
    'Bank of Baroda',
    'Canara Bank',
    'Kotak Mahindra Bank',
    'IndusInd Bank',
    'IDFC FIRST Bank',
  ];

  bool _sameAsCurrentAddress = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void _submitForm() {
    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      // Handle form submission
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Form Submitted')));
    }
  }

  bool _isPanValid(String pan) {
    // PAN validation pattern: 5 letters, 4 digits, 1 letter
    return RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(pan);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Page'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'PAN'),
            Tab(text: 'Basic Details'),
            Tab(text: 'Bank Details'),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: LinearProgressIndicator(
              value: _tabController?.index == null ? 0 : (_tabController!.index + 1) / 3,
              backgroundColor: Colors.grey.shade300,
              color: Colors.blue,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                SingleChildScrollView(child: _buildPanTab()),
                SingleChildScrollView(child: _buildBasicDetailsTab()),
                SingleChildScrollView(child: _buildBankDetailsTab()),
              ],
            ),
          ),
          if (_tabController?.index == 2) // Show button only on the last page
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPanTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _panController,
              decoration: InputDecoration(
                labelText: 'PAN Number',
                hintText: 'Enter your PAN Number',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter PAN Number';
                }
                if (!_isPanValid(value)) {
                  return 'Invalid PAN Number format';
                }
                return null;
              },
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9]'))],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  _tabController?.animateTo(1);
                }
              },
              child: Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicDetailsTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _panTypeController.text.isEmpty ? null : _panTypeController.text,
              items: _panTypes.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _panTypeController.text = value ?? '';
                });
              },
              decoration: InputDecoration(
                labelText: 'PAN Type',
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Enter your name',
                hintText: 'Enter your name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _dobController,
              decoration: InputDecoration(
                labelText: 'Date of Birth',
                hintText: 'Select your date of birth',
              ),
              readOnly: true,
              onTap: () async {
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (selectedDate != null) {
                  _dobController.text = '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your date of birth';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Address',
                hintText: 'Enter your address',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your address';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _pincodeController,
              decoration: InputDecoration(
                labelText: 'Pincode',
                hintText: 'Enter your pincode',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your pincode';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'City',
                hintText: 'Enter your city',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your city';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _stateController,
              decoration: InputDecoration(
                labelText: 'State',
                hintText: 'Enter your state',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your state';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: _sameAsCurrentAddress,
                  onChanged: (value) {
                    setState(() {
                      _sameAsCurrentAddress = value ?? false;
                      if (_sameAsCurrentAddress) {
                        _addressController.text = 'Current Address'; // Replace with actual current address if needed
                        _pincodeController.text = '000000'; // Replace with actual pincode if needed
                        _cityController.text = 'City Name'; // Replace with actual city if needed
                        _stateController.text = 'State Name'; // Replace with actual state if needed
                      } else {
                        _addressController.text = '';
                        _pincodeController.text = '';
                        _cityController.text = '';
                        _stateController.text = '';
                      }
                    });
                  },
                ),
                Text('Same as Current Address'),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  _tabController?.animateTo(2);
                }
              },
              child: Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBankDetailsTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _bankController.text.isEmpty ? null : _bankController.text,
              items: _banks.map((bank) {
                return DropdownMenuItem(
                  value: bank,
                  child: Text(bank),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _bankController.text = value ?? '';
                });
              },
              decoration: InputDecoration(
                labelText: 'Select Bank',
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _accountController,
              decoration: InputDecoration(
                labelText: 'Account Number',
                hintText: 'Enter your account number',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your account number';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _ifscController,
              decoration: InputDecoration(
                labelText: 'IFSC Code',
                hintText: 'Enter your IFSC code',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your IFSC code';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
