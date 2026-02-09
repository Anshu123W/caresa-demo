import 'package:flutter/material.dart';
import 'package:firstproduction_pro/navigation/routes.dart';
import 'package:firstproduction_pro/backend/backend.dart';

class ComplaintFormScreen extends StatefulWidget {
  const ComplaintFormScreen({Key? key}) : super(key: key);

  @override
  State<ComplaintFormScreen> createState() => _ComplaintFormScreenState();
}

class _ComplaintFormScreenState extends State<ComplaintFormScreen> {
  bool isAnonymous = true;
  String? selectedCategory;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  final List<String> categories = [
    'Verbal Harassment',
    'Physical Harassment',
    'Visual/Digital Harassment',
    'Other',
  ];

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    timeController.dispose();
    locationController.dispose();
    super.dispose();
  }

 void _submitComplaint() async {
    if (!isAnonymous && nameController.text.isEmpty) {
      _showSnackBar('Please enter your name');
      return;
    }
    if (selectedCategory == null) {
      _showSnackBar('Please select a category');
      return;
    }
    if (descriptionController.text.isEmpty) {
      _showSnackBar('Please describe what happened');
      return;
    }
    if (dateController.text.isEmpty || timeController.text.isEmpty) {
      _showSnackBar('Please select date and time');
      return;
    }
    if (locationController.text.isEmpty) {
      _showSnackBar('Please enter location');
      return;
    }

    final result = await sendComplaint(
  isAnonymous: isAnonymous,
  name: isAnonymous ? null : nameController.text.trim(),
  category: selectedCategory!,
  description: descriptionController.text.trim(),
  complaintDate: dateController.text,
  complaintTime: timeController.text, 
  location: locationController.text,
);

if (result['success'] == true) {
  final complaintId = result['complaintId'];
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Complaint submitted! ID: $complaintId')),
    
  );
  Navigator.pushNamed(context, Routes.compliantsucess,arguments: result['complaintId']);
} else {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Error: ${result['error']}')),
  );
}
  }
  void _saveDraft() => _showSnackBar('Draft saved');

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
    void _clearForm() {
    nameController.clear();
    descriptionController.clear();
    dateController.clear();
    timeController.clear();
    locationController.clear();
    setState(() {
      selectedCategory = null;
      isAnonymous = true;
    });
  }
    Future<void> _selectTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.black,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      final hour = picked.hourOfPeriod.toString().padLeft(2, '0');
      final minute = picked.minute.toString().padLeft(2, '0');
      final period = picked.period == DayPeriod.am ? 'AM' : 'PM';
      timeController.text = '$hour:$minute $period';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                const Text(
                  'Report Complaint',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Your safety matters. You can report an incident confidentially. The Internal\n Complaints Committee (ICC) will review your complaint securely.',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

               
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildToggleButton(
                          'Anonymous',
                          isAnonymous,
                          () => setState(() => isAnonymous = true),
                        ),
                      ),
                      Expanded(
                        child: _buildToggleButton(
                          'Named',
                          !isAnonymous,
                          () => setState(() => isAnonymous = false),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

             
                if (!isAnonymous) ...[
                  _buildLabel('Name'),
                  const SizedBox(height: 8),
                  _buildTextField(
                    controller: nameController,
                    hintText: 'Full Name',
                  ),
                  const SizedBox(height: 20),
                ],

               
                _buildLabel('Category'),
                const SizedBox(height: 8),
                _buildDropdown(),
                const SizedBox(height: 20),

               
                _buildLabel('Describe What Happened'),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: descriptionController,
                  hintText:
                      'Please share what happened, who was involved, and any details that may help us understand the situation.',
                  maxLines: 6,
                ),
                const SizedBox(height: 20),

        
                _buildLabel('Date & Time'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: _buildTextField(
                        controller: dateController,
                        hintText: 'dd/mm/yyyy',
                        suffixIcon: Icons.calendar_today,
                        onTap: () => _selectDate(context),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: _buildTextField(
                        controller: timeController,
                        hintText: 'hh:mm AM',
                        onTap: () => _selectTime(context),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

              
                _buildLabel('Location'),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: locationController,
                  hintText: 'Enter location',
                ),
                const SizedBox(height: 32),

             
                ElevatedButton(
                  onPressed: _submitComplaint,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Submit A Complaint',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

      
                ElevatedButton(
                  onPressed: _saveDraft,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Save Draft',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    
  }

  Widget _buildToggleButton(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? Colors.white : Colors.transparent,
                border: Border.all(
                  color: isSelected ? Colors.white : Colors.black54,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
    IconData? suffixIcon,
    VoidCallback? onTap,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      readOnly: onTap != null,
      onTap: onTap,
      style: const TextStyle(fontSize: 15),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey[400],
          fontSize: 14,
        ),
        suffixIcon: suffixIcon != null
            ? Icon(suffixIcon, size: 20, color: Colors.grey[600])
            : null,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black, width: 1.5),
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: DropdownButtonFormField<String>(
        value: selectedCategory,
        hint: Text(
          'Select Category',
          style: TextStyle(color: Colors.grey[400], fontSize: 14),
        ),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: InputBorder.none,
        ),
        icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
        isExpanded: true,
        items: categories.map((String category) {
          return DropdownMenuItem<String>(
            value: category,
            child: Text(category, style: const TextStyle(fontSize: 15)),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedCategory = newValue;
          });
        },
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.black,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        dateController.text =
            '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
      });
    }
  }}