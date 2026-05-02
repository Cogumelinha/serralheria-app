import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
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
      ),
      home: const HomePage(),
    );
  }
}

// ================= HOME =================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _cima = PageController(viewportFraction: 0.8);
  final PageController _baixo = PageController(viewportFraction: 0.8);

  int iCima = 0;
  int iBaixo = 0;

  Timer? t1;
  Timer? t2;

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

    t1 = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted) return;
      iCima = (iCima + 1) % imagensCima.length;
      _cima.animateToPage(iCima,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut);
    });

    t2 = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted) return;
      iBaixo = (iBaixo + 1) % imagensBaixo.length;
      _baixo.animateToPage(iBaixo,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut);
    });
  }

  @override
  void dispose() {
    t1?.cancel();
    t2?.cancel();
    _cima.dispose();
    _baixo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BotaoErro(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 250,
              child: PageView.builder(
                controller: _cima,
                itemCount: imagensCima.length,
                itemBuilder: (_, i) => Padding(
                  padding: const EdgeInsets.all(8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(imagensCima[i], fit: BoxFit.cover),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Serralheria Roberto Junior',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),
            const Text('Especialista em portões de garagem'),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CatalogoPage()),
                );
              },
              child: const Text('Ver catálogo'),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 250,
              child: PageView.builder(
                controller: _baixo,
                itemCount: imagensBaixo.length,
                itemBuilder: (_, i) => Padding(
                  padding: const EdgeInsets.all(8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(imagensBaixo[i], fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= CATÁLOGO =================

class CatalogoPage extends StatelessWidget {
  CatalogoPage({super.key});

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
      appBar: AppBar(title: const Text('Catálogo')),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: modelos.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetalhesPage(
                    modelo: "Modelo ${index + 1}",
                    imagem: modelos[index], // 👈 agora é só 1 imagem
                  ),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                modelos[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
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
  final tamanhoController = TextEditingController();
  String cor = "Branco";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.modelo)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // 👈 ESSENCIAL
            children: [
              // 🔥 IMAGEM
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  widget.imagem,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 20),

              // 🔹 TAMANHO
              const Text(
                "Informe o tamanho do portão:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: tamanhoController,
                decoration: InputDecoration(
                  hintText: "Ex: 3m x 2.5m",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 🔹 COR
              const Text(
                "Escolha a cor:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              DropdownButtonFormField<String>(
                value: cor,
                items: ["Branco", "Preto", "Cinza"]
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (v) => setState(() => cor = v!),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // 🔥 BOTÃO CONTINUAR
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text("Continuar"),
                onPressed: () {
                  if (tamanhoController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Informe o tamanho do portão"),
                      ),
                    );
                    return;
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CadastroPage(
                        modelo: widget.modelo,
                        tamanho: tamanhoController.text,
                        cor: cor,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
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

  const CadastroPage({
    super.key,
    required this.modelo,
    required this.tamanho,
    required this.cor,
  });

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final nomeController = TextEditingController();
  final telefoneController = TextEditingController();
  final emailController = TextEditingController();
  final cidadeController = TextEditingController();

  // 🔥 FUNÇÃO AGORA ESTÁ NO LUGAR CERTO
  void enviarWhatsApp() async {
    final msg =
        "Orçamento:%0A%0A"
        "👤 Nome: ${nomeController.text}%0A"
        "📞 Telefone: ${telefoneController.text}%0A"
        "📧 Email: ${emailController.text}%0A"
        "📍 Cidade: ${cidadeController.text}%0A%0A"
        "🔧 Modelo: ${widget.modelo}%0A"
        "📏 Tamanho: ${widget.tamanho}%0A"
        "🎨 Cor: ${widget.cor}";

    final uri =
        Uri.parse("https://wa.me/5511993977881?text=$msg");

    await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Seus dados")),
      bottomNavigationBar: const BotaoErro(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // 🔹 NOME
            TextField(
              controller: nomeController,
              decoration: InputDecoration(
                labelText: "Nome",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // 🔹 TELEFONE
            TextField(
              controller: telefoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Telefone",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // 🔹 EMAIL
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // 🔹 CIDADE
            TextField(
              controller: cidadeController,
              decoration: InputDecoration(
                labelText: "Cidade/Estado",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // 🔥 BOTÃO FINAL CORRIGIDO
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Enviar para WhatsApp"),
              onPressed: () {
                if (nomeController.text.isEmpty ||
                    telefoneController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Preencha nome e telefone"),
                    ),
                  );
                  return;
                }

                enviarWhatsApp(); // 👈 AGORA FUNCIONA
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ================= ERRO =================

class RelatoErroPage extends StatefulWidget {
  const RelatoErroPage({super.key});

  @override
  State<RelatoErroPage> createState() => _RelatoErroPageState();
}

class _RelatoErroPageState extends State<RelatoErroPage> {
  final tituloController = TextEditingController();
  final descricaoController = TextEditingController();

  void enviarErro() async {
    final titulo = tituloController.text.trim();
    final descricao = descricaoController.text.trim();

    if (titulo.isEmpty || descricao.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Preencha título e descrição"),
        ),
      );
      return;
    }

    final msg = Uri.encodeComponent(
      "🐞 *Relato de Erro*\n\n"
      "📌 Título: $titulo\n\n"
      "📝 Descrição: $descricao",
    );

    final uri = Uri.parse("https://wa.me/5511993977881?text=$msg");

    await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Relatar erro")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // 🔹 TÍTULO
            const Text(
              "Título",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: tituloController,
              maxLength: 100,
              decoration: InputDecoration(
                hintText: "Digite o título do erro",
                counterText: "",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 DESCRIÇÃO
            const Text(
              "Descrição do erro",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: descricaoController,
              maxLines: 6,
              maxLength: 5000,
              decoration: InputDecoration(
                hintText: "Descreva o problema...",
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // 🔥 BOTÃO
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: enviarErro,
              child: const Text("Enviar erro para WhatsApp"),
            ),
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////

class BotaoErro extends StatelessWidget {
  const BotaoErro({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(0, 255, 91, 91),
            minimumSize: const Size(double.infinity, 50),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const RelatoErroPage(),
              ),
            );
          },
          icon: const Icon(Icons.bug_report),
          label: const Text("Reportar erro"),
        ),
      ),
    );
  }
}