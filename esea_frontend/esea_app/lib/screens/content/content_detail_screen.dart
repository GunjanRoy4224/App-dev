import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/content_model.dart';

class ContentDetailScreen extends StatelessWidget {
  final ContentModel item;

  const ContentDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.title)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(item.shortDescription),
            const SizedBox(height: 24),

            if (item.fileUrl != null)
              ElevatedButton(
                onPressed: () => _open(item.fileUrl!),
                child: const Text("Open Document"),
              ),

            if (item.externalLink != null)
              OutlinedButton(
                onPressed: () => _open(item.externalLink!),
                child: const Text("Open Link"),
              ),
          ],
        ),
      ),
    );
  }

  void _open(String url) async {
    if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
      throw "Could not open $url";
    }
  }
}
