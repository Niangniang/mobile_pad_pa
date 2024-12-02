import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_pad_pa/constantes/codeColors/codeColors.dart';
import 'package:mobile_pad_pa/constantes/textStyles/textStyle.dart';
import 'accueil/pageaccueilScreen.dart';
import 'pageaccueilScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Réservation Stade',
      home: OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0;
  final PageController _pageController = PageController();
  List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/Soccer-amico.svg",
      "title": "Réservation de stade",
      "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum nisi dolor, feugiat sed gravida nec, accumsan a mi. Ut quis augue gravida erat facilisis volutpat. Phasellus a malesuada sem"
    },
    {
      "image": "assets/images/Parking-amico.svg",
      "title": "Parking",
      "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum nisi dolor, feugiat sed gravida nec, accumsan a mi. Ut quis augue gravida erat facilisis volutpat. Phasellus a malesuada sem."
    },
    {
      "image": "assets/images/PresidentDay-amico.svg",
      "title": "Meeting",
      "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum nisi dolor, feugiat sed gravida nec, accumsan a mi. Ut quis augue gravida erat facilisis volutpat. Phasellus a malesuada sem."
    },
    {
      "image": "assets/images/Playingjazz-amico.svg",
      "title": "Concert",
      "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum nisi dolor, feugiat sed gravida nec, accumsan a mi. Ut quis augue gravida erat facilisis volutpat. Phasellus a malesuada sem."
    },
    // Ajoutez autant de cartes que vous avez de pages d'onboarding
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.onbordingbackgroundColor,
      body: Column(
        children:[
          Expanded(
            flex: 3,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              itemCount: onboardingData.length,
              itemBuilder: (context, index) => OnboardingContent(
                image: onboardingData[index]["image"]!,
                title: Text(onboardingData[index]["title"]!,style: TypoStyle.textLabelStyleS30W600CGreen,), // Assurez-vous que la clé 'title' existe dans chaque map de la liste onboardingData
                description: Text(onboardingData[index]["description"]!, style: TypoStyle.textLabelStyleS14W600CGreen,), // De même pour la clé 'description'
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    onboardingData.length,
                        (index) => buildDot(index: index),
                  ),
                ),
                const Spacer(flex: 3),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56, // Hauteur du bouton
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(GlobalColors.nextonbording), // Utilisez MaterialStateProperty.all pour définir une couleur fixe
                      ),
                      onPressed: () {
                        if (currentPage < onboardingData.length - 1) {
                          // Si ce n'est pas la dernière page, passez à la page suivante.
                          _pageController.animateToPage(
                            currentPage + 1,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          // Si c'est la dernière page, naviguez vers une autre page (par exemple, HomePage).
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PageaccueilScreen()));
                        }
                      },
                      child: Text(
                        'Suivant',
                        style: TypoStyle.textLabelStyleS20W600CWhite,
                      ),
                    ),

                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildDot({required int index}) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: GlobalColors.nextonbording,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}



class OnboardingContent extends StatelessWidget {
  final String image;
  final Text title;
  final Text description;

  const OnboardingContent({super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16,right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            image,
            height: 300, // Vous pouvez ajuster la taille selon vos besoins.
          ),
          const SizedBox(height: 40), // Un peu d'espace entre l'image et le texte

          // Un peu d'espace entre les deux textes
          title,
          const SizedBox(height: 20),
          description
        ],
      ),
    );
  }
}

