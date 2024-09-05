import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../themes/colors.dart';

class AddMoMoScreen extends StatefulWidget {
  const AddMoMoScreen({super.key});

  @override
  State<AddMoMoScreen> createState() => _AddMoMoScreenState();
}

class _AddMoMoScreenState extends State<AddMoMoScreen> {
  String? _selectedMoMoProvider;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var mediaQuery = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Add Momo',
          style: textTheme.bodyLarge,
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 5,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Theme.of(context).colorScheme.primary,
            size: 25.sp,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.h),
                Text('Link your MOMO account',
                    style: textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    )),
                SizedBox(height: 24.h),
                DropdownButtonFormField<String>(
                  value: _selectedMoMoProvider,
                  items: ['MTN', 'Telecel', 'AirtelTigo']
                      .map((provider) => DropdownMenuItem(
                            value: provider,
                            child: Text(provider),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedMoMoProvider = value;
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                    labelStyle: textTheme.bodySmall,
                    contentPadding: EdgeInsets.all(16.w),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide:
                          BorderSide(color: KColors.primaryBlack, width: .3.w),
                    ),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a provider';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                _buildTextField(
                  context,
                  hintText: 'Enter MoMo number',
                  keyboardType: TextInputType.phone,
                  controller: _phoneController,
                  validator: _validatePhoneNumber,
                ),
                SizedBox(height: 16.h),
                _buildTextField(
                  context,
                  hintText: 'Enter MOMO name',
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24.h),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _showSuccessDialog(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1980e6),
                    fixedSize: Size(mediaQuery.width, 45.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text('Add',
                      style: textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary)),
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context,
      {required String hintText,
      TextInputType? keyboardType,
      TextEditingController? controller,
      String? Function(String?)? validator}) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: .5.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2.w,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2.w,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 16.h,
          horizontal: 16.w,
        ),
      ),
    );
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    }
    if (value.length != 10) {
      return 'Phone number must be 10 digits';
    }

    final regexMap = {
      'MTN': RegExp(r'^(?:024|054|055|059)\d{7}$'),
      'Telecel': RegExp(r'^(?:020|050)\d{7}$'),
      'AirtelTigo': RegExp(r'^(?:027|057)\d{7}$'),
    };

    final regex = regexMap[_selectedMoMoProvider];
    if (regex != null && !regex.hasMatch(value)) {
      return 'Please enter a valid $_selectedMoMoProvider number';
    }

    return null;
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          contentPadding: EdgeInsets.all(24.w),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 60.sp,
              ),
              SizedBox(height: 16.h),
              Text(
                'Payment Method Successfully Added!',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: KColors.primaryBlack),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context, {
                        'provider': _selectedMoMoProvider,
                        'phone': _phoneController.text,
                        'name': _nameController.text,
                      });
                    },
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // Optionally handle cancel action
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}
