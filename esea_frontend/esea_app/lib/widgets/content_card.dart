import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/content_model.dart';

class ContentCard extends StatelessWidget {
  final ContentModel content;

  const ContentCard({super.key, required this.content});

  Future<void> _handleTap() async {
    if (content.type == "internship" && content.externalLink != null) {
      await launchUrl(
        Uri.parse(content.externalLink!),
        mode: LaunchMode.externalApplication,
      );
      return;
    }

    if (content.fileUrl != null) {
      await launchUrl(
        Uri.parse(content.fileUrl!),
        mode: LaunchMode.inAppBrowserView,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: _handleTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (content.imageUrl != null &&
                content.type != "announcement")
              Image.network(
                content.imageUrl!,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
              ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    content.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    content.shortDescription,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),

                  if (content.dateOrDeadline != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      content.dateOrDeadline!,
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
