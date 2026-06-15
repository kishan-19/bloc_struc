import 'dart:convert';
import 'dart:io';
import 'package:bloc_struc/route/app_route.dart';
import 'package:bloc_struc/screen/list/list_screen.dart';
import 'package:bloc_struc/screen/login/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../constant/global_context.dart';

// ignore: slash_for_doc_comments
/**
 * Documents added by Alaa, enjoy ^-^:
 * There are 3 major things to consider when dealing with push notification :
 * - Creating the notification
 * - Hanldle notification click
 * - App status (foreground/background and killed(Terminated))
 *
 * Creating the notification:
 *
 * - When the app is killed or in background state, creating the notification is handled through the back-end services.
 *   When the app is in the foreground, we have full control of the notification. so in this case we build the notification from scratch.
 *
 * Handle notification click:
 *
 * - When the app is killed, there is a function called getInitialMessage which
 *   returns the remoteMessage in case we receive a notification otherwise returns null.
 *   It can be called at any point of the application (Preferred to be after defining GetMaterialApp so that we can go to any screen without getting any errors)
 * - When the app is in the background, there is a function called onMessageOpenedApp which is called when user clicks on the notification.
 *   It returns the remoteMessage.
 * - When the app is in the foreground, there is a function flutterLocalNotificationsPlugin, is passes a future function called onSelectNotification which
 *   is called when user clicks on the notification.
 *
 * */
class PushNotificationService {
  Future<void> setupInteractedMessage() async {
    await Firebase.initializeApp();
    await FirebaseMessaging.instance.requestPermission();
    await enableIOSNotifications();
    await registerNotificationListeners();
    await FirebaseMessaging.instance.setAutoInitEnabled(true);

    // Handle Terminated State Notification Tap
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      var id = initialMessage.data['id'] ?? initialMessage.data['content_id'] ?? "";
      var contentType = initialMessage.data['content_type'] ?? "";
      
      // Delay slightly to ensure appRouter is ready and attached to runApp
      Future.delayed(const Duration(milliseconds: 500), () {
        openPage(contentType, id);
      });
    }

