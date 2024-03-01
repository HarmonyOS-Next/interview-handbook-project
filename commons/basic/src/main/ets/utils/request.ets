import { http } from '@kit.NetworkKit';
import { authStore } from './auth';
import { promptAction, router } from '@kit.ArkUI';
import { BusinessError } from '@ohos.base';
import { logger } from './logger';

interface HdRequestOptions {
  baseURL?: string
}

type HdParams = Record<string, string | number | boolean>

export interface HdResponse<T> {
  code: number
  message: string
  data: T
}

class HdHttp {
  baseURL: string

  constructor(options: HdRequestOptions) {
    this.baseURL = options.baseURL || ''
  }

  private request<T>(path: string, method: http.RequestMethod = http.RequestMethod.GET, extraData?: Object) {
    const httpInstance = http.createHttp()

    const options: http.HttpRequestOptions = {
      header: {
        'Content-Type': 'application/json'
      },
      method,
      expectDataType: http.HttpDataType.OBJECT
    }

    let fullUrl = this.baseURL + path

    if (method === http.RequestMethod.GET && extraData) {
      const strArr = Object.keys(extraData)
        .filter(key => (extraData as HdParams)[key] !== undefined)
        .map(key => `${key}=${(extraData as HdParams)[key]}`)
      fullUrl += `?${strArr.join('&')}`
    } else {
      options.extraData = extraData
    }

    const user = authStore.getUser()
    if (user.token && options.header) {
      options.header['Authorization'] = `Bearer ${user.token}`
    }

    return httpInstance.request(fullUrl, options).then((res) => {
      if (res.result) {
        const result = res.result as HdResponse<T>
        if (result.code === 10000) {
          logger.info(fullUrl, JSON.stringify(res.result).substring(0, 200))
          return result
        }
        if (result.code === 401) {
          authStore.delUser()
          router.pushUrl({
            url: 'pages/LoginPage'
          }, router.RouterMode.Single)
          throw new Error('登录过期')
        }
      }
      return Promise.reject(res.result)
    }).catch((err: BusinessError) => {
      logger.error(fullUrl, err.code?.toString(), err.message)
      promptAction.showToast({ message: err.message || '网络错误' })
      return Promise.reject(err)
    }).finally(() => {
      httpInstance.destroy()
    })
  }

  get<T>(url: string, data?: Object): Promise<HdResponse<T>> {
    return this.request<T>(url, http.RequestMethod.GET, data)
  }

  post<T>(url: string, data?: Object): Promise<HdResponse<T>> {
    return this.request<T>(url, http.RequestMethod.POST, data)
  }

  put<T>(url: string, data?: Object): Promise<HdResponse<T>> {
    return this.request<T>(url, http.RequestMethod.PUT, data)
  }

  delete<T>(url: string, data?: Object): Promise<HdResponse<T>> {
    return this.request<T>(url, http.RequestMethod.DELETE, data)
  }
}


export const hdHttp = new HdHttp({ baseURL: 'https://api-harmony-teach.itheima.net/hm/' })