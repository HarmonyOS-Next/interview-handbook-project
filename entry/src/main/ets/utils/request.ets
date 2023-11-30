import http from '@ohos.net.http'
import logger from './logger';
import { stringify } from './base'
import router from '@ohos.router';
import { PAGE_MAP } from '../constants';
import { ResponseData } from '../models'
import { UserInfo } from '../models';
import promptAction from '@ohos.promptAction';

const httpRequest = http.createHttp()

export const BaseURL = 'https://api-harmony-teach.itheima.net/hm/'
// export const BaseURL = 'http://172.17.2.113:7003/hm/'

const request = <T = unknown>(url: string = '', method: http.RequestMethod = http.RequestMethod.GET, data: object = {
}) => {

  let urlStr = BaseURL + url
  if (method === http.RequestMethod.GET) {
    const params = stringify(data)
    if (params) {
      urlStr += `?${params}`
    }
  }

  logger.info(`request→${url}→${method}`, JSON.stringify(data));

  const config: http.HttpRequestOptions = {
    header: {
      'Content-Type': 'application/json',
    },
    method,
    readTimeout: 10000
  }
  const user = JSON.parse(AppStorage.Get('user') || '{}') as UserInfo

  if (user?.token) {
    config.header['Authorization'] = `Bearer ${user.token}`
  }

  if (method !== http.RequestMethod.GET) {
    config.extraData = data
  }
  return httpRequest.request(urlStr, config).then(res => {
    if (res.result) {
      const result = JSON.parse(res.result as string) as ResponseData<T>
      logger.info(`response→${url}→${method}`, res.result.toString().substring(0, 300))
      if (result.code === 10000) {
        return result
      }
      if (result.code === 401) {
        if (router.getState().path !== PAGE_MAP.login) {
          AppStorage.Set('user', '{}')
          router.pushUrl({
            url: PAGE_MAP.login,
            params: {
              from: router.getState().path
            }
          },router.RouterMode.Single)
        }
      }
    }
    return Promise.reject(res.result)
  }).catch(err => {
    logger.error(`response→${url}→${method}`, JSON.stringify(err).substring(0, 300))
    promptAction.showToast({ message: '网络错误' })
    httpRequest.destroy();
    return Promise.reject(err)
  })
}

export const requestGet = <T>(url: string, data?: object) => {
  return request<T>(url, http.RequestMethod.GET, data)
}

export const requestPost = <T>(url: string, data?: object) => {
  return request<T>(url, http.RequestMethod.POST, data)
}

export const requestPut = <T>(url: string, data?: object) => {
  return request<T>(url, http.RequestMethod.PUT, data)
}

export const requestDelete = <T>(url: string, data?: object) => {
  return request<T>(url, http.RequestMethod.DELETE, data)
}