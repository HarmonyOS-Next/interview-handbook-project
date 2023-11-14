export class ResponseData<T = unknown> {
  public code: number
  public msg: string
  public data: T
}

export class TagItem {
  public tagName: string
  public nameColor?: string
  public borderColor?: string
}

export class QuestionType {
  public id: number
  public name: string
  public icon?: string
  public describeInfo?: string
  public displayNewestFlag?: 0 | 1
  public tags?: TagItem[]
}

export enum QuestionTypeEnum {
  SingleChoice = 1,
  MultipleChoices = 2,
  Judgment = 3,
  ShortAnswer = 5,
  Code = 6,
  RealOperation = 7
}

export class QuestionItem {
  public id: string
  public stem: string
  public difficulty: number
  public likeCount: number
  public views: number
  public readFlag?: 0 | 1
}

export class QuestionDetail extends QuestionItem {
  public answer: string
  public collectFlag: 0 | 1
  public likeFlag: 0 | 1
  public stage: Array<string>
}

export class UserInfo {
  public token: string
  public refreshToken: string
  public id: string
  public username: string
  public avatar: string
  public nickName?: string
  public totalTime?: number
  public shareInfo: string
}

export class ClockInfo {
  public flag: boolean
  public clockinNumbers: number
  public totalClockinNumber: number
  public clockins: {
    id: string,
    createdAt: string
  }[]
}

export class InterviewItem {
  public id: string
  public stem: string
  public content: string
  public likeCount: number
  public views: number
  public creatorName: string
  public creatorAvatar: string
  public createdAt: string
  public likeFlag?: 0 | 1
}