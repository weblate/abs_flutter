import 'package:abs_flutter/features/library/item_components/item_series.dart';
import 'package:abs_flutter/features/library/item_components/library_item_widget.dart';
import 'package:abs_flutter/features/library/notch/notch_content.dart';
import 'package:abs_flutter/generated/l10n.dart';
import 'package:abs_flutter/models/library_series_preview.dart';
import 'package:abs_flutter/provider/library_items_provider.dart';
import 'package:abs_flutter/provider/settings_provider.dart';
import 'package:abs_flutter/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SingleSeriesView extends ConsumerStatefulWidget {
  const SingleSeriesView({super.key, this.seriesName, this.seriesId});

  final String? seriesName;
  final String? seriesId;

  @override
  _SingleSeriesViewState createState() => _SingleSeriesViewState();
}

class _SingleSeriesViewState extends ConsumerState<SingleSeriesView> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;
  // TODO: Find a better way to check if the list has more items
  bool _hasMore = true;

  @override
  void initState() {
    // Ensure the widget is initalized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.seriesId != null) {
        if (ref.read(libraryItemSearchProvider).filter != widget.seriesId) {
          ref.read(libraryItemSearchProvider.notifier).state = ref
              .read(libraryItemSearchProvider)
              .copyWith(
                  filter: '${widget.seriesId}',
                  filterKey: 'series',
                  sort: 'sequence',
                  desc: (ref.read(settingsProvider)[Constants.SORT_SERIES_ASC])
                      ? 1
                      : 0,
                  previous: [
                ref.read(libraryItemSearchProvider).copyWith(previous: null),
                ...?ref.read(libraryItemSearchProvider).previous
              ]);
        }
        print(ref.read(libraryItemSearchProvider));
      }
    });

    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isLoadingMore &&
        _hasMore) {
      _loadMoreData();
    }
  }

  Future<void> _loadMoreData() async {
    if (!_isLoadingMore && _hasMore) {
      setState(() {
        _isLoadingMore = true;
      });

      final libraryItems = ref.read(libraryItemsProvider);
      if (libraryItems != null) {
        await ref
            .read(libraryItemsProvider.notifier)
            .loadMoreData(libraryItems.page + 1);

        if (libraryItems.total <= libraryItems.items.length) {
          _hasMore = false;
        }
      }

      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final series = ref.watch(libraryItemsProvider);

    ref.listen(libraryItemSearchProvider, (old, newVal) {
      _hasMore = true;
    });

    if (series == null) return const Center(child: CircularProgressIndicator());
    if (series.filterBy == null ||
        series.filterBy!.isEmpty ||
        !series.filterBy!.contains('series.')) {
      return PlatformScaffold(
          appBar: PlatformAppBar(
            title: PlatformText(
                widget.seriesName ?? series.items.first.seriesName ?? ''),
          ),
          body: Center(child: PlatformText(S.of(context).noSeriesSelected)));
    }

    LibrarySeriesPreview seriesPreview = LibrarySeriesPreview(
        books: series.items,
        total: series.total,
        page: series.page,
        id: series.filterBy!.split('.').last,
        libraryId: '',
        name: widget.seriesName ?? series.items.first.seriesName ?? '');

    const double screenWidth = 800;

    return PlatformScaffold(
      appBar: PlatformAppBar(
          title: PlatformText(seriesPreview.name),
          leading: PlatformIconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Reset filter on back
              ref.read(libraryItemSearchProvider.notifier).state = ref
                  .read(libraryItemSearchProvider)
                  .previous!
                  .first
                  .copyWith(
                      previous: ref
                          .read(libraryItemSearchProvider)
                          .previous
                          ?.sublist(1));
              Navigator.pop(context);
            },
          )),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              constraints: const BoxConstraints(maxWidth: screenWidth),
              child: Column(
                children: [
                  Container(
                      constraints: const BoxConstraints(maxWidth: 300),
                      child:
                          ItemSeries(series: seriesPreview, clickable: false)),
                  const Divider(),
                  const NotchContent(
                    disableFilter: true,
                    disableSearch: true,
                  ),
                  LayoutBuilder(builder: (context, constraints) {
                    return AlignedGridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: constraints.maxWidth ~/ 180,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      padding:
                          const EdgeInsets.only(top: 16, left: 8, right: 8),
                      itemCount: seriesPreview.books.length,
                      itemBuilder: (context, index) {
                        return LibraryItemWidget(
                            item: seriesPreview.books[index]);
                      },
                    );
                  }),
                  if (_isLoadingMore)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
