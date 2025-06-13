import 'package:bag_finder/core/enums/bag_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import '../entity/bag_entity.dart';
import '../provider/traveler_provider.dart';
import '../utils/app_colors.dart';
import '../utils/app_dimensions.dart';
import 'dialogs/bag_confirmation_dialog.dart';
import 'dialogs/edit_bag_description_dialog.dart';

class BagItemWidget extends StatefulWidget {
  final BagEntity bag;

  const BagItemWidget({
    super.key,
    required this.bag,
  });

  @override
  State<BagItemWidget> createState() => _BagItemWidgetState();
}

class _BagItemWidgetState extends State<BagItemWidget> {
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    final provider = Modular.get<TravelerProvider>();

    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          12,
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.2,
            ),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(
              0,
              4,
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(AppDimensions.paddingSmall),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(
                  12,
                ),
                topRight: Radius.circular(
                  12,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(
                      Icons.luggage,
                      color: Colors.white,
                    ),
                    Positioned(
                      right: 1,
                      top: 1,
                      child: Icon(
                        Icons.label_important_outline_rounded,
                        size: 12,
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      widget.bag.id,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppDimensions.paddingLarge,
              horizontal: AppDimensions.paddingMedium,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow(
                        'Status:',
                        widget.bag.status.toLiteral(),
                        context,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      _buildInfoRow(
                        'Descrição:',
                        widget.bag.description ??
                            'Nenhuma descrição encontrada!',
                        context,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      _buildInfoRow(
                        'Última alteração:',
                        widget.bag.updatedAt != null
                            ? DateFormat('HH:mm').format(
                                widget.bag.updatedAt!.toLocal(),
                              )
                            : 'Nenhuma alteração encontrada!',
                        context,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      widget.bag.status != BagStatusEnum.CLAIMED
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 8,
                                  ),
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          12,
                                        ),
                                      ),
                                      elevation: 8,
                                    ),
                                    onPressed: () async {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return EditBagDescriptionDialog(
                                            bag: widget.bag,
                                            onEditConfirmation: (text) async {
                                              await provider.updateBag(
                                                bag: widget.bag.copyWith(
                                                  description: text,
                                                ),
                                              );

                                              Modular.to.pop();
                                            },
                                            onNotArrived: () {
                                              Modular.to.pop();
                                            },
                                          );
                                        },
                                      );

                                      setState(() {
                                        _isProcessing = false;
                                      });
                                    },
                                    child: _isProcessing
                                        ? Text(
                                            'Processando...',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                  color: AppColors.secondary,
                                                ),
                                          )
                                        : const Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.edit,
                                                color: Colors.white,
                                                size: AppDimensions.iconSmall,
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                'Editar',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                      AppDimensions.fontSmall,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: _isProcessing
                                      ? null
                                      : () async {
                                          if (widget.bag.status ==
                                              BagStatusEnum.ARRIVED) {
                                            setState(() {
                                              _isProcessing = true;
                                            });

                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return BagConfirmationDialog(
                                                  bag: widget.bag,
                                                  onConfirmArrival: () async {
                                                    await provider.updateBag(
                                                      bag: widget.bag.copyWith(
                                                        status: BagStatusEnum
                                                            .CLAIMED,
                                                      ),
                                                    );

                                                    Modular.to.pop();
                                                  },
                                                  onNotArrived: () {
                                                    Modular.to.pop();
                                                  },
                                                );
                                              },
                                            );

                                            setState(() {
                                              _isProcessing = false;
                                            });
                                          }
                                        },
                                  style: TextButton.styleFrom(
                                    backgroundColor: widget.bag.status ==
                                            BagStatusEnum.ARRIVED
                                        ? AppColors.primary
                                        : AppColors.secondaryGrey,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        12,
                                      ),
                                    ),
                                    elevation: 8,
                                  ),
                                  child: _isProcessing
                                      ? Text(
                                          'Processando...',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                color: AppColors.secondary,
                                              ),
                                        )
                                      : const Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: AppDimensions.iconSmall,
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              'Confirmar',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    AppDimensions.fontSmall,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                              ],
                            )
                          : Container(
                              padding: const EdgeInsets.all(
                                4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(
                                  12,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'Entrega',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.secondary,
                                        ),
                                  ),
                                  Text(
                                    'Confirmada',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.secondary,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label ',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryGrey,
              ),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppColors.secondaryGrey,
                ),
          ),
        ),
      ],
    );
  }
}
