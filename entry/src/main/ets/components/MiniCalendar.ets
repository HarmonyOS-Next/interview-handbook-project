import dayjs from 'dayjs'
import { vp2vp } from '../utils/base'
import logger from '../utils/logger'
const img = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEQAAABECAYAAAA4E5OyAAAACXBIWXMAABYlAAAWJQFJUiTwAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAF5SURBVHgB7drLUcMwFIXhGzvOMKwoJXSAO0gJ0BkdECoQJaQT2II1MTo8NiZsmLm6R+R8mzjJIuN/Yo0tyUxERERERERE/rmVOUopXa3Xm4dyeFN+ap/z6904ji9GrDNHfT/s7CMGzLsSJyGSEXMNMs+2PPktexTXIMfjdF9eDouPqaO4jiHwNY6kcrhdfHXI+W1kG1Pcg0BLUaoEgVaiVAsCLUSpGgTYo1QPAsxRQoIAa5SwIMAYJTQIsEUJDwJMUSiCAEsUmiDAEIUqCERHoQsCkVFcH///CieME7cTUwddN9yaI8og31Yn/r993z+bI8oguGSGYZPKjNuPS2aaLh7NEeWg+luMnC/L1XR9PoNqdAygujGLjgE0t+4MMYDi4Y4lBoQ//jPFgNAJIrYYEDaFyBgDQiaZWWNA9WUI5hhQdaGKPQZUW8psIQZUWexuJQa47yBqKQa47yBqKQbU3kFEHQNq7CDaf76bn9hjiIiIiIiIiMhZeAeOPE1Nm7TnTQAAAABJRU5ErkJggg=='

class DayItem {
  public date: number
  public month: number
  public year: number
  public isSelected?: boolean
}

@Component
export default struct MiniCalendar {
  @Prop
  @Watch('onCurrentDateUpdate')
  currentDate: string
  @Link
  @Watch('onCurrentDateUpdate')
  selectedDays: string[]
  @State
  days: DayItem[] = []
  onClickItem: (date: string) => void

  // 内部属性
  private weeks: string[] = ['日', '一', '二', '三', '四', '五', '六']
  private selectedText: string = '已打卡'
  private format: string = 'YYYY-MM-DD'

  onCurrentDateUpdate() {
    this.days = this.getDays(this.currentDate)
  }

  aboutToAppear() {
    this.days = this.getDays(this.currentDate)
  }

  getDays(originDate?: string) {
    const date = originDate ? dayjs(originDate) : dayjs()
    const days: DayItem[] = []
    const len = 42

    // 当前月
    const currDays = date.daysInMonth()
    for (let index = 1; index <= currDays; index++) {
      days.push({
        date: index,
        month: date.month() + 1,
        year: date.year(),
        isSelected: this.selectedDays.some(item=>date.date(index).isSame(item))
      })
    }
    // 上个月
    const prevMonth = date.date(0)
    const prevMonthLastDate = prevMonth.date()
    const prevDays = prevMonth.day()
    if (prevDays < 6) {
      for (let index = prevDays; index >= 0; index--) {
        days.unshift({
          date: prevMonthLastDate - index,
          month: prevMonth.month() + 1,
          year: prevMonth.year()
        })
      }
    }
    // 下个月
    const nextMonth = date.date(currDays + 1)
    const start = days.length
    for (let index = 1; index <= len - start; index++) {
      days.push({
        date: index,
        month: nextMonth.month() + 1,
        year: nextMonth.year()
      })
    }

    return days
  }

  isTheMonth(month: number) {
    return dayjs(this.currentDate).month() === month - 1
  }

  @Styles
  btnStyle() {
    .width(vp2vp(20))
    .height(vp2vp(20))
    .backgroundColor('#f6f7f9')
    .borderRadius(vp2vp(4))
  }

  build() {
    Column() {
      Row() {
        Column() {
          Image(img).width(vp2vp(14)).width(vp2vp(14)).rotate({ angle: 180 })
        }
        .btnStyle()
        .justifyContent(FlexAlign.Center)
        .onClick(() => {
          this.currentDate = dayjs(this.currentDate).subtract(1, 'month').format(this.format)
        })

        Text(dayjs(this.currentDate).format('YYYY年MM月'))
          .fontColor('#6B7897')
          .margin({ right: vp2vp(20), left: vp2vp(20) })
          .width(vp2vp(110))
          .textAlign(TextAlign.Center)

        Column() {
          Image(img).width(vp2vp(14)).width(vp2vp(14))
        }
        .btnStyle()
        .justifyContent(FlexAlign.Center)
        .onClick(() => {
          this.currentDate = dayjs(this.currentDate).add(1, 'month').format(this.format)
        })
      }
      .padding(15)

      GridRow({ columns: 7 }) {
        ForEach(this.weeks, (item) => {
          GridCol() {
            Column() {
              Text(item)
                .fontColor('#6E7B8A')
            }
          }.height(vp2vp(40))
        })
        ForEach(this.days, (item: DayItem) => {
          GridCol() {
            Column() {
              if (item.isSelected) {
                Text(item.date.toString())
                  .fontColor('#fff')
                  .width(vp2vp(32))
                  .height(vp2vp(32))
                  .borderRadius(vp2vp(16))
                  .backgroundColor('#FFC531')
                  .textAlign(TextAlign.Center)
                  .fontSize(vp2vp(14))
                Text(this.selectedText)
                  .fontColor('#FFC531')
                  .fontSize(vp2vp(10))
                  .margin({ top: vp2vp(2) })

              } else {
                Text(item.date.toString())
                  .width(vp2vp(32))
                  .height(vp2vp(32))
                  .fontSize(vp2vp(14))
                  .textAlign(TextAlign.Center)
                  .fontColor(this.isTheMonth(item.month) ? '#6E7B8A' : '#E1E4E7')
              }
            }.onClick(() => {
              const date = `${item.year}-${item.month.toString().padStart(2, '0')}-${item.date.toString()
                .padStart(2, '0')}`
              this.onClickItem(date)
            })
          }.height(vp2vp(48))
        })
      }
      .padding({ top: vp2vp(15) })
      .border({ width: { top: 0.5 }, color: '#f6f7f9' })
    }
    .width('100%')
    .backgroundColor('#fff')
    .borderRadius(vp2vp(8))
  }
}