import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_pad_pa/models/model_evenement/model_evenement.dart';
import 'package:mobile_pad_pa/models/model_infrastructure/model_infrastructure.dart';
import 'package:mobile_pad_pa/models/model_rdv/model_rdv.dart';
import 'package:mobile_pad_pa/screens/appointment/appointmentSubject.dart';
import 'package:mobile_pad_pa/screens/appointment/detailsAppointement.dart';
import 'package:mobile_pad_pa/screens/doReservation/payment/recuView.dart';
import 'package:mobile_pad_pa/screens/doReservation/payment/wavePayment.dart';
import 'package:mobile_pad_pa/screens/notification/notificationScreen.dart';
import '../constantes/codeColors/codeColors.dart';
import '../screens/accueil/listInfrasScreen.dart';
import '../screens/accueil/accueilReservation.dart';
import '../screens/accueil/informationScreen.dart';
import '../screens/appointment/appointmentDetail.dart';
import '../screens/appointment/appointment.dart';
import '../screens/appointment/appointmentScheduling.dart';
import '../screens/appointment/appointmentType.dart';
import '../screens/appointment/discussionChoice.dart';
import '../screens/appointment/pastAppointment.dart';
import '../screens/connexion/signIn.dart';
import '../screens/connexion/signUp.dart';
import '../screens/doReservation/payment/paymentMod.dart';
import '../screens/doReservation/reservationScreen.dart';
import '../screens/event/concertDetail.dart';
import '../screens/event/eventHomePage.dart';
import '../screens/event/matchDetail.dart';
import '../screens/event/ticketReservation.dart';
import '../screens/event/ticketView.dart';
import '../screens/accueil/pageaccueilScreen.dart';
import '../screens/doReservation/payment/saisieOtpScreen.dart';
import '../screens/reservation_history/reservation_detail.dart';
import '../screens/reservation_history/reservation_history.dart';
import '../screens/websocket/websocket.dart';

class AppRouter {
  Evenement evenement;
  Infrastructure infrastructure;
  TypeInfrastructure typeInfrastructure;
  String id;
  AppRouter._(
      this.evenement, this.id, this.infrastructure, this.typeInfrastructure);
  static String iniApp = '/signIn';

  // private Navigator keys
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final _shellNavigatorAcceuilKey =
      GlobalKey<NavigatorState>(debugLabel: 'Accueil');
  static final _shellNavigatorEvenementKey =
      GlobalKey<NavigatorState>(debugLabel: 'Evenement');
  static final _shellNavigatorFaireReservationKey =
      GlobalKey<NavigatorState>(debugLabel: "FaireReservation");
  static final _shellNavigatorReservationKey =
      GlobalKey<NavigatorState>(debugLabel: "Reservation");
  static final _shellNavigatorRendezVousKey =
      GlobalKey<NavigatorState>(debugLabel: 'Mes RDV');

