import 'package:dogs/features/homepage/model/dogModel.dart';
import 'package:dogs/features/homepage/view/provider/dogprovider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<DogModel> dogslist = [];
  List<String> images = [];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<DogProvider>(context, listen: false);
      provider.fetchDogs();
    });
    super.initState();
  }

  searchDogFromList(String letter) {
    String lowerLetter = letter.toLowerCase();

    if (letter.length >= 3) {
      for (int i = 0; i < dogslist.length; i++) {
        String resp = dogslist[i].name.toLowerCase();
        if (resp.contains(lowerLetter)) {
          print(dogslist[i].name);
          if (!images.contains(dogslist[i].url)) {
            images.add(dogslist[i].url);
          } else {
            images.clear();
          }
        }
      }
    } else if (letter.length <= 2) {
      images.clear();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Search Your Favourite DOG"),
        centerTitle: true,
      ),
      body: Padding(
        padding: size < 350
            ? EdgeInsets.all(32.0)
            : EdgeInsets.symmetric(horizontal: 300.0),
        child: Consumer<DogProvider>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return Center(
                  child: Lottie.asset(
                "assets/lottie/animal.json",
                frameRate: FrameRate(120),
                repeat: true,
                height: 150,
              ));
            }
            if (value.isLoading == false) {
              dogslist = value.dogs;
            }
            return Column(
              children: [
                TextField(
                  onChanged: (value) {
                    searchDogFromList(value);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal)),
                    // hintText: 'Tell us about yourself',
                    helperText: 'Enter your dog breed name',
                    labelText: 'labra',
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.green,
                    ),
                  ),
                ),
                Visibility(
                  visible: images.isNotEmpty,
                  child: Expanded(
                      child: Container(
                    width: double.infinity,
                    child: GridView.builder(
                        itemCount: images.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4,
                            crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          if (images.isEmpty) {
                            return Lottie.asset(
                              "assets/lottie/animal.json",
                              frameRate: FrameRate(120),
                              repeat: true,
                              height: 80,
                            );
                          }
                          return Image.network(images[index]);
                        }),
                  )),
                )
              ],
            );
          },
        ),
      ),
    ));
  }
}
