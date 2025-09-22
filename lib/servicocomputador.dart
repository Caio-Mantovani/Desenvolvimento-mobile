import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_model.dart';
import 'carrinho.dart';

class ServicoComputadorPage extends StatelessWidget {
  const ServicoComputadorPage({super.key});

  final List<Map<String, dynamic>> servicos = const [
    {"nome": "Formatação Completa", "preco": "R\$ 80,00"},
    {"nome": "Formatação sem backup", "preco": "R\$ 60,00"},
    {"nome": "Limpeza", "preco": "R\$ 100,00"},
    {"nome": "Limpeza Completa", "preco": "R\$ 150,00"},
    {"nome": "Montagem de PC", "preco": "R\$ 200,00"},
    {"nome": "Upgrade", "preco": "R\$ 40,00 por peça"},
    {"nome": "Diagnóstico de desempenho", "preco": "R\$ 50,00"},
    {"nome": "Instalação de programas", "preco": "R\$ 25,00 cada"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Computadores",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Consumer<CartModel>(
            builder: (context, cart, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart, color: Colors.black),
                    onPressed: () {
                      // Navega para a página do carrinho
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
                        padding: const EdgeInsets.all(4),
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
          const SizedBox(height: 20),
          const Icon(Icons.computer, size: 120, color: Colors.black),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.separated(
              itemCount: servicos.length,
              itemBuilder: (context, index) {
                final servico = servicos[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline, color: Colors.black),
                        onPressed: () {
                          // Adiciona o item ao carrinho usando o Provider
                          Provider.of<CartModel>(context, listen: false).addItem(servico);
                        },
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              servico["nome"],
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              servico["preco"],
                              style: const TextStyle(fontSize: 16, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  height: 1,
                  color: Colors.grey[300],
                  indent: 60,
                  endIndent: 20,
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          const Icon(Icons.build, size: 40, color: Colors.black),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}