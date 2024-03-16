import 'package:quick_settings/quick_settings.dart';

class QuickTileService {
  void initQuickTile() {
    QuickSettings.setup(
      onTileClicked: onTileClicked,
      onTileAdded: onTileAdded,
      onTileRemoved: onTileRemoved,
    );

  }

  Tile onTileClicked(Tile tile) {
    final oldStatus = tile.tileStatus;
    if (oldStatus == TileStatus.active) {
      tile.label = "Service OFF";
      tile.tileStatus = TileStatus.inactive;
      tile.subtitle = "tap to turn on";
    } else {
      tile.label = "Service ON";
      tile.tileStatus = TileStatus.active;
      tile.subtitle = "tap to turn on";
    }
    return tile;
  }

  @pragma("vm:entry-point")
  Tile onTileAdded(Tile tile) {
  tile.label = "Service ON";
  tile.tileStatus = TileStatus.active;
  tile.subtitle = "Tap to turn OFF";
  return tile;
}

  @pragma("vm:entry-point")
  void onTileRemoved() {
    print("Tile removed");
  }
}
