export const getTimeText = (time: number = 0, hasUnit = true) => {
  if (time < 3600) {
    return String(Math.floor(time / 60)) + (hasUnit ? ' 分钟' : '')
  } else {
    return String(Math.round(time / 3600 * 10) / 10) + (hasUnit ? ' 小时' : '')
  }
}

export const getPercentText =
  (value: number, total: number) => Math.round(value / total * 100) + '%'
