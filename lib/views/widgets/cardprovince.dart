part of 'widgets.dart';

class CardProvince extends StatefulWidget {
  final Costs costs;
  const CardProvince(this.costs);

  @override
  State<CardProvince> createState() => _CardProvinceState();
}

class _CardProvinceState extends State<CardProvince> {
  @override
  Widget build(BuildContext context) {
    Costs c = widget.costs;
    return Card(
      color: Colors.white,
      margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0)
      ),//RoundedRectangleBorder
      elevation: 2,
      child: Column(
        children: [
          Text("${c.description} (${c.service})",style: TextStyle(color: Colors.black, fontSize: 16.0),),
          Text("Biaya : ${c.cost?[0].value}",style: TextStyle(color: Colors.grey, fontSize: 14.0),),
          Text("Estimasi sampai : ${c.cost?[0].etd}",style: TextStyle(color: Colors.green, fontSize: 12.0),)
        ],
      ), //ListTile

    ); // Card

  }
  
}
