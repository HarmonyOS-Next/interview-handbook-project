import display from '@ohos.display';
import deviceInfo from '@ohos.deviceInfo'

export const stringify = (obj: object = {}) => {
  return Object.keys(obj).map(key => `${key}=${obj[key]}`).join('&')
}

export const getTimeText = (time: number = 0, hasUnit = true) => {
  if (time < 3600) {
    return String(Math.floor(time / 60)) + (hasUnit ? ' 分钟' : '')
  } else {
    return String(Math.round(time / 3600 * 10) / 10) + (hasUnit ? ' 小时' : '')
  }
}

export const getPercentText =
  (value: number, total: number) => Math.round(value / total * 100) + '%'


const width = display.getDefaultDisplaySync().width
/**
 * 手机端缩放vp
 */
export const vp2vp = (origin: number) => {
  if (deviceInfo.deviceType === 'default') {
    return px2vp(width) / 375 * origin
  } else {
    return origin
  }
}