import { getTimeText, getPercentText } from '../utils/base'
import { requestGet } from '../utils/request'
import { LoadingDialog } from '../components/LoadingDialog'

class ListItem {
  public id: string
  public name: string
  public total: number
  public done: number
  public undone: number
}

@Entry
@Component
struct StudyTimePage {
  @State
  knowledge: ListItem[] = []
  @State
  project: ListItem[] = []
  @State
  totalTime: number = 0

  dialog: CustomDialogController = new CustomDialogController({
    builder: LoadingDialog({ message: '加载中...' }),
    customStyle: true
  })

  aboutToAppear() {
    this.dialog.open()
    requestGet<{
      totalTime: number,
      studyData: {
        type: string,
        list: ListItem[]
      }[]
    }>('studyInfo').then(res => {
      this.knowledge = res.data.studyData[0].list
      this.project = res.data.studyData[1].list
      this.totalTime = res.data.totalTime
      this.dialog.close()
    })
  }

  aboutToDisappear() {
    delete this.dialog
    this.dialog = undefined
  }

  build() {
    Navigation() {
      Scroll() {
        Column() {
          Row() {
            Text('累计学习时长').margin({ right: 4 })
            Image($r('app.media.icon_study_clock')).width(14).height(14)
          }.width('100%').margin({ bottom: 10 })

          Row() {
            Text(getTimeText(this.totalTime, false)).fontSize(40).fontWeight(FontWeight.Bold)
            Text(this.totalTime < 3600 ? '分钟' : '小时').margin({ bottom: 8, left: 8 })
          }.width('100%').alignItems(VerticalAlign.Bottom).margin({ bottom: 20 })

          Column() {
            Text('知识点学习进度').margin({ bottom: 10 })
            GridRow({ columns: 2, gutter: 20 }) {
              ForEach(this.knowledge, (item: ListItem) => {
                GridCol() {
                  Column() {
                    Row() {
                      Text(item.name).fontColor('#c3c4c5').fontSize(14)
                      Text(getPercentText(item.done, item.total)).fontColor('#c3c4c5').fontSize(14)
                    }.width('100%').justifyContent(FlexAlign.SpaceBetween)
                    .margin({ bottom: 5 })

                    Progress({ value: item.done, total: item.total }).color('#87E0CD')
                  }
                }
              })

              GridCol({ span: 2 }) {
                Row() {
                  Text()
                    .width(7)
                    .height(7)
                    .borderRadius(4)
                    .backgroundColor('#87E0CD')
                    .margin({ right: 4 })
                  Text('已学占比').fontSize(12).margin({ right: 20 })
                  Text()
                    .width(7)
                    .height(7)
                    .borderRadius(4)
                    .backgroundColor('#c3c4c5')
                    .margin({ right: 4 })
                  Text('未学占比').fontSize(12)
                }.justifyContent(FlexAlign.Center)
              }
            }.backgroundColor('#fff').borderRadius(4).padding(15)

          }.width('100%').alignItems(HorizontalAlign.Start).margin({ bottom: 25 })

          Column() {
            Text('项目常问学习进度').margin({ bottom: 10 })
            GridRow({ columns: 1 }) {
              ForEach(this.project, (item: ListItem) => {
                GridCol() {
                  Column() {
                    Row() {
                      Text(item.name).fontColor('#c3c4c5').fontSize(14)
                      Text(getPercentText(item.done, item.total)).fontColor('#c3c4c5').fontSize(14)
                    }.width('100%').justifyContent(FlexAlign.SpaceBetween)
                    .margin({ bottom: 5 })

                    Progress({ value: item.done, total: item.total }).color('#c7b5ed').width('100%')
                  }.margin({ bottom: 25 })
                }
              })

              GridCol({ span: 2 }) {
                Row() {
                  Text()
                    .width(7)
                    .height(7)
                    .borderRadius(4)
                    .backgroundColor('#c7b5ed')
                    .margin({ right: 4 })
                  Text('已学占比').fontSize(12).margin({ right: 20 })
                  Text()
                    .width(7)
                    .height(7)
                    .borderRadius(4)
                    .backgroundColor('#c3c4c5')
                    .margin({ right: 4 })
                  Text('未学占比').fontSize(12)
                }.justifyContent(FlexAlign.Center)
              }
            }.backgroundColor('#fff').borderRadius(4).padding(15)
          }.width('100%').alignItems(HorizontalAlign.Start)

        }.padding(15)
      }
    }
    .title('学习数据')
    .titleMode(NavigationTitleMode.Mini)
    .linearGradient({
      angle: 163,
      colors: [['#defbee', 0], ['#dbf4f1', 0.2], ['#f6f7f9', 1]]
    })
  }
}