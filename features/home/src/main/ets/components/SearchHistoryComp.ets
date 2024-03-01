import { historyStore } from '../utils/history'

interface BtnItem {
  text: string
  onClick?: () => void
}


@Component
export struct SearchHistoryComp {
  @State
  isDeleting: boolean = false
  onSearch: (val: string) => void = () => {
  }
  @State
  keywords: string[] = []

  aboutToAppear(): void {
    this.keywords = historyStore.getAll()
  }

  build() {
    // 搜索历史
    Flex({ direction: FlexDirection.Row, wrap: FlexWrap.Wrap }) {
      Row() {
        Text('搜索记录')
          .fontColor($r('app.color.common_gray_03'))
        Blank()
        if (this.isDeleting) {
          Text() {
            Span('全部删除')
              .onClick(() => {
                historyStore.clear()
                this.keywords = historyStore.getAll()
              })
            Span(' | ')
            Span('完成')
              .onClick(() => {
                this.isDeleting = false
              })
          }
          .fontSize(14)
          .fontColor($r('app.color.common_gray_01'))
        } else {
          Image($r('app.media.ic_public_delete'))
            .width(16)
            .aspectRatio(1)
            .fillColor($r('app.color.common_gray_03'))
            .onClick(() => {
              this.isDeleting = true
            })
        }
      }
      .width('100%')

      ForEach(this.keywords, (keyword: string) => {
        Row({ space: 8 }) {
          Text(keyword)
            .fontSize(14)
            .fontColor('#6F6F6F')
          if (this.isDeleting) {
            Image($r('app.media.ic_public_close'))
              .width(12)
              .aspectRatio(1)
              .fillColor('#878787')
              .onClick(() => {
                historyStore.delItem(keyword)
                this.keywords = historyStore.getAll()
              })
          }
        }
        .padding({ left: 12, right: 12 })
        .height(32)
        .backgroundColor('#f3f4f5')
        .borderRadius(16)
        .margin({ right: 15, top: 15 })
        .onClick(() => {
          if (!this.isDeleting) {
            this.onSearch(keyword)
          }
        })
      })
    }
    .padding(15)
  }
}