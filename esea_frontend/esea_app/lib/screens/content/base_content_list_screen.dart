import 'package:flutter/material.dart';
import '../../models/content_model.dart';
import '../../services/content_service.dart';
import '../../widgets/content_card.dart';


class BaseContentListScreen extends StatefulWidget {
  final String title;
  final String contentType;

  const BaseContentListScreen({
    super.key,
    required this.title,
    required this.contentType,
  });

  @override
  State<BaseContentListScreen> createState() =>
      _BaseContentListScreenState();
}

class _BaseContentListScreenState extends State<BaseContentListScreen> {
  late Future<List<ContentModel>> _future;

  @override
  void initState() {
    super.initState();
    _future = ContentService().fetchByType(widget.contentType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: FutureBuilder<List<ContentModel>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No content available"));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ContentCard(content: snapshot.data![index]);
            },
          );
        },
      ),
    );
  }
}
