import http from '@ohos.net.http'
import logger from './logger';
import { stringify } from './base'

const httpRequest = http.createHttp()

export const BaseURL = 'https://api-teach.itheima.net/wxmini/'

export const request = (url: string = '', method: http.RequestMethod = http.RequestMethod.GET, data: object = {}) => {

  let urlStr = BaseURL + url
  if (method === http.RequestMethod.GET) {
    const params = stringify(data)
    if (params) {
      urlStr += `?${params}`
    }
  }

  logger.info('request→', encodeURIComponent(urlStr));


  const config: http.HttpRequestOptions = {
    header: {
      'Content-Type': 'application/json'
    },
    method,
    readTimeout: 5000
  }
  if (method !== http.RequestMethod.GET) {
    config.extraData = data
  }
  return httpRequest.request(urlStr, config).then(res => {
    logger.info('request→', JSON.stringify(res.result))
    if (res.result && (res.result as {
      code: number;
      message: string;
      data: unknown
    }).code === 401) {
      logger.error('request→', 'UNAUTHORIZED')
      return Promise.reject(res.result)
    }
    return res.result
  }).catch(err => {
    logger.error('request→', JSON.stringify(err))
    httpRequest.destroy();
    return Promise.reject(err)
  })
}