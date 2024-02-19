import { media } from '@kit.MediaKit'
import { request } from '@kit.BasicServicesKit'
import fs from '@ohos.file.fs'
import { logger } from '@itcast/basic/Index'

@CustomDialog
export struct WordSoundDialog {
  controller: CustomDialogController
  wordEn: string = ''
  wordZh: string = ''
  @State
  loading: boolean = true
  @State
  isGreen: boolean = false
  timer: number = -1
  res: media.AVPlayer = Object()
  streamId: number = -1

  aboutToAppear() {
    this.beforePlaySound()
  }

  async play(fp: string) {
    // try {
    //   this.soundPool = await media.createSoundPool(5, {
    //     usage: audio.StreamUsage.STREAM_USAGE_MUSIC,
    //     rendererFlags: 1
    //   })
    //   const file = await fs.open(fp, fs.OpenMode.READ_ONLY)
    //   const uri = `fd://${file.fd}`
    //   const soundId = await this.soundPool.load(uri)
    //   this.streamId = await this.soundPool.play(soundId, { loop: -1 })
    // } catch (err) {
    //   logger.error(JSON.stringify(err))
    // }
    const file = await fs.open(fp, fs.OpenMode.READ_ONLY)
    const uri = `fd://${file.fd}`
    media.createAVPlayer().then(res => {
      this.res = res
      res.url = uri
      res.on('stateChange', (state) => {
        if (state === 'idle') {
          res.release()
        }
        if (state === 'initialized') {
          res.prepare()
        }
        if (state === 'prepared') {
          res.loop = true
          res.play()
        }
        // if (state === 'playing') {
        //   res.pause()
        // }
        // if (state === 'paused') {
        //   res.play()
        // }
        if (state === 'completed') {
          res.stop()
        }
        if (state === 'stopped') {
          res.reset()
        }
      })
    })
  }

  async beforePlaySound() {
    try {
      const ctx = getContext()
      const dir = `${ctx.cacheDir}/word`
      const filePath = `${dir}/${this.wordEn}.mp3`
      try {
        fs.statSync(dir)
      } catch (err) {
        logger.error(JSON.stringify(err))
        fs.mkdirSync(dir)
      }
      try {
        fs.statSync(filePath)
        this.loading = false
        this.play(filePath)
      } catch (err) {
        logger.error(JSON.stringify(err))
        const down = await request.downloadFile(ctx, {
          url: `https://dict.youdao.com/dictvoice?type=1&audio=${this.wordEn}`,
          filePath
        })
        down.on('complete', () => {
          this.loading = false
          // 播放
          this.play(filePath)
        })
      }
    } catch (err) {
      logger.error(JSON.stringify(err))
    }
  }

  build() {
    Column({ space: 10 }) {
      if (!this.loading) {
        Row({ space: 10 }) {
          Text(this.wordEn)
            .fontSize(20)
            .fontColor(Color.White)
            .fontWeight(500)
          Image($r('sys.media.ohos_ic_public_sound'))
            .width(20)
            .aspectRatio(1)
            .fillColor(this.isGreen ? $r('app.color.common_green') : Color.White)
            .onAppear(() => {
              clearInterval(this.timer)
              this.timer = setInterval(() => {
                this.isGreen = !this.isGreen
              }, 500)
            })
            .onDisAppear(() => {
              clearInterval(this.timer)
              this.res.stop().then(() => {
                this.res.release()
              })
            })
            .animation({ duration: 300 })
        }

        Text(this.wordZh)
          .fontColor(Color.White)
      } else {
        LoadingProgress()
          .width(50)
          .aspectRatio(1)
          .color(Color.White)
      }
    }
    .constraintSize({ minWidth: 175 })
    .padding({ left: 16, right: 16 })
    .height(90)
    .borderRadius(45)
    .backgroundColor('#8f000000')
    .justifyContent(FlexAlign.Center)
  }
}