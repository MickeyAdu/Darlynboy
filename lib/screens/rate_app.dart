import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../themes/colors.dart';

class RateAppScreen extends StatefulWidget {
  const RateAppScreen({super.key});

  @override
  State<RateAppScreen> createState() => _RateAppScreenState();
}

class _RateAppScreenState extends State<RateAppScreen> {
  double _rating = 3.0;
  final TextEditingController _feedbackController = TextEditingController();

  String _getRatingText(double rating) {
    if (rating == 1) {
      return 'Poor';
    } else if (rating == 2) {
      return 'Fair';
    } else if (rating == 3) {
      return 'Good';
    } else if (rating == 4) {
      return 'Very Good';
    } else if (rating == 5) {
      return 'Excellent';
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var mediaQuery = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Rate the App',
            style: textTheme.bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.primary)),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined,
              color: Theme.of(context).colorScheme.primary, size: 25.sp),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'How would you rate our app?',
              style: textTheme.bodyLarge!.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            RatingBar.builder(
              initialRating: _rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0.w),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
                size: 30.sp,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
            ),
            SizedBox(height: 8.h),
            Text(
              _getRatingText(_rating),
              style: textTheme.bodyLarge!
                  .copyWith(fontSize: 16.sp, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            Text(
              'Leave your feedback',
              style: textTheme.bodyLarge!.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            TextField(
              controller: _feedbackController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Tell us what you think...',
                hintStyle: textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .primary), // Set a non-bold style
                // border: OutlineInputBorder(
                //     borderRadius: BorderRadius.circular(10.r)),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: KColors.primaryBlack, width: 1.w),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: KColors.primaryBlack, width: 1.w),
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(mediaQuery.width, 45.h),
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                side: BorderSide(color: Colors.black, width: .5.w),
              ),
              onPressed: () {
                // Dismiss the keyboard
                FocusScope.of(context).unfocus();

                print('Rating: $_rating');
                print('Feedback: ${_feedbackController.text}');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Thank you for your feedback!',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                );
              },
              child: Text(
                "Submit",
                style: textTheme.bodyLarge!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }
}
