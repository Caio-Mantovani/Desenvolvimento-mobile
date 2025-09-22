import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'servicocelular.dart';
import 'servicocomputador.dart';
import 'cart_model.dart';
import 'carrinho.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final List<Map<String, dynamic>> produtos = const [
    {
      "nome": "Suporte para Celular Bike",
      "preco": "R\$45,40 à vista",
      "imagem": "assets/images/1.webp"
    },
    {
      "nome": "Suporte Notebook Dobrável",
      "preco": "R\$12,96 à vista",
      "imagem": "assets/images/2.jpg"
    },
    {
      "nome": "Mouse Gamer USB LED",
      "preco": "R\$49,40 à vista",
      "imagem": "assets/images/3.jpg"
    },
    {
      "nome": "Kit Teclado + Mouse USB",
      "preco": "R\$20,05 à vista",
      "imagem": "assets/images/4.webp"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          Consumer<CartModel>(
            builder: (context, cart, child) {
              return Stack(
                alignment: Alignment.topRight,
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CarrinhoPage(),
                        ),
                      );
                    },
                  ),
                  if (cart.totalItems > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          "${cart.totalItems}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ServicoComputadorPage()),
                  );
                },
                child: Column(
                  children: const [
                    Icon(Icons.computer, size: 40),
                    SizedBox(height: 5),
                    Text("Serviços\nComputadores", textAlign: TextAlign.center),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ServicoCelularPage()),
                  );
                },
                child: Column(
                  children: const [
                    Icon(Icons.phone_android, size: 40),
                    SizedBox(height: 5),
                    Text("Serviços\nSmartphones", textAlign: TextAlign.center),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                itemCount: produtos.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  final produto = produtos[index];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(produto["imagem"]),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            produto["nome"],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            produto["preco"],
                            style: const TextStyle(color: Colors.red),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Provider.of<CartModel>(context, listen: false)
                                  .addItem({"nome": produto["nome"]});
                            },
                            child: const Text("Adicionar"),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}