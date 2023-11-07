part of '../reviews_ratings.dart';

class _ReviewCard extends StatefulWidget {
  final Hotel? hotel;
  final Island? island;
  final Resort? resort;
  final Diving? diving;
  final Excursion? excursion;

  const _ReviewCard({
    Key? key,
    this.hotel,
    this.island,
    this.resort,
    this.diving,
    this.excursion,
  }) : super(key: key);

  @override
  State<_ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<_ReviewCard> {
  @override
  Widget build(BuildContext context) {
    String id = widget.hotel != null
        ? widget.hotel!.id
        : widget.island != null
            ? widget.island!.id
            : widget.diving != null
                ? widget.diving!.id
                : widget.excursion != null
                    ? widget.excursion!.id
                    : widget.resort!.id;

    String img = widget.hotel != null
        ? widget.hotel!.images.first
        : widget.island != null
            ? widget.island!.images.first
            : widget.diving != null
                ? widget.diving!.images.first
                : widget.excursion != null
                    ? widget.excursion!.images.first
                    : widget.resort!.images.first;

    String name = widget.hotel != null
        ? widget.hotel!.name
        : widget.island != null
            ? widget.island!.name
            : widget.diving != null
                ? widget.diving!.name
                : widget.excursion != null
                    ? widget.excursion!.name
                    : widget.resort!.name;

    List<Review> reviews = widget.hotel != null
        ? widget.hotel!.reviews
        : widget.island != null
            ? widget.island!.reviews
            : widget.diving != null
                ? widget.diving!.reviews
                : widget.excursion != null
                    ? widget.excursion!.reviews
                    : widget.resort!.reviews;

    return SizedBox(
      width: AppDimensions.normalize(180),
      child: ExpansionTile(
        childrenPadding: Space.vf(0.25),
        leading: Container(
          width: AppDimensions.normalize(30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(UIProps.radius),
            image: DecorationImage(
              image: NetworkImage(
                img,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          name,
          style: AppText.b2b,
        ),
        subtitle: Row(
          children: [
            Text(
              reviews.isEmpty
                  ? '0.0'
                  : AppUtils.ratings(reviews).toStringAsFixed(1),
              style: AppText.b2,
            ),
            Space.x!,
            Icon(
              Icons.star,
              color: AppTheme.c!.primary,
            )
          ],
        ),
        children: [
          BlocBuilder<ReviewCubit, ReviewState>(
            builder: (context, state) {
              if (state is ReviewUpdateLoading) {
                return const LinearProgressIndicator();
              }
              return const SizedBox();
            },
          ),
          ...reviews.asMap().entries.map(
                (e) => Card(
                  child: ListTile(
                    title: Row(
                      children: [
                        Text(
                          e.value.ratings.toStringAsFixed(1),
                          style: AppText.l1,
                        ),
                        Space.xf(0.25),
                        RatingBar(
                          initialRating: e.value.ratings,
                          allowHalfRating: true,
                          itemSize: AppDimensions.normalize(8),
                          ratingWidget: RatingWidget(
                            empty: const Icon(
                              Icons.star,
                              color: Colors.grey,
                            ),
                            full: Icon(
                              Icons.star,
                              color: AppTheme.c!.primary,
                            ),
                            half: Icon(
                              Icons.star_half,
                              color: AppTheme.c!.primary,
                            ),
                          ),
                          onRatingUpdate: (r) {},
                        ),
                      ],
                    ),
                    subtitle: Text(e.value.review),
                    trailing: Switch(
                      value: e.value.enabled,
                      onChanged: (v) {
                        setState(() {
                          e.value.enabled = v;
                        });

                        ReviewCubit.cubit(context).update(
                          id,
                          e.value,
                          e.key,
                          isHotel: widget.hotel != null,
                          isIsland: widget.island != null,
                          isResort: widget.resort != null,
                        );
                      },
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
