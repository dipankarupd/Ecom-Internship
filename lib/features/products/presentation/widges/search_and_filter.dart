import 'package:flutter/material.dart';
import 'package:ushopie_ecom/features/products/presentation/pages/catgory_page.dart';
import 'search_bar.dart';

const List<String> sortList = ["All", "Price Ascending", "Price Descending"];

const List<String> filterList = ["All", "Groceries", "Clothes"];

class SearchAndFilter extends StatefulWidget {
  final ValueChanged<SortOption> onSortOptionChanged;
  final ValueChanged<FilterOption> onFilterOptionChanged;
  final ValueChanged<String> onSearchQueryChanged;

  const SearchAndFilter({
    Key? key, 
    required this.onSortOptionChanged, 
    required this.onFilterOptionChanged,
    required this.onSearchQueryChanged
  })
      : super(key: key);

  @override
  State<SearchAndFilter> createState() => _SearchAndFilterState();
}

class _SearchAndFilterState extends State<SearchAndFilter> {
  String dropdownValue = sortList.first;
  String filterValue = filterList.first;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         GoodsSearchBar(
          searchController: searchController,
          onSearchQueryChanged: widget.onSearchQueryChanged
        ),
        const SizedBox(height: 11),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.sort),
                const SizedBox(width: 5),
                DropdownButton<String>(
                  items: sortList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  onChanged: (String? val) {
                    setState(() {
                      dropdownValue = val!;
                      SortOption selectedOption;
                      if (val == "Price Ascending") {
                        selectedOption = SortOption.priceAscending;
                      } else if (val == "Price Descending") {
                        selectedOption = SortOption.priceDescending;
                      } else {
                        selectedOption = SortOption.all;
                      }
                      widget.onSortOptionChanged(selectedOption);
                    });
                  },
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.filter_alt_outlined),
                SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButton<String>(
                      items: filterList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: filterValue,
                      icon: const Icon(Icons.arrow_downward),
                      onChanged: (String? val) {
                        setState(() {
                          filterValue = val!;
                          FilterOption selectedOption;
                          if (val == "Groceries") {
                            selectedOption = FilterOption.groceries;
                          } else if (val == "Clothes") {
                            selectedOption = FilterOption.clothes;
                          } else {
                            selectedOption = FilterOption.all;
                          }
                          widget.onFilterOptionChanged(selectedOption);
                        });
                      },
                    )
                  ],
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 23),
      ],
    );
  }
}
