import { SearchComp } from '@itcast/home';

@Entry
@Component
struct SearchPage {
  build() {
    Column() {
      SearchComp()
    }
  }
}