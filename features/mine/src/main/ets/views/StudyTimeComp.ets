import { getPercentText, getTimeText, hdHttp, HdLoadingDialog, HdNav } from '@itcast/basic'


interface TimeItem {
  id: string
  name: string
  total: number
  done: number
  undone: number
}

interface StudyData {
  type: string,
  list: TimeItem[]
}

interface ResponseData {
  totalTime: number,
  studyData: StudyData[]
}


@Component
export struct StudyTimeComp {
  @State
  data: ResponseData = {
    totalTime: 0,
    studyData: []
  }
  dialog: CustomDialogController = new CustomDialogController({
    builder: HdLoadingDialog({ message: '加载中...' }),
    customStyle: true,
    alignment: DialogAlignment.Center
  })

  aboutToAppear(): void {
    this.dialog.open()
    hdHttp.get<ResponseData>('studyInfo').then(res => {
      this.data = res.data
      this.dialog.close()
    })
  }

  @Builder
  progressBuilder(title: string, done: number, total: number, color: string = '#87E0CD') {
    GridCol() {
      Column() {
        Row() {
          Text(title)
            .fontColor('#c3c4c5')
            .fontSize(14)
          Text(getPercentText(done, total))
            .fontColor('#c3c4c5')
            .fontSize(14)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ bottom: 5 })

        Progress({ value: done, total: total })
          .color(color)
          .width('100%')
      }
    }
  }

  @Builder
  dotBuilder(color: string, isDark: boolean) {
    Row() {
      Text()
        .width(7)
        .aspectRatio(1)
        .borderRadius(4)
        .backgroundColor(isDark ? '#d9d9d9' : color)
        .margin({ right: 4 })
      Text(isDark ? '未学占比' : '已学占比')
        .fontSize(12)
        .fontColor(isDark ? '#d9d9d9' : $r('app.color.common_gray_03'))
    }
  }

  build() {
    Column() {
      HdNav({ title: '学习数据', showRightIcon: false })
      Scroll() {
        Column() {
          // time
          Column() {
            Row() {
              Text('累计学习时长')
                .margin({ right: 5 })
                .fontColor($r('app.color.common_gray_03'))
              Image($r('sys.media.ohos_ic_public_clock'))
                .width(16)
                .aspectRatio(1)
                .fillColor('#41B8B1')
            }.width('100%').margin({ bottom: 10 })

            Row() {
              Text(getTimeText(this.data.totalTime, false))
                .fontSize(40)
                .fontWeight(FontWeight.Bold)
                .fontColor('#41B8B1')
              Text(this.data.totalTime < 3600 ? '分钟' : '小时')
                .margin({ bottom: 8, left: 8 })
                .fontColor('#41B8B1')
            }
            .width('100%')
            .alignItems(VerticalAlign.Bottom)
          }

          if (this.data.studyData[0]) {
            // knowledge
            Text('知识点学习进度')
              .margin({ bottom: 10, top: 30 })
              .width('100%')
            GridRow({ columns: 2, gutter: 20 }) {
              ForEach(this.data.studyData[0].list, (time: TimeItem) => {
                this.progressBuilder(time.name, time.done, time.total)
              })
              GridCol({ span: 2 }) {
                Row({ space: 16 }) {
                  this.dotBuilder('#87E0CD', false)
                  this.dotBuilder('#87E0CD', true)
                }
                .margin({ top: 10 })
              }
            }
            .backgroundColor(Color.White)
            .padding(16)
            .borderRadius(8)
            .shadow({ color: '#ededed', radius: 16 })
          }

          if (this.data.studyData[1]) {
            // project
            Text('项目学习进度')
              .margin({ bottom: 10, top: 30 })
              .width('100%')
            GridRow({ columns: 1, gutter: 20 }) {
              ForEach(this.data.studyData[1].list, (time: TimeItem) => {
                this.progressBuilder(time.name, time.done, time.total, '#C7B5ED')
              })
              GridCol() {
                Row({ space: 16 }) {
                  this.dotBuilder('#C7B5ED', false)
                  this.dotBuilder('#C7B5ED', true)
                }
                .margin({ top: 10 })
              }
            }
            .backgroundColor(Color.White)
            .padding(16)
            .borderRadius(8)
            .shadow({ color: '#ededed', radius: 16 })
          }
        }
        .padding(16)
      }
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r('app.media.study_time_bg'))
    .backgroundImageSize({ width: '100%' })
    .backgroundColor($r('app.color.common_gray_bg'))
  }
}