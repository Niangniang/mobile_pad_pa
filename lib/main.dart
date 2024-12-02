import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mobile_pad_pa/providers/provider_announcement/provider_announcement.dart';
import 'package:mobile_pad_pa/providers/provider_authentification/provider_authentification.dart';
import 'package:mobile_pad_pa/providers/provider_creneau/provider_creneau.dart';
import 'package:mobile_pad_pa/providers/provider_creneau/provider_creneauEvent.dart';
import 'package:mobile_pad_pa/providers/provider_creneau/provider_creneau_personneDemandee.dart';
import 'package:mobile_pad_pa/providers/provider_evenement/provider_evenement.dart';
import 'package:mobile_pad_pa/providers/provider_firebase/provider_firebase.dart';
import 'package:mobile_pad_pa/providers/provider_infrastructure/provider_infrastruture.dart';
import 'package:mobile_pad_pa/providers/provider_objetRDV/provider_objetRDV.dart';
import 'package:mobile_pad_pa/providers/provider_paiement/provider_paiement.dart';
import 'package:mobile_pad_pa/providers/provider_personneDemande/provider_personneDemande.dart';
import 'package:mobile_pad_pa/providers/provider_rdv/provider_rdv.dart';
import 'package:mobile_pad_pa/providers/provider_typeEvenement/provider_typeEvenement.dart';
import 'package:mobile_pad_pa/providers/provider_typeInfrastructure/provider_typeInfrastructure.dart';
import 'package:mobile_pad_pa/providers/provider_utilisateur/provider_utilisateur.dart';
import 'package:mobile_pad_pa/providers/provider_websocket/provider_websocket.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'routes/appRouter.dart';  // Assurez-vous que votre AppRouter est configuré correctement
import 'constantes/codeColors/codeColors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  /*FirebaseApi firebaseApi = FirebaseApi();
  await firebaseApi.initNotification();*/

  // Activer l'auto-init des messages pour FCM
  FirebaseMessaging.instance.setAutoInitEnabled(true);
  // Configurer la gestion des messages en arrière-plan
  FirebaseMessaging.onBackgroundMessage(FirebaseApi.handleBackgroundMessage);
  // S'abonner à un sujet (par exemple, "all")
  FirebaseMessaging.instance.subscribeToTopic("all");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => InfrastructureProvider()),
        ChangeNotifierProvider(create: (_) => TypeEvenementProvider()),
        ChangeNotifierProvider(create: (_) => PaiementProvider()),
        ChangeNotifierProvider(create: (_) => ObjetRDVProvider()),
        ChangeNotifierProvider(create: (_) => RDVProvider()),
        ChangeNotifierProvider(create: (_) => PersonneDemandeProvider()),
        ChangeNotifierProvider(create: (_) => CreneauProvider()),
        ChangeNotifierProvider(create: (_) => CreneauEventProvider()),
        ChangeNotifierProvider(create: (_) => TypeInfrastructureProvider()),
        ChangeNotifierProvider(create: (_) => WebSocketGestionInfraProvider()),
        ChangeNotifierProvider(create: (_) => WebSocketAnnouncementProvider()),
        ChangeNotifierProvider(create: (_) => CreneauPersonneDemandeProvider()),
        ChangeNotifierProvider(create: (_) => FirebaseProvider()),
        ChangeNotifierProvider(create: (_) => UtilisateurProvider()),

        ChangeNotifierProxyProvider<WebSocketGestionInfraProvider, EvenementProvider>(
          create: (context) => EvenementProvider(),
          update: (context, webSocketProvider, evenementProvider) => evenementProvider!..setWebSocketGIProvider(webSocketProvider),
        ),
        ChangeNotifierProxyProvider<WebSocketAnnouncementProvider, AnnouncementProvider>(
          create: (context) => AnnouncementProvider(),
          update: (context, webSocketProvider, evenementProvider) => evenementProvider!..setWebSocketGAProvider(webSocketProvider),
        ),
      ],
      child: const MyApp(),
    )
    ,
  );
}

