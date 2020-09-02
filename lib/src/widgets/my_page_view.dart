import 'package:flutter/material.dart';

class MyPageView extends StatefulWidget {
  final int currentPage;
  final List<Widget> children;

  const MyPageView(
      {Key key, @required this.currentPage, @required this.children})
      : assert(currentPage != null && currentPage >= 0),
        assert(children != null && children.length >= 0),
        super(key: key);

  @override
  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  List<int> _renderedTabs = [0];

  @override
  void didUpdateWidget(MyPageView oldWidget) {
    if (!_renderedTabs.contains(widget.currentPage)) 
      setState(() => _renderedTabs.add(widget.currentPage));
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      children: List.generate(widget.children.length, (index) {
        return _renderedTabs.contains(index)
            ? widget.children[index]
            : Container();
      }),
      index: widget.currentPage,
    );
  }
}
