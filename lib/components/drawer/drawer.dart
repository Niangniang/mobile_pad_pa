import 'package:flutter/material.dart';
import 'package:mobile_pad_pa/constantes/textStyles/textStyle.dart';

class CustomDrawer extends StatefulWidget  {
  const CustomDrawer({super.key});


  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String selectedMenuItem = 'Gestion Réservations';  // Par défaut, 'Accueil' est sélectionné

  void _onMenuItemSelected(String item) {
    setState(() {
      selectedMenuItem = item;
    });
    Navigator.pop(context);  // Ferme le Drawer après la sélection
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const SizedBox(
           height: 80,
          ),
          buildListTile(
          icon: Icons.home,
          title: 'Accueil',
          isSelected: selectedMenuItem == 'Accueil',
          onTap: () => _onMenuItemSelected('Accueil'),
        ),
          buildListTile(
            icon: Icons.event,
            title: 'Gestion Évènement',
            isSelected: selectedMenuItem == 'Gestion Évènement',
            onTap: () => _onMenuItemSelected('Gestion Évènement'),
          ),
          buildListTile(
            icon: Icons.announcement,
            title: 'Gestion Annonces',
            isSelected: selectedMenuItem == 'Gestion Annonces',
            onTap: () => _onMenuItemSelected('Gestion Annonces'),
          ),
          buildListTile(
            icon: Icons.book_online,
            title: 'Gestion Réservations',
            isSelected: selectedMenuItem == 'Gestion Réservations',
            onTap: () => _onMenuItemSelected('Gestion Réservations'),
          ),
          buildListTile(
            icon: Icons.people,
            title: 'Gestion Utilisateurs',
            isSelected: selectedMenuItem == 'Gestion Utilisateurs',
            onTap: () => _onMenuItemSelected('Gestion Utilisateurs'),
          ),
          buildListTile(
            icon: Icons.calendar_today,
            title: 'Gestion Rendez-vous',
            isSelected: selectedMenuItem == 'Gestion Rendez-vous',
            onTap: () => _onMenuItemSelected('Gestion Rendez-vous'),
          ),
          buildListTile(
            icon: Icons.local_parking,
            title: 'Parking',
            isSelected: selectedMenuItem == 'Parking',
            onTap: () => _onMenuItemSelected('Parking'),
          ),
          buildListTile(
            icon: Icons.calendar_view_month,
            title: 'Calendrier',
            isSelected: selectedMenuItem == 'Calendrier',
            onTap: () => _onMenuItemSelected('Calendrier'),
          ),
          buildListTile(
            icon: Icons.settings,
            title: 'Paramètre',
            isSelected: selectedMenuItem == 'Paramètre',
            onTap: () => _onMenuItemSelected('Paramètre'),
          ),

          const SizedBox(height: 50,),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Déconnexion', style:
            TypoStyle.textLabelStyleS16W500CRed1),
              tileColor: Colors.redAccent.withOpacity(0.1),
            onTap: () {
              // Handle logout
            },
          ),
        ],
      ),
    );
  }
}


Widget buildListTile({
  required IconData icon,
  required String title,
  required bool isSelected,
  required Function() onTap,
}) {
  return ListTile(
    leading: Icon(icon, color: isSelected ? Colors.green : Colors.black),
    title: Text(
      title,
      style: TypoStyle.textLabelStyleS16W500CBlack1.copyWith(
        color: isSelected ? Colors.green : Colors.black,
      ),
    ),
    tileColor: isSelected ? Colors.green.withOpacity(0.1) : null,
    onTap: onTap,
  );
}
