import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/NOTIFICATION-/Notification_actions.dart';

mixin BellIconFunction {
  final NotificationController notificationController = Get.find<NotificationController>();

  void showNotification(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Dismiss",
      transitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (_, __, ___) {
        double dragStartY = 0; // Stores initial Y position of drag

        return Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onVerticalDragStart: (details) {
              dragStartY = details.globalPosition.dy; // Capture drag start
            },
            onVerticalDragUpdate: (details) {
              if (dragStartY - details.globalPosition.dy > 80) {
                // If dragged upwards by 80px, close
                Navigator.of(context).pop();
              }
            },

            // BackdropFilter(
            //   filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            //   child: Container(
            //     color: Colors.black.withOpacity(0.8), // Dark semi-transparent overlay
            //   ),
            // ),
            child: Row(
              children: [
                const Expanded(
                  flex: 2,
                  child: SizedBox.shrink(),
                ),
                const SizedBox(width: 103),
                Expanded(
                  flex: 1,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                    child: Container(
                      // width: 400,
                      // height: 600,
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        // color: Primary_colors.co,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () => Navigator.of(context).pop(),
                                  child: const Icon(Icons.close, color: Colors.red),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Obx(() => notificationController.notificationModel.notifications.isEmpty
                                ? const Text(
                                    'No Notifications',
                                    style: TextStyle(fontSize: 20, color: Colors.white, decoration: TextDecoration.none),
                                  )
                                : Column(
                                    children: [
                                      ...notificationController.notificationModel.notifications.map<Widget>((notification) {
                                        return Container(
                                          width: 650,
                                          margin: const EdgeInsets.symmetric(vertical: 4),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(255, 35, 42, 63),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Icon(Icons.notifications_active, color: Colors.grey, size: 18),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: Text(
                                                  notification,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                    decoration: TextDecoration.none,
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                color: Colors.transparent,
                                                width: 50,
                                                child: Material(
                                                  color: Colors.transparent, // Make the Material also transparent
                                                  child: PopupMenuButton<String>(
                                                    color: Colors.white, // Optional: background color of the popup itself
                                                    padding: EdgeInsets.zero,
                                                    icon: const Icon(
                                                      Icons.more_horiz,
                                                      color: Colors.white, // Black icon
                                                    ),
                                                    onSelected: (value) {
                                                      if (value == 'delete') {
                                                        notificationController.clearNotifications(notification);
                                                      } else if (value == 'View') {
                                                        // Add your custom action here
                                                      }
                                                    },
                                                    itemBuilder: (context) => [
                                                      const PopupMenuItem(
                                                        value: 'delete',
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons.delete, color: Colors.red),
                                                            SizedBox(width: 8),
                                                            Text('Delete'),
                                                          ],
                                                        ),
                                                      ),
                                                      const PopupMenuItem(
                                                        value: 'View',
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons.view_timeline, color: Colors.blue),
                                                            SizedBox(width: 8),
                                                            Text('View'),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                      const SizedBox(height: 16),
                                      TextButton(
                                        onPressed: () {
                                          notificationController.clearAllNotifications();
                                        },
                                        child: const Text(
                                          'Clear All Notifications',
                                          style: TextStyle(color: Colors.red, fontSize: 16, decoration: TextDecoration.none),
                                        ),
                                      ),
                                    ],
                                  )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, -0.9),
            end: Offset.zero,
          ).animate(anim1),
          child: FadeTransition(
            opacity: anim1,
            child: child,
          ),
        );
      },
    );
  }
}
