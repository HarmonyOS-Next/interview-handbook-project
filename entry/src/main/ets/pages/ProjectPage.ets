import router from '../utils/router'
import { QuestionType, ResponseData, TagItem } from '../models'
import { requestGet } from '../utils/request'
import { PAGE_MAP } from '../constants'
import { vp2vp } from '../utils/base'


@Preview
@Component
export struct ProjectPage {
  @State
  projectList: QuestionType[] = []

  aboutToAppear() {
    // setTimeout(() => {
    //   this.projectList = [
    //     {
    //       id: 1,
    //       name: '后台管理系统',
    //       icon: '',
    //       describeInfo: '以Vue技理后台后台管理系统面试题面试整理',
    //       tags: [
    //         { tagName: '项目必问' }
    //       ]
    //     },
    //     {
    //       id: 2,
    //       name: '在线问医生平台（医疗类）',
    //       icon: '',
    //       describeInfo: '通过vue3+ts实现的在线医疗问诊相关技术整理',
    //       tags: [
    //         { tagName: '项目必问' }
    //       ]
    //     }
    //   ]
    // }, 1000)
    requestGet('question/type', { type: 'items' })
      .then((res: ResponseData<QuestionType[]>) => {
        this.projectList = res.data
      })
  }

  build() {
    List() {
      ForEach(this.projectList, (item: QuestionType) => {
        ListItem() {
          Row() {
            Image(item.icon)
              .width(vp2vp(60))
              .height(vp2vp(80))
            Column() {
              Text(item.name).width('100%').margin({ bottom: vp2vp(5) }).fontSize(vp2vp(16))
              Row() {
                Text(item.describeInfo)
                  .width('100%')
                  .fontColor($r('app.color.ih_gray_color'))
                  .fontSize(vp2vp(12))
                  .maxLines(2)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
              }
              .width('100%')
              .layoutWeight(1)
              .alignItems(VerticalAlign.Top)

              Row() {
                ForEach(item.tags, (tag: TagItem) => {
                  Text(tag.tagName)
                    .fontSize(vp2vp(10))
                    .lineHeight(vp2vp(10))
                    .padding(vp2vp(5))
                    .borderRadius(vp2vp(4))
                    .backgroundColor('#EDF2FF')
                    .fontColor('#3266EE')
                    .margin({ right: vp2vp(5) })
                })
              }
              .width('100%')
            }
            .padding({ left: vp2vp(15) })
          }
        }
        .padding({ top: vp2vp(15), bottom: vp2vp(15) })
        .height(vp2vp(110))
        .onClick(()=>{
          router.push({
            url: PAGE_MAP.project_list,
            params: {
              id: item.id,
              name: item.name
            }
          })
        })
      })
    }
    .padding(vp2vp(15))
    .height('100%')
    .width('100%')
    .divider({
      strokeWidth: 0.5,
      color: '#e4e4e4'
    })
  }
}