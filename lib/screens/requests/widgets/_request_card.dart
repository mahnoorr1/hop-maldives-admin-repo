part of '../requests.dart';

class _RequestCard extends StatefulWidget {
  final Request e;
  final int index;
  const _RequestCard({
    Key? key,
    required this.e,
    required this.index,
  }) : super(key: key);

  @override
  State<_RequestCard> createState() => _RequestCardState();
}

class _RequestCardState extends State<_RequestCard> {
  final _requestState = GlobalKey<FormBuilderState>();

  bool isApprove = false;

  @override
  void initState() {
    super.initState();
    isApprove = widget.e.status;
  }

  @override
  Widget build(BuildContext context) {
    final requestCubit = RequestsCubit.c(context);
    dynamic property = widget.e.hotel ??
        widget.e.resort ??
        widget.e.tour ??
        widget.e.diving ??
        widget.e.excursion;

    return Container(
      padding: Space.all(),
      width: AppDimensions.normalize(140),
      decoration: UIProps.boxCard,
      child: FormBuilder(
        key: _requestState,
        initialValue: {
          'status': isApprove,
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Request ID',
                      style: AppText.l2b!.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      widget.e.id,
                      style: AppText.l1b,
                    )
                  ],
                ),
                Container(
                  padding: Space.all(0.5, 0.25),
                  decoration: BoxDecoration(
                    color: widget.e.status ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(
                      360,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.e.status ? 'Accepted' : 'Rejected',
                      style: AppText.l2!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Divider(
              height: AppDimensions.normalize(10),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Guest Name',
                      style: AppText.l2b!.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      widget.e.fullName,
                      style: AppText.l1b,
                    ),
                    Space.yf(0.25),
                    Text(
                      'Guest Email',
                      style: AppText.l2b!.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      widget.e.email,
                      style: AppText.l1b,
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'User ID',
                      style: AppText.l2b!.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      '${widget.e.userId.substring(0, 8)}...',
                      style: AppText.l1b,
                    )
                  ],
                ),
              ],
            ),
            Divider(
              height: AppDimensions.normalize(10),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Booking details',
                  style: AppText.l2b!.copyWith(
                    color: Colors.grey,
                  ),
                ),
                Text(
                  property.name,
                  style: AppText.l1b,
                ),
                Space.y!,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.e.isTourBooking == null &&
                            widget.e.isDivingBooking == null &&
                            widget.e.isExcBooking == null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Check in',
                                style: AppText.l2b!.copyWith(
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                DateFormat('dd MMM, yyyy')
                                    .format(widget.e.checkin!),
                                style: AppText.l1b,
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Deadline',
                                style: AppText.l2b!.copyWith(
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                DateFormat('dd MMM, yyyy')
                                    .format(widget.e.checkout!),
                                style: AppText.l1b,
                              ),
                            ],
                          ),
                    if (widget.e.isTourBooking == null ||
                        widget.e.isTourBooking! == false)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Check out',
                            style: AppText.l2b!.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            DateFormat('dd MMM, yyyy')
                                .format(widget.e.checkout!),
                            style: AppText.l1b,
                          ),
                        ],
                      ),
                  ],
                )
              ],
            ),
            Divider(
              height: AppDimensions.normalize(10),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment details',
                  style: AppText.l2b!.copyWith(
                    color: Colors.grey,
                  ),
                ),
                Space.y!,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Price',
                      style: AppText.b2b,
                    ),
                    Text(
                      App.format(widget.e.price),
                      style: AppText.b2b!.copyWith(
                        color: AppTheme.c!.primary,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Divider(
              height: AppDimensions.normalize(10),
            ),
            FormBuilderCheckbox(
              name: 'status',
              onChanged: (value) {
                setState(() {
                  isApprove = value!;
                });
              },
              title: Text(
                'Approve Request',
                style: AppText.l1b,
              ),
            ),
            Space.y!,
            AppButton(
              child: Text(
                'Send Update',
                style: AppText.l1b!.copyWith(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                widget.e.status = isApprove;
                requestCubit.updateRequest(
                  widget.e,
                  widget.index,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
