import 'package:emergingtech_gasal2425_louis/class/recipe.dart';
import 'package:flutter/material.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AddRecipeState();
  }
}

class _AddRecipeState extends State<AddRecipe> {
  // Controllers
  final TextEditingController _recipeNameController = TextEditingController();
  final TextEditingController _recipeDescController = TextEditingController();
  final TextEditingController _recipePhotoController = TextEditingController();

  int _charleft = 0;
  String _recipeCategory = "Indonesian"; // pindah ke sini ✅

  @override
  void initState() {
    super.initState();
    _recipeNameController.text = "your food name";
    _recipeDescController.text = "Recipe of ..";
    _charleft = 200 - _recipeDescController.text.length;
  }

  @override
  void dispose() {
    _recipeNameController.dispose();
    _recipeDescController.dispose();
    _recipePhotoController.dispose();
    super.dispose();
  }

  // fungsi buat handle warna tombol
  Color getButtonColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return Colors.red;
    } else {
      return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Recipe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // biar aman kalau layar kecil
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _recipeNameController,
                decoration: const InputDecoration(
                  labelText: "Recipe Name",
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _recipeDescController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 4,
                decoration: const InputDecoration(
                  labelText: "Recipe Description",
                ),
                onChanged: (v) {
                  setState(() {
                    _charleft = 200 - v.length;
                  });
                },
              ),
              Text("$_charleft characters left"),
              const SizedBox(height: 20),
              TextField(
                controller: _recipePhotoController,
                decoration: const InputDecoration(
                  labelText: "Recipe Photo URL",
                ),
                onChanged: (v) {   // ✅ ganti onSubmitted ke onChanged
                  setState(() {}); 
                },
              ),
              const SizedBox(height: 10),
              if (_recipePhotoController.text.isNotEmpty)
                Image.network(
                  _recipePhotoController.text,
                  height: 150,
                  errorBuilder: (context, error, stackTrace) =>
                      const Text("Invalid image URL"),
                ),
              const SizedBox(height: 20),
              DropdownButton<String>(
                items: const [
                  DropdownMenuItem(
                    value: "Indonesian",
                    child: Text("Indonesian"),
                  ),
                  DropdownMenuItem(
                    value: "Japanese",
                    child: Text("Japanese"),
                  ),
                  DropdownMenuItem(
                    value: "Korean",
                    child: Text("Korean"),
                  ),
                ],
                value: _recipeCategory,
                onChanged: (value) {
                  setState(() {
                    _recipeCategory = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  elevation: const MaterialStatePropertyAll(5),
                  backgroundColor:
                      MaterialStateProperty.resolveWith(getButtonColor),
                ),
                onPressed: () {
                  recipes.add(Recipe(
                    id: recipes.length + 1,
                    name: _recipeNameController.text,
                    desc: _recipeDescController.text,
                    photo: _recipePhotoController.text,
                    // category bisa ikut dimasukkan juga kalau Recipe punya field
                  ));
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Add Recipe'),
                      content: const Text('Recipe successfully added'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('SUBMIT'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
