@Component
export struct HdSkeleton {
  @Builder
  DefaultBuilder() {
  }

  @BuilderParam
  default: () => void = this.DefaultBuilder

  build() {
    Stack() {
      this.default()
      Text() {

      }
    }
  }
}



@Component
export struct HdSkeletonItem {
  build() {
    Text()
      .constraintSize({ minWidth: 10, minHeight: 10 })
      .backgroundColor($r('app.color.common_gray_bg'))
  }
}