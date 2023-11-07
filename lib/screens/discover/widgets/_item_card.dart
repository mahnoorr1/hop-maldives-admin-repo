part of '../discover.dart';

class _ItemCard extends StatefulWidget {
  final DiscoverItem e;
  final int index;
  const _ItemCard({
    Key? key,
    required this.e,
    required this.index,
  }) : super(key: key);

  @override
  State<_ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<_ItemCard> {
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    final discoverCubit = DiscoverCubit.c(context);

    return Container(
      width: AppDimensions.normalize(120),
      decoration: UIProps.boxCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Container(
                height: AppDimensions.normalize(80),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(UIProps.radius),
                    topRight: Radius.circular(UIProps.radius),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.e.url!,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: AppIconButton(
                  onPressed: () => discoverCubit.delete(widget.index),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              )
            ],
          ),
          Space.y!,
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              initiallyExpanded: expanded,
              onExpansionChanged: (value) {
                setState(() {
                  expanded = value;
                });
              },
              title: Text(
                'Description',
                style: AppText.b1b,
              ),
              subtitle: expanded
                  ? null
                  : Text(
                      widget.e.description!,
                      maxLines: 2,
                    ),
              childrenPadding: Space.all(0.7, 0),
              children: [
                Text(
                  widget.e.description!,
                  style: AppText.l1,
                  textAlign: TextAlign.justify,
                )
              ],
            ),
          ),
          Space.y!
        ],
      ),
    );
  }
}
