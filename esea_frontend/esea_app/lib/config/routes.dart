import 'package:flutter/material.dart';
import '../screens/auth/login_sso_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/timetable/timetable_screen.dart';
import '../screens/events/events_screen.dart';
import '../screens/course_material/course_materials_screen.dart';
import '../screens/internships/internship_screen.dart';
import '../screens/newsletter/newsletter_screen.dart';
import '../screens/blogs/research_blog_screen.dart';
import '../screens/announcements/announcements_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/digital_id/digital_id_screen.dart';

class AppRoutes {
  static const login = '/login';
  static const home = '/home';
  
  static const String timetable = '/timetable';
  static const String events = '/events';
  static const String digitalId = '/digital_id';
  static const String materials = '/course-materials';
  static const String internships = '/internships';
  static const String newsletter = '/newsletter';
  static const String blogs = '/blogs';
  static const String announcements = '/announcements';
  static const String profile = '/profile';

  static Map<String, WidgetBuilder> get routes => {
     
        login: (context) => const LoginSSOScreen(),

        home: (context) => const HomeScreen(),
        digitalId: (context) => const DigitalIdScreen(),
        timetable: (context) => const TimetableScreen(),
        events: (context) => const EventsScreen(),
        materials: (context) =>  CourseMaterialsScreen(),
        internships: (context) => const InternshipsScreen(),
        newsletter: (context) => const NewslettersScreen(),
        blogs: (context) => const ResearchScreen(),
        announcements: (context) => const AnnouncementsScreen(),
        profile: (context) => const ProfileScreen(),
      };
}