  static final GoRouter router = GoRouter(
      initialLocation: iniApp,
      navigatorKey: _rootNavigatorKey,
      routes: [
        GoRoute(
          path: '/signIn',
          name: 'signIn',
          builder: (context, state) => const SignIn(),
        ),
        GoRoute(
          path: '/signUp',
          name: 'signUp',
          builder: (context, state) => const SignUp(),
        ),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            // List<StatefulShellBranch> branches = getRoutesForProfile(context);
            return ScaffoldWithNestedNavigation(
                navigationShell: navigationShell);
          },
          branches: [
            /*==========================================================*/
            /*=======================ACCUEIL============================*/
            /*==========================================================*/
            StatefulShellBranch(
              navigatorKey: _shellNavigatorAcceuilKey,
              routes: [
                // top route inside branch
                GoRoute(
                    path: '/accueil',
                    name: 'accueil',
                    builder: (context, state) => const PageaccueilScreen(),
                    routes: [
                      GoRoute(
                        path: 'notification',
                        name: 'notification',
                        builder: (context, state) =>
                            const NotificationPageScreen(),
                      ),
                      GoRoute(
                          path: 'listInfras',
                          name: 'listInfras',
                          builder: (context, state) {
                            if (state.extra is TypeInfrastructure) {
                              // Vérification du type
                              final typeInfrastructure =
                                  state.extra as TypeInfrastructure;
                              return ListInfras(
                                  typeInfrastructure: typeInfrastructure);
                            } else {
                              return const Text(
                                  'Error'); // Écran de gestion d'erreur ou retour par défaut
                            }
                          },
                          routes: [
                            GoRoute(
                                path: 'informationScreen',
                                name: 'informationScreen',
                                builder: (context, state) {
                                  final Infrastructure infra =
                                      state.extra as Infrastructure;
                                  return InformationScreen(
                                      infrastructure: infra);
                                },
                                routes: [
                                  GoRoute(
                                      path: 'accueilReservation',
                                      name: 'accueilReservation',
                                      builder: (context, state) {
                                        final Infrastructure infra =
                                            state.extra as Infrastructure;

                                        return AccueilReservation(
                                            infrastructure: infra);
                                      }),
                                ]),
                          ]),
                      GoRoute(
                        path: 'websocket',
                        name: 'websocket',
                        builder: (context, state) => WebSocketTest(),
                      ),
                    ]),
              ],
            ),

            /*==========================================================*/
            /*======================EVENEMENT===========================*/
            /*==========================================================*/

            StatefulShellBranch(
              navigatorKey: _shellNavigatorEvenementKey,
              routes: [
                GoRoute(
                  path: '/eventHomePage',
                  name: 'eventHomePage',
                  builder: (context, state) => const EventHomePageScreen(),
                  routes: [
                    GoRoute(
                      path: 'concertDetail',
                      name: 'concertDetail',
                      builder: (context, state) => const ConcertDetailScreen(),
                    ),
                    GoRoute(
                      path: 'matchDetail/:id',
                      builder: (context, state) {
                        final String id = state.pathParameters['id']!;  // Récupère le paramètre dynamique 'id' dans l'URL
                        final String? origin = state.uri.queryParameters['origin'];  // Utilise queryParameters pour récupérer 'origin'
                        final Evenement event = state.extra as Evenement;  // Récupère l'objet Evenement via extra

                        return MatchDetailScreen(
                          id: id,
                          evenement: event,
                          origin: origin ?? 'defaultOrigin',  // Si 'origin' n'est pas défini, utilise 'defaultOrigin'
                        );
                      },
                    ),

                    GoRoute(
                      path: 'ticketReservation',
                      name: 'ticketReservation',
                      builder: (context, state) =>
                          const TicketReservationScreen(),
                      routes: [
                        GoRoute(
                          path: 'ticketView',
                          name: 'ticketView',
                          builder: (context, state) => const TicketViewScreen(),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            /*==========================================================*/
            /*================== ++FAIRE RESERVATION++ =================*/
            /*==========================================================*/

            StatefulShellBranch(
              navigatorKey: _shellNavigatorFaireReservationKey,
              routes: [
                GoRoute(
                    path: '/doReservation',
                    name: 'doReservation',
                    builder: (context, state) => const DoReservationScreen(),
                    routes: [
                      GoRoute(
                          path: 'paymentMod',
                          name: 'paymentMod',
                          builder: (context, state) => const PaymentModPage(),
                          routes: [
                            GoRoute(
                              path: 'saisieOTP',
                              name: 'saisieOTP',
                              builder: (context, state) => const OtpPage(),
                            ),
                            GoRoute(
                              path: 'wavePayment',
                              name: 'wavePayment',
                              builder: (context, state) =>
                                  const WavePaymentScreen(),
                            ),
                            GoRoute(
                              path: 'recuView',
                              name: 'recuView',
                              builder: (context, state) =>
                                  const RecuViewScreen(),
                            ),
                          ]),
                    ]),
              ],
            ),

            /*==========================================================*/
            /*=======================RESERVATION========================*/
            /*==========================================================*/

            StatefulShellBranch(
              navigatorKey: _shellNavigatorReservationKey,
              routes: [
                GoRoute(
                    path: '/reservation_history',
                    name: 'reservation_history',
                    builder: (context, state) =>
                        const ReservationHistoryScreen(),
                    routes: [
                      GoRoute(
                        path: 'reservation_detail/:id',
                        name: 'reservation_detail',
                        builder: (context, state) {
                          final String? id = state.pathParameters['id'];
                          return ReservationHistoryDetail(id: "$id");
                        },
                      ),
                    ]),
              ],
            ),

            /*==========================================================*/
            /*=====================MES RENDEZ-VOUS======================*/
            /*==========================================================*/

            StatefulShellBranch(
              navigatorKey: _shellNavigatorRendezVousKey,
              routes: [
                GoRoute(
                  path: '/appointment',
                  name: 'appointment',
                  builder: (context, state) => const AppointmentScreen(),
                    routes: [
                    GoRoute(
                      name: 'detailsApointement',
                      path: 'detailsApointement',
                      builder: (context, state) {
                      final appointment = state.extra as RDV; // Récupérer l'objet ici
                      return RendezVousDetailPage(appointment: appointment);
                    },
                    ),
                    GoRoute(
                      path: 'pastAppointment',
                      name: 'pastAppointment',
                      builder: (context, state) =>
                          const PastAppointmentScreen(),
                    ),
                    GoRoute(
                      path: 'appointmentSubject',
                      name: 'appointmentSubject',
                      builder: (context, state) =>
                          const AppointmentSubjectScreen(),
                      routes: [
                        GoRoute(
                          path: 'discussionChoice',
                          name: 'discussionChoice',
                          builder: (context, state) =>
                              const DiscussionChoiceScreen(),
                          routes: [
                            GoRoute(
                              path: 'appointmentType',
                              name: 'appointmentType',
                              builder: (context, state) =>
                                  const AppointmentTypeScreen(),
                              routes: [
                                GoRoute(
                                  path: 'appointmentScheduling',
                                  name: 'appointmentScheduling',
                                  builder: (context, state) =>
                                      const AppointmentSchedulingScreen(),
                                  routes: [
                                    GoRoute(
                                      path: 'appointmentDetail',
                                      name: 'appointmentDetail',
                                      builder: (context, state) =>
                                          AppointmentDetailScreen(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ]);
}
class ScaffoldWithNavigationBar extends StatelessWidget {
  const ScaffoldWithNavigationBar({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    String reservationLabel = screenWidth < 360 ? 'Résv.' : 'Réservation';

    return Scaffold(
      backgroundColor: Colors.white30,
      body: body,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: onDestinationSelected,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: GlobalColors.nextonbording,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          elevation: 8,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 11,
          ),
          items: [
            BottomNavigationBarItem(
              icon: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.all(selectedIndex == 0 ? 8 : 0),
                decoration: BoxDecoration(
                  color: selectedIndex == 0
                      ? GlobalColors.nextonbording.withOpacity(0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.home),
              ),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.all(selectedIndex == 1 ? 8 : 0),
                decoration: BoxDecoration(
                  color: selectedIndex == 1
                      ? GlobalColors.nextonbording.withOpacity(0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.event_note_outlined),
              ),
              label: 'Evenement',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: GlobalColors.nextonbording,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add_box,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.all(selectedIndex == 3 ? 8 : 0),
                decoration: BoxDecoration(
                  color: selectedIndex == 3
                      ? GlobalColors.nextonbording.withOpacity(0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.event_available_outlined),
              ),
              label: reservationLabel,
            ),
            BottomNavigationBarItem(
              icon: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.all(selectedIndex == 4 ? 8 : 0),
                decoration: BoxDecoration(
                  color: selectedIndex == 4
                      ? GlobalColors.nextonbording.withOpacity(0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.calendar_today_outlined),
              ),
              label: 'RDV',
            ),
          ],
        ),
      ),
    );
  }
}

/*
class ScaffoldWithNavigationBar extends StatelessWidget {
  const ScaffoldWithNavigationBar({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    // Récupérer les dimensions de l'écran
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white30,
      body: body,
      bottomNavigationBar: ConvexAppBar(
        elevation: 10,
        backgroundColor: Colors.white,
        color: Colors.grey,
        activeColor: GlobalColors.nextonbording,
        height: 55,
        items: [
          TabItem(
            icon: Icon(
              Icons.home,
              color: selectedIndex == 0 ? Colors.white : Colors.grey,
            ),
            title: 'Accueil',
          ),
          TabItem(
            icon: Icon(
              Icons.event_note_outlined,
              color: selectedIndex == 1 ? Colors.white : Colors.grey,
            ),
            title: 'Evenement',

          ),
          TabItem(
            icon: Icon(
              size: 24,
              Icons.add_box,
              color: selectedIndex == 2 ? Colors.white : Colors.grey,
            ),
            title: '  ',
          ),
          TabItem(
            icon: Icon(
              Icons.event_available_outlined,
              color: selectedIndex == 3 ? Colors.white : Colors.grey,
            ),
            title: 'Réservation',
          ),
          TabItem(
            icon: Icon(
              Icons.calendar_today_outlined,
              color: selectedIndex == 4 ? Colors.white : Colors.grey,
            ),
            title: 'RDV',
          ),
        ],
        initialActiveIndex: selectedIndex,
        onTap: onDestinationSelected,
        curve: Curves.easeInOut, // Optionnel: ajouter une courbe d'animation
      ),
    );
  }
}
*/

/// Widget for the root/initial pages in the bottom navigation bar.
class RootScreen extends StatelessWidget {
  /// Creates a RootScreen
  const RootScreen({required this.label, required this.detailsPath, Key? key})
      : super(key: key);

  /// The label
  final String label;

  /// The path to the detail page
  final String detailsPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.primaryColor,
        title: Text('Tab root - $label'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Screen $label',
                style: Theme.of(context).textTheme.titleLarge),
            const Padding(padding: EdgeInsets.all(4)),
            TextButton(
              onPressed: () => context.go(detailsPath),
              child: const Text('View details'),
            ),
          ],
        ),
      ),
    );
  }
}

/// The details screen for either the Acceuil,Banque,Wallet or Parametres screen.
class DetailsScreen extends StatefulWidget {
  /// Constructs a [DetailsScreen].
  const DetailsScreen({
    required this.label,
    Key? key,
  }) : super(key: key);

  /// The label to display in the center of the screen.
  final String label;

  @override
  State<StatefulWidget> createState() => DetailsScreenState();
}

/// The state for DetailsScreen
class DetailsScreenState extends State<DetailsScreen> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Screen - ${widget.label}'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Details for ${widget.label} - Counter: $_counter',
                style: Theme.of(context).textTheme.titleLarge),
            const Padding(padding: EdgeInsets.all(4)),
            TextButton(
              onPressed: () {
                setState(() {
                  _counter++;
                });
              },
              child: const Text('Increment counter'),
            ),
          ],
        ),
      ),
    );
  }
}

// Stateful navigation based on:
// https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(
            key: key ?? const ValueKey<String>('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return ScaffoldWithNavigationBar(
        body: navigationShell,
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _goBranch,
      );
    });
  }
}
