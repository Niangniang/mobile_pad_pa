import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_pad_pa/constantes/textStyles/textStyle.dart';
import 'package:mobile_pad_pa/providers/provider_announcement/provider_announcement.dart';
import 'package:mobile_pad_pa/providers/provider_authentification/provider_authentification.dart';
import 'package:provider/provider.dart';

class NotificationPageScreen extends StatefulWidget {
  const NotificationPageScreen({super.key});

  @override
  State<NotificationPageScreen> createState() => _NotificationPageScreenState();
}

class _NotificationPageScreenState extends State<NotificationPageScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadData();
    });
  }

  void loadData() async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var announcementProvider = Provider.of<AnnouncementProvider>(context, listen: false);
    await announcementProvider.getAllAnnouncementsByUser(
      context: context,
      id: authProvider.authLogin!.user.id!,
      accessToken: authProvider.authLogin!.access,
    );

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var announcementProvider = Provider.of<AnnouncementProvider>(context);
    var announcementList = announcementProvider.listNotifs;

    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/profil_accueil.png'),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Bienvenue',
                style: TypoStyle.textLabelStyleS18W600CBlack1,
              ),
              Text(
                "${authProvider.authLogin?.user.prenom} ${authProvider.authLogin?.user.nom}",
                style: TypoStyle.textLabelStyleS22W600CGreen1,
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_outlined,
              color: Colors.black,
              size: 35,
            ),
            onPressed: () {
              context.goNamed("notification");
            },
          ),
          const SizedBox(width: 14),
        ],
        elevation: 30,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.only(left: 16, top: 10, right: 16, bottom: 10),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: announcementList.length,
          itemBuilder: (context, index) {
            var notif = announcementList[index];
            return NotificationTile(
              avatarImage: 'assets/images/pa_icon.png',
              title: "${notif.titre}",
              description: "${notif.message}",
              time: 'Hier à 10H 30min}',
            );
          },
        ),
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final String avatarImage;
  final String title;
  final String description;
  final String time;

  NotificationTile({
    required this.avatarImage,
    required this.title,
    required this.description,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(avatarImage),
        radius: 30,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            description,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          Text(
            time,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
