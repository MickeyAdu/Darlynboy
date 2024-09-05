import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../themes/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEditingFirstName = false;
  bool isEditingLastName = false;
  bool isEditingPhone = false;
  bool isEditingEmail = false;
  bool isEditingPassword = false;
  bool isPasswordVisible = false;

  // Original values for cancellation
  late String originalFirstName;
  late String originalLastName;
  late String originalPhone;
  late String originalEmail;

  final TextEditingController firstNameController =
      TextEditingController(text: 'Michael');
  final TextEditingController lastNameController =
      TextEditingController(text: 'Adu');
  final TextEditingController phoneController =
      TextEditingController(text: '+233 24 456 7890');
  final TextEditingController emailController =
      TextEditingController(text: 'michaeladu@gmail.com');
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Initialize original values
    originalFirstName = firstNameController.text;
    originalLastName = lastNameController.text;
    originalPhone = phoneController.text;
    originalEmail = emailController.text;
  }

  bool _validateEmail(String email) {
    // Basic email validation
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  bool _validatePhone(String phone) {
    // Basic phone validation for MTN, Telecel, Airteltigo
    final phoneRegex = RegExp(r'^\+1\s\d{3}\s\d{3}\s\d{4}$');
    return phoneRegex.hasMatch(phone);
  }

  void saveChanges() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        // Update the original values with the latest changes
        originalFirstName = firstNameController.text;
        originalLastName = lastNameController.text;
        originalPhone = phoneController.text;
        originalEmail = emailController.text;

        // Exit editing mode
        isEditingFirstName = false;
        isEditingLastName = false;
        isEditingPhone = false;
        isEditingEmail = false;
        isEditingPassword = false;

        // Show success toast message
        Fluttertoast.showToast(
          msg: "Changes saved successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      });
    } else {
      // Show error toast if validation fails
      Fluttertoast.showToast(
        msg: "Please correct the errors in the form",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  void cancelChanges() {
    setState(() {
      // Revert to the original values
      firstNameController.text = originalFirstName;
      lastNameController.text = originalLastName;
      phoneController.text = originalPhone;
      emailController.text = originalEmail;
      passwordController.clear(); // Clear the password field

      // Exit editing mode for all fields
      isEditingFirstName = false;
      isEditingLastName = false;
      isEditingPhone = false;
      isEditingEmail = false;
      isEditingPassword = false;
      isPasswordVisible = false; // Reset password visibility

      // Show a toast notification for cancelled changes
      Fluttertoast.showToast(
        msg: "Changes canceled",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.orange,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var mediaQuery = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Theme.of(context).colorScheme.primary,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Profile', style: textTheme.bodyLarge),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.asset(
                        "assets/dummy.jfif",
                        fit: BoxFit.cover,
                        height: 210.h,
                        width: mediaQuery.width,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 160.0.h, left: 280.w),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 3.5.w),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.edit,
                            size: 30.sp,
                            color: KColors.primaryBlack,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25.h),
                buildProfileSection(
                  context: context,
                  title: 'First Name',
                  value: firstNameController.text,
                  icon: isEditingFirstName ? Icons.check_outlined : Icons.edit,
                  isEditing: isEditingFirstName,
                  onEditPressed: () {
                    setState(() {
                      isEditingFirstName = !isEditingFirstName;
                    });
                  },
                  controller: firstNameController,
                ),
                const Divider(),
                buildProfileSection(
                  context: context,
                  title: 'Last Name',
                  value: lastNameController.text,
                  icon: isEditingLastName ? Icons.check_outlined : Icons.edit,
                  isEditing: isEditingLastName,
                  onEditPressed: () {
                    setState(() {
                      isEditingLastName = !isEditingLastName;
                    });
                  },
                  controller: lastNameController,
                ),
                const Divider(),
                buildProfileSection(
                  context: context,
                  title: 'Phone',
                  value: phoneController.text,
                  icon: isEditingPhone ? Icons.check_outlined : Icons.edit,
                  isEditing: isEditingPhone,
                  onEditPressed: () {
                    setState(() {
                      isEditingPhone = !isEditingPhone;
                    });
                  },
                  controller: phoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone number is required';
                    }
                    if (!_validatePhone(value)) {
                      return 'Invalid phone number';
                    }
                    return null;
                  },
                ),
                const Divider(),
                buildProfileSection(
                  context: context,
                  title: 'Email',
                  value: emailController.text,
                  icon: isEditingEmail ? Icons.check_outlined : Icons.edit,
                  isEditing: isEditingEmail,
                  onEditPressed: () {
                    setState(() {
                      isEditingEmail = !isEditingEmail;
                    });
                  },
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    if (!_validateEmail(value)) {
                      return 'Invalid email address';
                    }
                    return null;
                  },
                ),
                const Divider(),
                buildProfileSection(
                  context: context,
                  title: 'Password',
                  value:
                      isEditingPassword ? passwordController.text : '••••••••',
                  icon: isEditingPassword
                      ? (isPasswordVisible ? Icons.check : Icons.check)
                      : Icons.edit,
                  isEditing: isEditingPassword,
                  onEditPressed: () {
                    setState(() {
                      isEditingPassword = !isEditingPassword;
                    });
                  },
                  controller: passwordController,
                  obscureText: !isPasswordVisible,
                  onVisibilityToggle: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                ),
                const Divider(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        fixedSize: Size(150.w, 45.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          side: const BorderSide(color: KColors.primaryBlack),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.0.w),
                      ),
                      onPressed: saveChanges,
                      child: Text('Save', style: textTheme.bodyLarge),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        fixedSize: Size(150.w, 45.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          side: const BorderSide(color: KColors.primaryBlack),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.0.w),
                      ),
                      onPressed: cancelChanges,
                      child: Text('Cancel', style: textTheme.bodyLarge),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProfileSection({
    required BuildContext context,
    required String title,
    required String value,
    required IconData icon,
    bool isEditing = false,
    TextEditingController? controller,
    VoidCallback? onEditPressed,
    bool obscureText = false,
    VoidCallback? onVisibilityToggle,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: isEditing
                    ? TextFormField(
                        controller: controller,
                        obscureText: obscureText,
                        keyboardType: title == 'Phone'
                            ? TextInputType.phone
                            : TextInputType.text,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 8.0.w),
                          focusedBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: BorderSide(
                                color: KColors.primaryBlack, width: 1.w),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: BorderSide(
                                color: KColors.primaryBlack, width: 1.w),
                          ),
                          suffixIcon: title == 'Password'
                              ? IconButton(
                                  icon: Icon(
                                    obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                  onPressed: onVisibilityToggle,
                                )
                              : null,
                        ),
                        validator: validator,
                      )
                    : Text(
                        title == 'Password'
                            ? '*' * passwordController.text.length
                            : value,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 16,
                        ),
                      ),
              ),
              SizedBox(width: 10.w),
              IconButton(
                onPressed: onEditPressed,
                icon: Icon(
                  icon,
                  size: 25.sp,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
