import 'Pages/HOME/laptopHomeScreen.dart';
import 'Pages/HOME/mobileHomeScreen.dart';
import 'Pages/HOME/tabletHomeScreen.dart';
import 'Responsive_Layout/responsive_layout.dart';
//all page variables

final home = ResponsiveLayout(
    mobileScaffold: MobileHomeScreen(),
    tabletScaffold: TabletHomeScreen(),
    laptopScaffold: LaptopHomeScreen());

final search = ResponsiveLayout(
    mobileScaffold: MobileHomeScreen(
      pos: 'search',
    ),
    tabletScaffold: TabletHomeScreen(
      pos: 'search',
    ),
    laptopScaffold: LaptopHomeScreen(
      pos: 'search',
    ));

final addVendor = ResponsiveLayout(
    mobileScaffold: MobileHomeScreen(
      pos: 'vendorForm',
    ),
    tabletScaffold: TabletHomeScreen(
      pos: 'vendorForm',
    ),
    laptopScaffold: LaptopHomeScreen(
      pos: 'vendorForm',
    ));

final editVendor = ResponsiveLayout(
    mobileScaffold: MobileHomeScreen(
      pos: 'editVendor',
    ),
    tabletScaffold: TabletHomeScreen(
      pos: 'editVendor',
    ),
    laptopScaffold: LaptopHomeScreen(
      pos: 'editVendor',
    ));

final addCamp = ResponsiveLayout(
    mobileScaffold: MobileHomeScreen(
      pos: 'addCamp',
    ),
    tabletScaffold: TabletHomeScreen(
      pos: 'addCamp',
    ),
    laptopScaffold: LaptopHomeScreen(
      pos: 'addCamp',
    ));

final editCamp = ResponsiveLayout(
    mobileScaffold: MobileHomeScreen(
      pos: 'editCamp',
    ),
    tabletScaffold: TabletHomeScreen(
      pos: 'editCamp',
    ),
    laptopScaffold: LaptopHomeScreen(
      pos: 'editCamp',
    ));

final report = ResponsiveLayout(
    mobileScaffold: MobileHomeScreen(
      pos: 'report',
    ),
    tabletScaffold: TabletHomeScreen(
      pos: 'report',
    ),
    laptopScaffold: LaptopHomeScreen(
      pos: 'report',
    ));
