import { HdNav } from '@itcast/basic'

@Component
export struct WordComp {
  build() {
    Column() {
      HdNav({ title: '常用单词', showRightIcon: false })
      
    }
    .width('100%')
    .height('100%')
  }
}