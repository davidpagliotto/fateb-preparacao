import 'package:aula4/models.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // initialRoute: '/',
      routes: {
        '/ProfilePage': (context) => const ProfilePage(),
        '/ProfileFollowingPage': (context) => const ProfilesFollowingPage(),
      },
      home: Scaffold(
        appBar: AppBar(title: const Text("Perfis"), centerTitle: true),
        body: const Center(child: ProfilePage()),
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilesPage();
}

class _ProfilesPage extends State<ProfilePage> {
  List<Perfil> perfis = [
    Perfil(nome: "Carlos Pereira", imagem: "001.jpeg"),
    Perfil(nome: "João da Silva", imagem: "002.jpeg"),
    Perfil(nome: "Ana Souza", imagem: "003.jpeg"),
    Perfil(nome: "Pedro Lima", imagem: "004.jpeg"),
    Perfil(nome: "Mariah Oliveira", imagem: "005.jpeg"),
  ];
  int perfilAtualIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  if (perfilAtualIndex > 0) {
                    perfilAtualIndex--;
                  } else {
                    perfilAtualIndex = perfis.length - 1;
                  }
                });
              },
              style: TextButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                side: BorderSide.none,
              ),
              child: const Text("<", style: TextStyle(fontSize: 32)),
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                    "assets/${perfis[perfilAtualIndex].imagem}",
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  perfis[perfilAtualIndex].nome,
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      perfis[perfilAtualIndex].alternarSeguir();
                    });
                  },
                  child: Text(
                    perfis[perfilAtualIndex].seguindo == false
                        ? "Seguir"
                        : "Deixar de seguir",
                  ),
                ),
              ],
            ),
            Spacer(),
            TextButton(
              onPressed: () {
                setState(() {
                  if (perfilAtualIndex < perfis.length - 1) {
                    perfilAtualIndex++;
                  } else {
                    perfilAtualIndex = 0;
                  }
                });
              },
              style: TextButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                side: BorderSide.none,
              ),
              child: const Text(
                ">",
                style: TextStyle(fontSize: 32, color: Colors.black),
              ),
            ),
          ],
        ),
        const SizedBox(height: 48),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              "/ProfileFollowingPage",
              arguments: {
                "seguindo": perfis.where((perfil) => perfil.seguindo).toList(),
              },
            );
          },
          child: const Text("Ver quem eu sigo"),
        ),
      ],
    );
  }
}

class ProfilesFollowingPage extends StatefulWidget {
  const ProfilesFollowingPage({super.key});

  @override
  State<ProfilesFollowingPage> createState() => _ProfilesFollowingPageState();
}

class _ProfilesFollowingPageState extends State<ProfilesFollowingPage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final seguindo = args['seguindo'] as List<Perfil>;

    return Scaffold(
      appBar: AppBar(title: Text("Perfis que você está seguindo")),
      body: ListView.builder(
        itemCount: seguindo.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage("assets/${seguindo[index].imagem}"),
            ),
            title: Text(seguindo[index].nome),
          );
        },
      ),
    );
  }
}
