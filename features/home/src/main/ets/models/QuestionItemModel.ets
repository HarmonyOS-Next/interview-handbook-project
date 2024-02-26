export interface QuestionItem {
  id: string
  stem: string
  difficulty: number
  likeCount: number
  views: number
  readFlag: 0 | 1
}

export class QuestionItemModel implements QuestionItem {
  id: string = ''
  stem: string = ''
  difficulty: number = 0
  likeCount: number = 0
  views: number = 0
  readFlag: 0 | 1 = 0

  constructor(model: QuestionItem) {
    this.id = model.id
    this.stem = model.stem
    this.difficulty = model.difficulty
    this.likeCount = model.likeCount
    this.views = model.views
    this.readFlag = model.readFlag
  }
}

export interface QuestionDetail extends QuestionItem {
  answer: string
  collectFlag: 0 | 1
  likeFlag: 0 | 1
  stage: Array<string>
}

export const questionListData: QuestionItem[] = [
  {
    id: '100',
    stem: '@Prop 是否可以设置默认值？',
    difficulty: 1,
    likeCount: 102,
    views: 321,
    readFlag: 0
  },
  {
    id: '101',
    stem: '@State支持哪些类型数据？',
    difficulty: 2,
    likeCount: 32,
    views: 854,
    readFlag: 0
  },
  {
    id: '102',
    stem: 'Vue3中内置组件有哪些？分别有什么作用？',
    difficulty: 3,
    likeCount: 10,
    views: 1002,
    readFlag: 0
  },
  {
    id: '103',
    stem: '华为支付如何实现？',
    difficulty: 4,
    likeCount: 45,
    views: 123,
    readFlag: 0
  },
  {
    id: '104',
    stem: '运动健康服务如何开启？',
    difficulty: 5,
    likeCount: 90,
    views: 423,
    readFlag: 0
  },
  {
    id: '105',
    stem: '@Prop 是否可以设计默认值？',
    difficulty: 1,
    likeCount: 345,
    views: 5433,
    readFlag: 0
  },
  {
    id: '106',
    stem: '@State支持哪些类型数据？',
    difficulty: 2,
    likeCount: 23,
    views: 139,
    readFlag: 0
  },
  {
    id: '107',
    stem: 'Vue3中内置组件有哪些？',
    difficulty: 3,
    likeCount: 12,
    views: 767,
    readFlag: 0
  },
  {
    id: '108',
    stem: '华为支付如何实现？',
    difficulty: 4,
    likeCount: 65,
    views: 723,
    readFlag: 0
  },
  {
    id: '109',
    stem: '运动健康服务如何开启？',
    difficulty: 5,
    likeCount: 12,
    views: 432,
    readFlag: 0
  }
]

export class QuestionListParams {
  type: number = 0
  page: number = 1
  questionBankType: number = 9
  sort?: number = 0
  keyword?: string = ''
  difficult?: number = 0
}