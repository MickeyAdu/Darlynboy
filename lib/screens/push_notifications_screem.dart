import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/colors.dart';

class PushNotifications extends StatefulWidget {
  const PushNotifications({super.key});

  @override
  State<PushNotifications> createState() => _PushNotificationsState();
}

class _PushNotificationsState extends State<PushNotifications> {
  // A list to hold the toggle states of each notification option
  List<bool> isToggledList = List.generate(6, (index) => false);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var mediaQuery = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Theme.of(context).colorScheme.primary,
                size: 25.sp,
              )),
          title: Text(
            "Notifications",
            style: textTheme.bodyLarge!.copyWith(fontSize: 22),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return ListTile(
                          title: Text(
                            "Receive messages from our platform",
                            style: textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          selectedTileColor: Colors.grey[50],
                          subtitle: Text(
                            "Product updates",
                            style: textTheme.bodySmall!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(.5),
                            ),
                          ),
                          trailing: IconButton(
                            color: Theme.of(context).colorScheme.primary,
                            onPressed: () {
                              setState(() {
                                isToggledList[index] = !isToggledList[index];
                              });
                            },
                            icon: Icon(
                              (isToggledList[index])
                                  ? Icons.toggle_on_outlined
                                  : Icons.toggle_off_outlined,
                              size: 50.sp,
                              color: (isToggledList[index])
                                  ? Colors.green
                                  : Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        );
                      case 1:
                        return ListTile(
                          title: Text(
                            "Receive booking remainders, pricing notices",
                            style: textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          selectedTileColor: Colors.grey[50],
                          subtitle: Text(
                            "Reminders",
                            style: textTheme.bodySmall!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(.5),
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                isToggledList[index] = !isToggledList[index];
                              });
                            },
                            icon: Icon(
                              (isToggledList[index])
                                  ? Icons.toggle_on_outlined
                                  : Icons.toggle_off_outlined,
                              size: 50.sp,
                              color: (isToggledList[index])
                                  ? Colors.green
                                  : Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        );
                      case 2:
                        return ListTile(
                          title: Text(
                            "Receive coupons, promotions, survey",
                            style: textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          selectedTileColor: Colors.grey[50],
                          subtitle: Text(
                            "Product updates",
                            style: textTheme.bodySmall!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(.5),
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                isToggledList[index] = !isToggledList[index];
                              });
                            },
                            icon: Icon(
                              (isToggledList[index])
                                  ? Icons.toggle_on_outlined
                                  : Icons.toggle_off_outlined,
                              size: 50.sp,
                              color: (isToggledList[index])
                                  ? Colors.green
                                  : Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        );
                      case 3:
                        return ListTile(
                          title: Text(
                            "Receive updates on home sharing regulations",
                            style: textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          selectedTileColor: Colors.grey[50],
                          subtitle: Text(
                            "Promotions and tips",
                            style: textTheme.bodySmall!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(.5),
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                isToggledList[index] = !isToggledList[index];
                              });
                            },
                            icon: Icon(
                              (isToggledList[index])
                                  ? Icons.toggle_on_outlined
                                  : Icons.toggle_off_outlined,
                              size: 50.sp,
                              color: (isToggledList[index])
                                  ? Colors.green
                                  : Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        );

                      case 4:
                        return ListTile(
                          title: Text(
                            "Receive messages about your account, orders and alerts",
                            style: textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          selectedTileColor: Colors.grey[50],
                          subtitle: Text(
                            "Account support",
                            style: textTheme.bodySmall!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(.5),
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                isToggledList[index] = !isToggledList[index];
                              });
                            },
                            icon: Icon(
                              (isToggledList[index])
                                  ? Icons.toggle_on_outlined
                                  : Icons.toggle_off_outlined,
                              size: 50.sp,
                              color: (isToggledList[index])
                                  ? Colors.green
                                  : Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        );
                      case 5:
                        return ListTile(
                          title: Text(
                            "Receive updates on latest launches",
                            style: textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          selectedTileColor: Colors.grey[50],
                          subtitle: Text(
                            "Product news",
                            style: textTheme.bodySmall!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(.5),
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                isToggledList[index] = !isToggledList[index];
                              });
                            },
                            icon: Icon(
                              (isToggledList[index])
                                  ? Icons.toggle_on_outlined
                                  : Icons.toggle_off_outlined,
                              size: 50.sp,
                              color: (isToggledList[index])
                                  ? Colors.green
                                  : Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        );
                    }
                    return null;
                  },
                  separatorBuilder: (context, index) => Divider(
                    color: Theme.of(context).colorScheme.primary,
                    height: 12.h,
                  ),
                  itemCount: isToggledList.length,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(mediaQuery.width, 45.h),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  side: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: .5.w),
                ),
                onPressed: () {},
                child: Text(
                  "Save changes",
                  style: textTheme.bodyLarge!
                      .copyWith(color: KColors.primaryWhite),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
