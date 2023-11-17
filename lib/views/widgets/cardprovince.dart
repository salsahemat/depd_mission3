part of 'widgets.dart';

class CardProvince extends StatefulWidget {
  final Province prov;
  const CardProvince(this.prov);

  @override
  State<CardProvince> createState() => _CardProvinceState();
}

class _CardProvinceState extends State<CardProvince> {
  @override
  Widget build(BuildContext context) {
    Province p = widget.prov;
    return Card(
      color: Color(0xFFFFFF),
      margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0)
      ),//RoundedRectangleBorder
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
        title: Text("${p.province}"),

      ), //ListTile

    ); // Card

  }
  
}