class FirebaseApi {
  // Gestion des messages en arrière-plan
  static Future<void> handleBackgroundMessage(RemoteMessage message) async {
    await Firebase.initializeApp();
    debugPrint("Handling a background message: ${message.messageId}");
    debugPrint("Handling a background message title: ${message.notification?.title}");
    debugPrint("Handling a background message body: ${message.notification?.body}");
    debugPrint("Handling a background message data: ${message.data}");
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;



  Future<void> initNotification(BuildContext context) async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    debugPrint("Token up ==> $fCMToken");

    if (fCMToken != null) {
      // Utilisez l'instance du FirebaseProvider à partir du contexte
      final firebaseProvider = Provider.of<FirebaseProvider>(context, listen: false);
      firebaseProvider.setTokenFirebase(fCMToken); // Met à jour le token dans le Provider
    } else {
      debugPrint("Échec de la récupération du token Firebase");
    }

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    // Gestion des messages en premier plan
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("Message reçu: ${message.notification?.title}");
      debugPrint("Corps du message: ${message.notification?.body}");
      debugPrint("Données du message: ${message.data}");

      bool isExpanded = false;

      showSimpleNotification(
        StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Colors.white70.withOpacity(0.9),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/pa_icon.png',
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message.notification?.title ?? 'Notification',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                message.notification?.body ?? 'No body',
                                maxLines: isExpanded ? null : 2,
                                overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.black),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    isExpanded ? Icons.arrow_upward : Icons.arrow_downward,
                                    size: 16,
                                    color: Colors.black54,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        background: Colors.transparent,
        duration: const Duration(seconds: 10),
        position: NotificationPosition.top,
      );
    });

    // Gestion des messages lorsque l'application est en arrière-plan et que l'utilisateur clique sur la notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("Message cliqué: ${message.notification?.title}");
    });
  }



}



class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late Future<void> _firebaseInit;

  @override
  void initState() {
    // Initialiser Firebase API avec le contexte après que l'application est rendue
    _firebaseInit = _initializeFirebaseApi();
  }


  Future<void> _initializeFirebaseApi() async {
    FirebaseApi firebaseApi = FirebaseApi();
    await firebaseApi.initNotification(context); // Passer le BuildContext ici
  }
  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,  // Utilisation de la configuration de routage avec les observers définis
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: GlobalColors.primaryColor),
          useMaterial3: true,
        ),
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late FirebaseMessaging messaging;
  late WebSocketGestionInfraProvider webSocketProvider; // Déclarez WebSocketProvider

  @override
  void initState() {
    super.initState();

    // Initialisation de WebSocketProvider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      webSocketProvider = Provider.of<WebSocketGestionInfraProvider>(context, listen: false);
      webSocketProvider.initializeWebSocket();
    });

    messaging = FirebaseMessaging.instance;

    // Demander la permission pour les notifications
    messaging.requestPermission();

    // Récupérer le token de l'appareil
    messaging.getToken().then((token) {
      debugPrint("Token: $token");
    });

    // Gérer les messages en premier plan
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {

      debugPrint("Message reçu: ${message.notification?.title}");
      debugPrint("Corps du message: ${message.notification?.body}");
      // Affichez les données supplémentaires si nécessaire
      debugPrint("Données du message: ${message.data}");

      showSimpleNotification(
        Container(
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            children: [
              Image.asset(
                'assets/images/pa_icon.png',
                width: 40,
                height: 40,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message.notification?.title ?? 'Notification',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      message.notification?.body ?? 'No body',
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        background: Colors.transparent, // Ensure the custom background is applied
        duration: const Duration(seconds: 10),
        position: NotificationPosition.top,
        elevation: 0, // Disable elevation
      );

    });

    // Gérer les messages lorsque l'application est en arrière-plan
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("Message cliqué: ${message.notification?.title}");
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Assurez-vous que WebSocketProvider est disponible ici
    if (webSocketProvider == null) {
      webSocketProvider = Provider.of<WebSocketGestionInfraProvider>(context, listen: false);
      webSocketProvider.initializeWebSocket();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Accueil"),
      ),
      body: const Center(
        child: Text("Contenu de la page d'accueil"),
      ),
    );
  }
}
