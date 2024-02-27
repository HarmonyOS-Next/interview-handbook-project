import { ProfileEditComp } from '@itcast/mine';

@Entry
@Component
struct ProfileEditPage {
  @StorageProp('bottomHeight')
  bottomHeight: number = 0

  build() {
    Column() {
      ProfileEditComp()
    }
    .margin({ bottom: this.bottomHeight })
  }
}