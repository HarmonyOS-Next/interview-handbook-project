import router from '../utils/router'
import SearchWrapper from '../components/SearchWrapper'
import { PAGE_MAP } from '../constants'
import { InterviewItem } from '../models'
import { BasicDataSource } from '../models/BasicDatasource'
import { requestGet } from '../utils/request'
import { LoadingWrapper } from '../components/LoadingWrapper'

class InterviewDataSource extends BasicDataSource {
  private interviewList: Array<InterviewItem> = []

  public totalCount(): number {
    return this.interviewList.length;
  }

  public getData(index: number): InterviewItem {
    return this.interviewList[index];
  }

  public reloadData(data: InterviewItem[]) {
    this.interviewList.splice(0, this.interviewList.length, ...data)
    this.notifyDataReload()
  }

  public addData(index: number, data: InterviewItem): void {
    this.interviewList.splice(index, 0, data);
    this.notifyDataAdd(index);
  }

  public updateData(data: Partial<InterviewItem>): void {
    const index = this.interviewList.findIndex(item => item.id === data.id)
    if (index > -1) {
      this.interviewList.splice(index, 1, { ...this.interviewList[index], ...data });
      this.notifyDataChange(index);
    }
  }

  public pushData(data: Array<InterviewItem>): void {
    this.interviewList.push(...data);
    this.notifyDataAdd(this.interviewList.length - 1);
  }
}

@Preview
@Component
export struct InterviewPage {
  @State
  left: number = 15
  @State
  sort: number = 30
  @State
  page: number = 1
  @State
  loading: boolean = false
  @State
  finished: boolean = false
  interviewDataSource: InterviewDataSource = new InterviewDataSource()
  scroller: Scroller = new Scroller()

  setLineLeft(area: Area) {
    const width = area.width as number
    const x = area.position.x as number
    this.left = x + (width - 16) / 2
  }

  aboutToAppear() {
    this.getInterviewData()
  }

  getInterviewData() {
    if (this.loading || this.finished) return

    this.loading = true
    requestGet<{
      rows: InterviewItem[],
      total: number,
      pageTotal: number
    }>('question/list', {
      questionBankType: 9,
      page: this.page,
      sort: this.sort
    })
      .then(res => {
        if (this.page === 1) {
          this.interviewDataSource.reloadData(res.data.rows)
          this.scroller.scrollTo({ yOffset: 0, xOffset: 0 })
        } else {
          this.interviewDataSource.pushData(res.data.rows)
        }
        this.loading = false
        if (this.page >= res.data.pageTotal) {
          this.finished = true
        } else {
          this.page++
        }
      })
  }

  build() {
    Column() {
      SearchWrapper({
        alignValue: FlexAlign.Center
      }).padding(15)

      Stack() {
        Row() {
          Text('推荐')
            .fontSize(14)
            .padding(10)
            .fontColor(this.sort === 30 ? '#000' : '#979797')
            .onClick((e) => {
              this.setLineLeft(e.target.area)
              this.sort = 30
              this.page = 1
              this.getInterviewData()
            })
            .onAreaChange((oldArea, newArea) => this.setLineLeft(newArea))
          Text('最新')
            .fontSize(14)
            .padding(10)
            .fontColor(this.sort === undefined ? '#000' : '#979797')
            .onClick((e) => {
              this.setLineLeft(e.target.area)
              this.sort = undefined
              this.page = 1
              this.getInterviewData()
            })
        }
        .width('100%')
        .padding({ left: 15, right: 15 })
        .height(40)

        Text()
          .width(16)
          .height(2)
          .backgroundColor('#000')
          .position({ x: this.left, y: 38 })
          .animation({
            duration: 300
          })
      }
      .border({ width: { bottom: 0.5 }, color: '#e4e4e4' })

      Column() {
        List({ scroller: this.scroller }) {
          LazyForEach(this.interviewDataSource, (item: InterviewItem) => {
            ListItem() {
              Column() {
                Row() {
                  Image(item.creatorAvatar)
                    .width(30)
                    .height(30)
                    .borderRadius(15)
                    .sharedTransition('image' + item.id, { duration: 300, curve: Curve.Linear })
                  Column() {
                    Text(item.stem)
                      .fontWeight(FontWeight.Bold)
                      .margin({ bottom: 3 })
                      .sharedTransition('title' + item.id, { duration: 300, curve: Curve.Linear })
                    Text(`${item.creatorName} | ${item.createdAt}`)
                      .fontSize(9)
                      .fontColor('#c3c4c5')
                  }
                  .padding({ left: 12 })
                  .layoutWeight(1)
                  .alignItems(HorizontalAlign.Start)
                }
                .width('100%')
                .height(38)

                Text(item.content)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .maxLines(2)
                  .padding({ top: 10, bottom: 10 })
                  .fontColor('#848484')
                  .fontSize(14)
                  .width('100%')

                Row() {
                  Text(`点赞 ${item.likeCount}`).fontSize(12).fontColor('#c3c4c5')
                  Text('|').fontSize(12).fontColor('#c3c4c5').padding({ left: 8, right: 8 })
                  Text(`浏览 ${item.views}`).fontSize(12).fontColor('#c3c4c5')
                }
                .width('100%')

              }
              .padding(15)
              .onClick(() => {
                router.push({
                  url: PAGE_MAP.interview_detail,
                  params: item
                })
              })
            }
          }, (item: InterviewItem) => {
            const { id, likeCount, views } = item
            return JSON.stringify({ id, likeCount, views })
          })
          ListItem() {
            LoadingWrapper({
              finished: this.finished,
              loading: this.loading
            })
          }
        }
        .width('100%')
        .height('100%')
        .divider({
          strokeWidth: 8,
          color: '#f5f5f5'
        })
        .onReachEnd(() => {
          this.getInterviewData()
        })
      }
      .layoutWeight(1)
    }
    .height('100%')
  }
}