    // Handle Background State Notification Tap
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      var id = "";
      var contentType = "";
      var image = "";
      var messageData = "";
      message.data.forEach((key, value) {
        if (key == "id") {
          id = value;
        }

        if (id.isEmpty) {
          if (key == "content_id") {
            id = value;
          }
        }

        if (key == "content_type") {
          contentType = value;
        }

        if (key == "image") {
          image = value;
        }

        if (key == "message") {
          messageData = value;
        }
      });
      print('<><> onMessageOpenedApp setupInteractedMessage id--->$id');
      print(
        '<><> onMessageOpenedApp setupInteractedMessage contentType--->$contentType',
      );
      print("Notification Data ===== ${message.data}");
      print("Notification Data Json ===== ${jsonEncode(message.data)}");
      NavigationService.notif_id = id;
      NavigationService.notif_type = contentType;
      openPage(contentType, id);
    });
  }

  registerNotificationListeners() async {
    AndroidNotificationChannel channel = androidNotificationChannel();
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    var androidSettings = const AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    var iOSSettings = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      defaultPresentAlert: true,
      defaultPresentBadge: true,
      defaultPresentSound: true,
    );

    // onMessage is called when the app is in foreground and a notification is received
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) async {
      print(
        'onMessage Notification Payload:${message?.notification!.toMap().toString()}',
      );
      print('onMessage Data Payload:${message?.data.toString()}');
      RemoteNotification? notification = message?.notification;
      AndroidNotification? android = message?.notification?.android;
      // SessionManager sessionManager = SessionManager();
      // bool isLoggedIn = sessionManager.checkIsLoggedIn() ?? false;

      // print("Notification Chek  === ${notification != null} ===== $isLoggedIn");

      // if (notification != null && isLoggedIn)
      if (notification != null) {
        var id = "";
        var contentType = "";
        var image = "";
        var title = "";
        var messageData = "";

        message?.notification?.toMap().forEach((key, value) {
          if (key == "image") {
            image = value;
          }

          if (key == "title") {
            title = value;
          }

          if (key == "body") {
            messageData = value;
          }
        });

        print("Message Data ==== Key ===== ${message?.data} ");

        message?.data.forEach((key, value) {
          print(
            "Message Data ==== Key ===== ${key} ====== Value ====== ${value}",
          );

          if (key == "content_id") {
            id = value;
          }

          if (id.isEmpty) {
            if (key == "id") {
              id = value;
            }
          }

          if (key == "content_type") {
            contentType = value;
          }

          if (key == "image") {
            image = value;
          }

          if (key == "title") {
            title = value;
          }

          if (key == "body") {
            messageData = value;
          }
        });

        image = android?.imageUrl ?? '';
        print('<><> onMessage id--->$id');
        print('<><> onMessage title--->$title');
        print('<><> onMessage messageData--->$messageData');
        print('<><> onMessage contentType--->$contentType');
        print("<><> onMessage Image URL : $image <><>");

        if (image.isNotEmpty) {
          String largeIconPath = await _downloadAndSaveFile(
            image.toString().replaceAll(" ", "%20"),
            'largeIcon',
          );
          String bigPicturePath = await _downloadAndSaveFile(
            image.toString().replaceAll(" ", "%20"),
            'bigPicture',
          );

          final BigPictureStyleInformation bigPictureStyleInformation =
              BigPictureStyleInformation(
                FilePathAndroidBitmap(bigPicturePath),
                largeIcon: FilePathAndroidBitmap(largeIconPath),
                hideExpandedLargeIcon: false,
                contentTitle: title, //"<b>$title</b>"
                htmlFormatContentTitle: true,
                summaryText: '',
                htmlFormatSummaryText: true,
              );

          final DarwinNotificationDetails iOSPlatformChannelSpecifics =
              DarwinNotificationDetails(
                presentSound: true,
                presentAlert: true,
                categoryIdentifier: "myNotificationCategory",
                threadIdentifier: "myNotificationCategory",
                attachments: <DarwinNotificationAttachment>[
                  DarwinNotificationAttachment(bigPicturePath),
                ],
              );

          flutterLocalNotificationsPlugin.show(
            id: notification.hashCode,
            title: notification.title,
            body: notification.body,
            notificationDetails: NotificationDetails(
              android: AndroidNotificationDetails(
                "block_struc",
                "block struc",
                channelDescription: channel.description,
                icon: android!.smallIcon,
                playSound: true,
                styleInformation: bigPictureStyleInformation,
                importance: Importance.max,
                priority: Priority.high,
              ),
              iOS: iOSPlatformChannelSpecifics,
            ),
            payload: contentType + "|" + id,
          );
        } else {
          const DarwinNotificationDetails iOSPlatformChannelSpecifics =
              DarwinNotificationDetails(presentSound: true, presentAlert: true);
          flutterLocalNotificationsPlugin.show(
            id: notification.hashCode,
            title: title,
            body: messageData,
            notificationDetails: NotificationDetails(
              android: AndroidNotificationDetails(
                "block_struc",
                "block struc",
                channelDescription: channel.description,
                icon: android!.smallIcon,
                playSound: true,
                importance: Importance.max,
                styleInformation: BigTextStyleInformation(messageData),
                priority: Priority.high,
              ),
              iOS: iOSPlatformChannelSpecifics,
            ),
            payload: "$contentType|$id",
          );

          print('<><> onMessage PAYLOAD SET --->$contentType|$id' + "<><>");
        }

        if (contentType == "invite") {
          NavigationService.isForInvitePopUp = true;
        } else {

        }
      } else {
        print("<><> CHECK DATA : " + " <><>");
      }
    });

    var initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iOSSettings,
    );
    flutterLocalNotificationsPlugin.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: (details) {
        // This function handles the click in the notification when the app is in foreground
        // Get.toNamed(NOTIFICATIOINS_ROUTE);
        try {
          print('<><> TAP onMessage :' + details.payload.toString() + "  <><>");
          var payloadData = details.payload.toString().trim().split("|");
          if (payloadData.isNotEmpty) {
            if (payloadData.length > 1) {
              var contentType = payloadData[0].toString();
              var contentId = payloadData[1].toString();
              openPage(contentType, contentId);
            } else {
              var contentType = payloadData[0].toString();
              var contentId = "";
              openPage(contentType, contentId);
            }
          } else {
            print(
              '<><> TAP onMessage payloadData blank :' +
                  details.payload.toString() +
                  "  <><>",
            );
            appRouter.go(AppRoute.login);
            // NavigationService.navigatorKey.currentState!.pushAndRemoveUntil(
            //   MaterialPageRoute(builder: (context) => LoginScreen()),
            //   (Route<dynamic> route) => false,
            // );
          }
        } catch (e) {
          print(e);
        }
      },
    );
  }

  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  enableIOSNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
          alert: true, // Required to display a heads up notification
          badge: true,
          sound: true,
        );
  }

  androidNotificationChannel() => const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.max,
    playSound: true,
    showBadge: true,
    // sound: RawResourceAndroidNotificationSound('notification_sound_tone.mp3'),
  );

  void openPage(String contentType, String contentId) {
    NavigationService.notif_type = contentType;
    NavigationService.notif_id = contentId;
    print("<><> Content Type on tap ===== ${contentType}");
    print("<><> Content Id on tap ===== ${contentId}");
    // var sessionManager = SessionManager();
    if (contentType == "demo_list") {
      appRouter.go(AppRoute.list);
    } else {
      appRouter.go(AppRoute.login);
      // NavigationService.navigatorKey.currentState!.pushAndRemoveUntil(
      //   MaterialPageRoute(builder: (context) => LoginScreen()),
      //   (Route<dynamic> route) => false,
      // );
    }
  }
}
