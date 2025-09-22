import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_model.dart';
import 'carrinho.dart';

class ServicoCelularPage extends StatefulWidget {
  const ServicoCelularPage({super.key});

  @override
  State<ServicoCelularPage> createState() => _ServicoCelularPageState();
}

class _ServicoCelularPageState extends State<ServicoCelularPage> {
  final TextEditingController marcaController = TextEditingController();
  final TextEditingController modeloController = TextEditingController();
  final TextEditingController problemaController = TextEditingController();

  @override
  void dispose() {
    marcaController.dispose();
    modeloController.dispose();
    problemaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Celulares"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.phone_android, size: 100, color: Colors.black),
            const SizedBox(height: 20),
            TextField(
              controller: marcaController,
              decoration: const InputDecoration(labelText: "Marca"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: modeloController,
              decoration: const InputDecoration(labelText: "Modelo"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: problemaController,
              decoration: const InputDecoration(labelText: "Descreva o problema"),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 5,
              ),
              onPressed: () {
                Provider.of<CartModel>(context, listen: false)
                    .addItem({"nome": "Orçamento Celular"});
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Solicitação adicionada ao carrinho!"),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Text(
                "Solicitar orçamento",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}