import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Serralheria',
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.grey[100],
        fontFamily: 'Poppins',
      ),
      home: HomePage(),
    );
  }
}

// ================= HOME =================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  final PageController _pageControllerCima =
      PageController(viewportFraction: 0.8);

  final PageController _pageControllerBaixo =
      PageController(viewportFraction: 0.8);

  int _paginaAtualCima = 0;

  Timer? _timerCima;

  int _paginaAtualBaixo = 0;
Timer? _timerBaixo;

  final imagensCima = [
    'assets/images/portao1.jpg',
    'assets/images/portao2.jpg',
    'assets/images/portao3.jpg',
    'assets/images/portao4.jpg',
    'assets/images/portao5.jpg',
  ];

  final imagensBaixo = [
    'assets/images/portao6.jpg',
    'assets/images/portao7.jpg',
    'assets/images/portao8.jpg',
    'assets/images/portao9.jpg',
    'assets/images/portao10.jpg',
  ];

@override
void initState() {
  super.initState();
  iniciarAutoPlayCima();
  iniciarAutoPlayBaixo(); // 👈 ADICIONA ISSO
}

  void iniciarAutoPlayCima() {
    _timerCima = Timer.periodic(Duration(seconds: 3), (timer) {
      if (!mounted) return;

      _paginaAtualCima++;

      if (_paginaAtualCima >= imagensCima.length) {
        _paginaAtualCima = 0;
      }

      _pageControllerCima.animateToPage(
        _paginaAtualCima,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }


void iniciarAutoPlayBaixo() {
  _timerBaixo = Timer.periodic(Duration(seconds: 3), (timer) {
    if (!mounted) return;

    setState(() {
      _paginaAtualBaixo++;

      if (_paginaAtualBaixo >= imagensBaixo.length) {
        _paginaAtualBaixo = 0;
      }
    });

    _pageControllerBaixo.animateToPage(
      _paginaAtualBaixo,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  });
}

 @override
void dispose() {
  _timerCima?.cancel();
  _timerBaixo?.cancel(); // 👈 ADICIONA
  _pageControllerCima.dispose();
  _pageControllerBaixo.dispose();
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            // 🔹 CARROSSEL DE CIMA
            SizedBox(
              height: 250,
              child: PageView.builder(
                controller: _pageControllerCima,
                itemCount: imagensCima.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        imagensCima[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),

            // 🔹 TEXTO CENTRAL
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'Serralheria Roberto Junior',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('Especialista em portões de garagem'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CatalogoPage()),
                      );
                    },
                    child: Text('Ver catálogo'),
                  ),
                ],
              ),
            ),

            // 🔹 CARROSSEL DE BAIXO
            SizedBox(
              height: 250,
              child: PageView.builder(
                controller: _pageControllerBaixo,
                itemCount: imagensBaixo.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        imagensBaixo[index],
                        fit: BoxFit.cover,
                      ),
                    ),
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

// ================= CATÁLOGO =================

// ================= CATÁLOGO =================

class CatalogoPage extends StatelessWidget {
  final List<String> modelos = [
    'assets/images/portao1.jpg',
    'assets/images/portao2.jpg',
    'assets/images/portao3.jpg',
    'assets/images/portao4.jpg',
    'assets/images/portao5.jpg',
    'assets/images/portao6.jpg',
    'assets/images/portao7.jpg',
    'assets/images/portao8.jpg',
    'assets/images/portao9.jpg',
    'assets/images/portao10.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Catálogo')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          itemCount: modelos.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 2,
  crossAxisSpacing: 10,
  mainAxisSpacing: 10,
  childAspectRatio: 1.1, // 👈 TESTA ESSE VALOR
),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetalhesPage(
                      modelo: "Modelo ${index + 1}",
                      imagem: modelos[index],
                    ),
                  ),
                );
              },
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        modelos[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text("Modelo ${index + 1}"),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// ================= DETALHES =================

class DetalhesPage extends StatefulWidget {
  final String modelo;
  final String imagem;

  const DetalhesPage({
    super.key,
    required this.modelo,
    required this.imagem,
  });

  @override
  State<DetalhesPage> createState() => _DetalhesPageState();
}

class _DetalhesPageState extends State<DetalhesPage> {
  String tamanho = "Pequeno";
  String cor = "Branco";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.modelo),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔥 IMAGEM
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                widget.imagem,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              widget.modelo,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const Text("Escolha o tamanho:"),

            DropdownButton<String>(
              value: tamanho,
              items: ["Pequeno", "Médio", "Grande"]
                  .map((t) => DropdownMenuItem(
                        value: t,
                        child: Text(t),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  tamanho = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            const Text("Escolha a cor:"),

            DropdownButton<String>(
              value: cor,
              items: ["Branco", "Preto", "Cinza"]
                  .map((c) => DropdownMenuItem(
                        value: c,
                        child: Text(c),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  cor = value!;
                });
              },
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              child: const Text("Pedir orçamento"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CadastroPage(
                      modelo: widget.modelo,
                      tamanho: tamanho,
                      cor: cor,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

// ================= CADASTRO =================

class CadastroPage extends StatefulWidget {
  final String modelo;
  final String tamanho;
  final String cor;

  const CadastroPage({super.key, 
    required this.modelo,
    required this.tamanho,
    required this.cor,
  });

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final nomeController = TextEditingController();
  final telefoneController = TextEditingController();
  final emailController = TextEditingController();
  final cidadeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Seus dados")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(labelText: "Nome"),
            ),
            TextField(
              controller: telefoneController,
              decoration: InputDecoration(labelText: "Telefone"),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: cidadeController,
              decoration: InputDecoration(labelText: "Cidade/Estado"),
            ),
            SizedBox(height: 20),

            ElevatedButton(
              child: Text("Enviar para WhatsApp"),
              onPressed: () {
                enviarWhatsAppCompleto(
                  widget.modelo,
                  widget.tamanho,
                  widget.cor,
                  nomeController.text,
                  telefoneController.text,
                  emailController.text,
                  cidadeController.text,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

// ================= WHATSAPP =================

void enviarWhatsAppCompleto(
  String modelo,
  String tamanho,
  String cor,
  String nome,
  String telefone,
  String email,
  String cidade,
) async {

  String mensagem =
      "Olá! Gostaria de um orçamento:%0A%0A"
      "👤 Nome: $nome%0A"
      "📞 Telefone: $telefone%0A"
      "📧 Email: $email%0A"
      "📍 Cidade: $cidade%0A%0A"
      "🔧 Modelo: $modelo%0A"
      "📏 Tamanho: $tamanho%0A"
      "🎨 Cor: $cor";

  final Uri uri =
      Uri.parse("https://wa.me/5511945558377?text=$mensagem");

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    print("Erro ao abrir WhatsApp");
  }
}