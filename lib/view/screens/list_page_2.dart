import 'package:currency/provider/bookmark_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helper/api.helper.dart';
import '../../modal/currency_modal.dart';
import '../../provider/theme_changer_provider.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final PageController _controller = PageController();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15, top: 5, bottom: 2, right: 5),
                    child: GestureDetector(
                      onTap: (){
                        String SearchedCurrency = searchController.text;
                        setState(() {
                        });
                      },
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        // controller: searchController,
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(
                            // borderSide: BorderSide(
                            //     color: (Provider.of<ThemeControler>(context,
                            //         listen: true)
                            //         .t
                            //         .isDark)
                            //         ? Colors.deepPurpleAccent
                            //         : Colors.amberAccent,
                            //     width: 12.0),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 1, top: 5, bottom: 2, right: 10),
                  child: Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          // getData = APIHelper.apiHelper
                          //     .fechPhotos(z: searchController.text);
                        });
                      },
                      child: const Icon(
                        Icons.search,
                        size: 40,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 7,
            child: ListView.builder(
              itemCount: APIHelper.list.length,
              itemBuilder: (BuildContext context, int index) {
                List<AllCurrency> data = APIHelper.list;
                return Padding(
                  padding: EdgeInsets.only(bottom: 3,left: 10,right: 10),
                  child: Card(
                   color: (Provider.of<ThemeController>(context,
                        listen: true)
                        .t
                        .isDark)
                        ? Colors.deepOrangeAccent
                        : Colors.greenAccent,
                    child: ListTile(
                      subtitle: Text("${data[index].value}"),
                      title: Text(data[index].code),
                      trailing: GestureDetector(
                        onTap: () {
                          if (Provider.of<BookMarkProvider>(context,
                                  listen: false)
                              .bookmark
                              .data
                              .contains(data[index])) {
                            Provider.of<BookMarkProvider>(context, listen: false)
                                .remove(allCurrency: data[index]);
                          } else {
                            Provider.of<BookMarkProvider>(context, listen: false)
                                .add(allCurrency: data[index]);
                          }
                        },
                        child: (Provider.of<BookMarkProvider>(context)
                                .bookmark
                                .data
                                .contains(data[index]))
                            ? const Icon(Icons.star,color: Colors.amber,size: 25,)
                            : Icon(Icons.star_border,size: 25,),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
