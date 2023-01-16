import 'package:flutter/material.dart';

class ScanResult extends StatefulWidget {
  final List<String> ingredientList;

  const ScanResult(this.ingredientList, {Key? key}) : super(key: key);

  @override
  State<ScanResult> createState() => _ScanResultState();
}

class _ScanResultState extends State<ScanResult> {
  bool showInfo = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint(widget.ingredientList.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Search Ingredients",
            style: Theme.of(context).textTheme.headline6,),
          actions: [
            IconButton(
              onPressed: (){
                showDialog(
                  context: context,
                  builder: (context){
                    return AlertDialog(
                      title: Text("Info",
                      style: Theme.of(context).textTheme.headlineSmall,),
                      content: Text("Start by searching for an ingredient. If the ingredient exists it will show up in the search result. Otherwise it won't show up",
                      style: Theme.of(context).textTheme.bodyMedium,),
                      actions: [
                        TextButton(
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                          child: Text("Ok",
                            style: Theme.of(context).textTheme.button,),
                        ),
                      ],
                    );
                  }
                );
              },
              icon: const Icon(Icons.info),
              tooltip: 'Info',
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: RawAutocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                return widget.ingredientList.where((String option) {
                  return option.contains(textEditingValue.text.toLowerCase());
                });
              },
              fieldViewBuilder: (BuildContext context,
                  TextEditingController textEditingController,
                  FocusNode focusNode,
                  VoidCallback onFieldSubmitted) {
                return TextFormField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  autofocus: true,
                  autocorrect: true,
                  onFieldSubmitted: (String value) {
                    onFieldSubmitted();
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Search Ingredients',
                  ),
                );
              },
              optionsViewBuilder: (BuildContext context,
                  AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    elevation: 4.0,
                    child: SizedBox(
                      height: 200.0,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8.0),
                        itemCount: options.length,
                        itemBuilder: (BuildContext context, int index) {
                          final String option = options.elementAt(index);
                          return GestureDetector(
                            onTap: () {
                              // onSelected(option);
                              showDialog(
                                context: context,
                                builder: (context){
                                  return AlertDialog(
                                    title: Text("Match Found",
                                    style: Theme.of(context).textTheme.headline6,),
                                    content: RichText(
                                      text: TextSpan(
                                        text: 'The following ',
                                        style: DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(text: option,
                                              style: Theme.of(context).
                                              textTheme.bodyMedium!
                                                  .copyWith(
                                                  fontWeight: FontWeight.bold),),
                                          const TextSpan(text: ' is present in the ingredient list'),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: (){
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Ok",
                                          style: Theme.of(context).textTheme.button,),
                                      ),
                                    ],
                                  );
                                }
                              );
                            },
                            child: ListTile(
                              title: Text(option),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
