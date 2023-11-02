export const stringify = (obj: object = {}) => {
  return Object.keys(obj).map(key => `${key}=${obj[key]}`).join('&')
}