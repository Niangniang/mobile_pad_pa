import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_pad_pa/models/model_infrastructure/model_infrastructure.dart';
import 'package:mobile_pad_pa/providers/provider_authentification/provider_authentification.dart';
import 'package:mobile_pad_pa/providers/provider_infrastructure/provider_infrastruture.dart';
import 'package:provider/provider.dart';
import '../../components/cards/stadeCard.dart';

class ListInfras extends StatefulWidget {
  final TypeInfrastructure typeInfrastructure;
  const ListInfras({super.key, required this.typeInfrastructure});

  @override
  State<ListInfras> createState() => _ListInfrasState();
}

class _ListInfrasState extends State<ListInfras> {
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
    var provider = Provider.of<InfrastructureProvider>(context, listen: false);
    await provider.getAllInfrastructuresByType(
      context: context,
      id: widget.typeInfrastructure.id!,
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Les Infrastructures disponibles'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Liste de stades des Parcelles assainies',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Utilisation de Consumer pour écouter les changements dans InfrastructureProvider
            Expanded(
              child: Consumer<InfrastructureProvider>(
                builder: (context, provider, child) {
                  var typeInfras = provider.listInfrasType; // Récupérer la liste des infrastructures depuis le provider

                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 3,
                    ),
                    itemCount: typeInfras.length,
                    shrinkWrap: true,
                    primary: false, // Ajouté pour optimiser les performances
                    itemBuilder: (context, index) {
                      var infrastructure = typeInfras[index];
                      return GestureDetector(
                        onTap: () {
                          provider.setSingleInfraById(infrastructure.id!);
                          context.goNamed(
                            'informationScreen',
                            extra: infrastructure, // Envoie l'objet infrastructure
                          );
                        },
                        child: StadeCard(infrastructure: infrastructure),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
