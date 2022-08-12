import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget implements PreferredSizeWidget {
  var idx;
  SearchBarWidget({index}) {
    //constructor, ciri2 sama dengan nama class/widgetnya. Bukan fungsi biasa
    idx = index;
  }

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50);
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  bool isSearching = false;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: isSearching
          ? ListTile(
              leading: const Icon(Icons.search, color: Colors.white),
              title: TextFormField(
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                //aktif setelah input value dan submit
                onFieldSubmitted: (value) {
                  //simpan isi textformfield di arguments untuk dikirim ke halaman "page_result"
                  Navigator.pushNamed(context, "page_result", arguments: value);
                },
                decoration: InputDecoration(
                    hintText: widget.idx == 0
                        ? "Search popular movie..."
                        : widget.idx == 1
                            ? "Search top rated movie..."
                            : "Search now playing movie..."),
              ))
          : const Text("Movie List"),
      centerTitle: true,
      actions: [
        InkWell(
            onTap: () {
              if (isSearching) {
                isSearching = false;
              } else {
                isSearching = true;
              }
              print(widget.idx);
              setState(() {});
            },
            child: Icon(isSearching ? Icons.cancel : Icons.search)),
      ],
    );
  }
}
