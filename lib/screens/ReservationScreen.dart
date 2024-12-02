
import 'package:flutter/material.dart';
import 'package:mobile_pad_pa/constantes/codeColors/codeColors.dart';
import 'package:mobile_pad_pa/constantes/textStyles/textStyle.dart';
import 'package:mobile_pad_pa/models/model_infrastructure/model_infrastructure.dart';
import 'package:mobile_pad_pa/providers/provider_infrastructure/provider_infrastruture.dart';
import 'package:provider/provider.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Réservation d\'écran',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ReservationScreen(),
    );
  }
}

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  _ReservationScreennState createState() => _ReservationScreennState();





}


class ButtonsGrid extends StatelessWidget {
  const ButtonsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer <InfrastructureProvider>(builder: (context,provider,child){

      return ListView.builder(itemBuilder: (context,index){
        Infrastructure infra = provider.listInfras[index];
        return Center(
          child:
          Wrap(
            spacing: 5.0, // gap between adjacent chips
            runSpacing: 0.5, // gap between lines
            children: <Widget>[
              MyButton(infrastructure: infra),
              // Add more buttons if needed
            ],
          ),
        );

      });

    });
  }
}

class MyButton extends StatelessWidget {
  final Infrastructure infrastructure;

  const MyButton({super.key, required this.infrastructure, });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
      const EdgeInsets.symmetric(vertical: 8.0), // space between buttons
      child: ElevatedButton(
        onPressed: () {
          // Your button action here
          Provider.of<InfrastructureProvider>(context, listen: true).setSingleInfra(infrastructure);
          debugPrint("select infra ==> ${Provider.of<InfrastructureProvider>(context, listen: true).infra}");
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.grey[200], // text color
        ),
        child: Text("${infrastructure.id}"),
      ),
    );
  }
}




class _ReservationScreennState extends State<ReservationScreen> {


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar : AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 8.0), // Ajoutez du padding à gauche du CircleAvatar
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/profil_accueil.png'),
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.5), // Ajoute du padding à gauche et à droite du titre
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Pour aligner le texte à gauche
            mainAxisSize: MainAxisSize.min, // Pour empêcher la colonne de s'étendre
            children: [
              Text(
                'Bienvenue',
                style: TypoStyle.textLabelStyleS20W700CBlack1,
              ),
              Text(
                'Macky Dramé',
                style: TypoStyle.textLabelStyleS22W600CGreen1,
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black, size: 35,),
            onPressed: () {
              // Action quand l'icône est pressée
            },
          ),
          const SizedBox(width: 14), // Ajoute du padding à droite du dernier élément
        ],
        elevation: 30,
      ),

        body: Padding(
          padding: const EdgeInsets.only(left: 16, top: 10, right: 16, bottom: 10),
         child: SingleChildScrollView(
          child: Column(

            // Utilisez MainAxisAlignment pour aligner les enfants verticalement comme vous le souhaitez
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Row(
                // Utilisez MainAxisAlignment pour aligner les enfants horizontalement comme vous le souhaitez
                children: <Widget>[
                  // Ajoutez vos widgets pour la première ligne
                  Text('Que souhaitez-vous faire'),

                ],
              ),
              const SizedBox(height: 1), // Espacement entre les lignes

              const ButtonsGrid(),
              const SizedBox(height: 5),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: EdgeInsets.only(left: 0, right: 0, top: 3, bottom: 5),
                    child: Text(
                      'Nom de l\'événement',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                ],
             ),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 6,
                      child: TextFormField(
                        initialValue: 'Macky Dramé',
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(8))
                          ),
                          // If you want to add padding to the text inside the TextFormField, you can do it like this:
                          // contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        ),
                        style: const TextStyle(fontSize: 16,),
                      ),
                    ),
                  ]
              ),
              const SizedBox(height: 12),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: EdgeInsets.only(left: 0, right: 0, top: 3, bottom: 5),
                      child: Text(
                        'Nom de l\'événement',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 6,
                      child: TextFormField(
                        initialValue: 'Macky Dramé',
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(Radius.circular(8))
                          ),
                          // If you want to add padding to the text inside the TextFormField, you can do it like this:
                          // contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        ),
                        style: const TextStyle(fontSize: 16,),
                      ),
                    ),
                  ]
              ),

              const SizedBox(height: 12),

              const Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: EdgeInsets.only(left: 0, right: 0, top: 3, bottom: 5),
                      child: Text(
                        'Choisir une heure',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 6,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'De',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8), // Espacement entre le texte et le champ
                              TextFormField(
                                initialValue: 'Macky Dramé',
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                  ),
                                ),
                                style: const TextStyle(fontSize: 16,),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8), // Espacement entre les deux colonnes
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'A`',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8), // Espacement entre le texte et le champ
                              TextFormField(
                                initialValue: 'Autre valeur',
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                  ),
                                ),
                                style: const TextStyle(fontSize: 16,),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: EdgeInsets.only(left: 0, right: 0, top: 3, bottom: 5),
                      child: Text(
                        'Choisir une heure',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
              const Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 6,
                      child: TextField(
                        maxLines: 6,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(Radius.circular(8))
                          ),
                          // If you want to add padding to the text inside the TextFormField, you can do it like this:
                          // contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        ),
                        style: TextStyle(fontSize: 16,),
                      ),
                    ),
                  ]
              ),




              // Vous pouvez ajouter autant de lignes que vous le souhaitez
              // ...
            ],
          ),
       ),
        ),


        floatingActionButton: FloatingActionButton(

        onPressed: () {
          // Ajoutez l'action du bouton
        },
        backgroundColor: GlobalColors.nextonbording,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: GlobalColors.backgroundColor, size: 32,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 20,
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(icon: const Icon(Icons.home, size: 30, ), onPressed: () {}),
            IconButton(icon: const Icon(Icons.event_note_outlined, size: 28,), onPressed: () {}),
            const SizedBox(width: 48), // Créez de l'espace pour le FloatingActionButton
            IconButton(icon: const Icon(Icons.event_available_outlined, size: 28,), onPressed: () {}),
            IconButton(icon: const Icon(Icons.calendar_today_outlined, size: 26,), onPressed: () {}),
          ],
        ),
      ),
    );
  }

}
