import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/material.dart';

class StickerQuery extends StatefulWidget {
  @override
  _StickerQueryState createState() => _StickerQueryState();
}

const GET_STICKERS = ''' 
    query SearchStickerSample {
      sticker {
        searchStickers(
          req:{
            searchStickersParams:{searchText: "cry", numberResults: 2},
            stickerUserContext:{countryCode: US, localTimeZoneUTCOffsetMinutes: 2,locale: EN_US}
          }){
          stickerResults {
            items {
              itemType
              id
              pngURL
              thumbnailURL
            }
          }
        }
      }
    }
  ''';

class _StickerQueryState extends State<StickerQuery> {
  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql(GET_STICKERS),
      ),
      builder: (
        QueryResult result, {
        VoidCallback refetch,
        FetchMore fetchMore,
      }) {
        if (result.hasException) {
          return Text(result.exception.toString());
        }

        if (result.isLoading) {
          return Text('Loading');
        }

        List repositories =
            result.data['sticker']['searchStickers']['stickerResults']['items'];
        print(repositories.toString());
        return Text("suceess");
      },
    );
  }
}
