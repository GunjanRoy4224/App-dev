import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../models/content_model.dart';
import '../../services/content_service.dart';
import '../../widgets/feature_tile.dart';

// Screens
import '../announcements/announcements_screen.dart';
import '../events/events_screen.dart';
import '../blogs/research_blog_screen.dart';
import '../newsletter/newsletter_screen.dart';
import '../internships/internship_screen.dart';
import '../timetable/timetable_screen.dart';
import '../course_material/course_materials_screen.dart';
import '../profile/profile_screen.dart';
import '../digital_id/digital_id_screen.dart';

/// UI constants
const Color bgColor = Color(0xFFF7F7FB);
const Color cardColor = Colors.white;
const Color primaryColor = Color(0xFF4F46E5);
const Color textDark = Color(0xFF111827);
const Color textMuted = Color(0xFF6B7280);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<ContentModel>> announcementsFuture;

  @override
  void initState() {
    super.initState();
    final auth = context.read<AuthProvider>();
    auth.refreshProfile();
    announcementsFuture = ContentService().fetchLatestAnnouncements();
  }

  // ================== CENTRAL NAVIGATION ==================

  void _openFeature(BuildContext context, String feature) {
  // Always close drawer if open
  Navigator.of(context).popUntil((route) => route.isFirst);

  Widget? screen;

  switch (feature) {
    case "Digital ID":
      screen = const DigitalIdScreen();
      break;

    case "Announcements":
      screen = const AnnouncementsScreen();
      break;

    case "Events":
      screen = const EventsScreen();
      break;

    case "Research":
    case "Research Blogs":
      screen = const ResearchScreen();
      break;

    case "Newsletter":
    case "Newsletters":
      screen = const NewslettersScreen();
      break;

    case "Internships":
      screen = const InternshipsScreen();
      break;

    case "Timetable":
      screen = const TimetableScreen();
      break;

    case "Course Material":
      screen = CourseMaterialsScreen();
      break;

    case "Profile":
      screen = const ProfileScreen();
      break;
  }

  if (screen != null) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => screen!),
    );
  }
}



  // ================== BUILD ==================

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final user = authProvider.user;

    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bgColor,
        title: Row(
          children: [
            Image.asset(
              "assets/images/esea_logo.png",
              height: 28,
            ),
            const SizedBox(width: 10),
            const Text(
              "ESEA App",
              style: TextStyle(
                color: textDark,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: textDark),
      ),
      drawer: _buildDrawer(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _welcomeCard(user),
            const SizedBox(height: 20),
            _announcementSection(context),
            const SizedBox(height: 24),
            _featuresSection(),
          ],
        ),
      ),
    );
  }

  // ================== UI SECTIONS ==================

  Widget _welcomeCard(user) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Welcome ",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: textDark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            (user.name ?? "Student").split(" ").first,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 6),
          Text(
            "${user.department} • ${user.year}",
            style: const TextStyle(fontSize: 13, color: textMuted),
          ),
        ],
      ),
    );
  }

  Widget _announcementSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Latest Announcements",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () =>
                    _openFeature(context, "Announcements"),
                child: const Text(
                  "View all",
                  style: TextStyle(color: primaryColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          FutureBuilder<List<ContentModel>>(
            future: announcementsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.all(12),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (snapshot.hasError) {
                return _announcementPlaceholder(
                  "Announcements will appear here once available",
                );
              }

              final data = snapshot.data ?? [];

              if (data.isEmpty) {
                return _announcementPlaceholder("No announcements yet");
              }

              return Column(
                children: data.map((a) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(a.title),
                    subtitle: Text(
                      a.shortDescription ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: textMuted),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _announcementPlaceholder(String text) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(color: textMuted),
      ),
    );
  }

  Widget _featuresSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Features",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            FeatureTile(
              icon: Icons.badge,
              label: "Digital ID",
              onTap: () => _openFeature(context, "Digital ID"),
            ),
            FeatureTile(
              icon: Icons.campaign,
              label: "Announcements",
              onTap: () => _openFeature(context, "Announcements"),
            ),
            FeatureTile(
              icon: Icons.event,
              label: "Events",
              onTap: () => _openFeature(context, "Events"),
            ),
            FeatureTile(
              icon: Icons.article,
              label: "Research",
              onTap: () => _openFeature(context, "Research"),
            ),
            FeatureTile(
              icon: Icons.newspaper,
              label: "Newsletter",
              onTap: () => _openFeature(context, "Newsletter"),
            ),
            FeatureTile(
              icon: Icons.work,
              label: "Internships",
              onTap: () => _openFeature(context, "Internships"),
            ),
            FeatureTile(
              icon: Icons.schedule,
              label: "Timetable",
              onTap: () => _openFeature(context, "Timetable"),
            ),
            FeatureTile(
              icon: Icons.menu_book,
              label: "Course Material",
              onTap: () =>
                  _openFeature(context, "Course Material"),
            ),
            FeatureTile(
              icon: Icons.person,
              label: "Profile",
              onTap: () => _openFeature(context, "Profile"),
            ),
          ],
        ),
      ],
    );
  }

  // ================== DRAWER ==================

  Drawer _buildDrawer(BuildContext context) {
    final user = context.read<AuthProvider>().user!;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _drawerHeader(user),
          _drawerItem(context, "Digital ID"),
          _drawerItem(context, "Announcements"),
          _drawerItem(context, "Events"),
          _drawerItem(context, "Research Blogs"),
          _drawerItem(context, "Newsletters"),
          _drawerItem(context, "Internships"),
          _drawerItem(context, "Timetable"),
          _drawerItem(context, "Course Material"),
          _drawerItem(context, "Profile"),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () {
              context.read<AuthProvider>().logout();
            },
          ),
        ],
      ),
    );
  }

  Widget _drawerHeader(user) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, Color(0xFF6366F1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.white,
            child: Text(
              (user.name?.isNotEmpty == true
                  ? user.name![0].toUpperCase()
                  : "S"),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${user.department} • ${user.year}",
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Roll: ${user.rollNumber}",
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListTile _drawerItem(BuildContext context, String title) {
    return ListTile(
      title: Text(title),
      onTap: () => _openFeature(context, title),
    );
  }
}
