import http from '@ohos.net.http'
import logger from './logger';
import { stringify } from './base'
import router from '@ohos.router';
import { PAGE_MAP } from '../constants';
import { ResponseData } from '../models'

const httpRequest = http.createHttp()

export const BaseURL = 'https://api-harmony-teach.itheima.net/hm/'
// export const BaseURL = 'http://172.17.2.113:7003/hm/'

const request = (url: string = '', method: http.RequestMethod = http.RequestMethod.GET, data: object = {}) => {

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
    if (res.result && (res.result as ResponseData).code === 401) {
      logger.error('request→', 'UNAUTHORIZED')
      router.pushUrl({
        url: PAGE_MAP.login
      })
      return Promise.reject(res.result)
    }
    return JSON.parse(res.result as string)
  }).catch(err => {
    logger.error('request→', JSON.stringify(err))
    httpRequest.destroy();
    return Promise.reject(err)
  })
}

export const requestGet = (url: string, data?: object) => {
  return request(url, http.RequestMethod.GET, data)
}

export const requestPost = (url: string, data?: object) => {
  return request(url, http.RequestMethod.POST, data)
}

export const requestPut = (url: string, data?: object) => {
  return request(url, http.RequestMethod.PUT, data)
}

export const requestDelete = (url: string, data?: object) => {
  return request(url, http.RequestMethod.DELETE, data)
}