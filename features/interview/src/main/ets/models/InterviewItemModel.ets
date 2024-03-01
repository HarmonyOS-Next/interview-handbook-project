export interface InterviewItem {
  id: string
  stem: string
  content: string
  likeCount: number
  views: number
  creatorName: string
  creatorAvatar: ResourceStr
  createdAt: string
  stage: string[]
  likeFlag: 0 | 1 | null
  relatedQuestions: InterviewRelatedQuestion[] | null
}

export interface InterviewRelatedQuestion {
  id: string
  stem: string
}

export class InterviewListParams {
  page: number = 1
  questionBankType: number = 9
  sort: number = 30
  keyword: string = ''
}

export class InterviewItemModel implements InterviewItem {
  id: string = ''
  stem: string = ''
  content: string = ''
  likeCount: number = 0
  views: number = 0
  creatorName: string = ''
  creatorAvatar: ResourceStr = ''
  createdAt: string = ''
  stage: string[] = []
  likeFlag: 0 | 1 | null = null
  relatedQuestions: InterviewRelatedQuestion[] | null = null

  constructor(model: InterviewItem) {
    this.id = model.id
    this.stem = model.stem
    this.content = model.content
    this.likeCount = model.likeCount
    this.views = model.views
    this.creatorName = model.creatorName
    this.creatorAvatar = model.creatorAvatar
    this.createdAt = model.createdAt
    this.stage = model.stage
    this.likeFlag = model.likeFlag
    this.relatedQuestions = model.relatedQuestions
  }
}

export const interviewListData: InterviewItem[] = [
  {
    id: '10001',
    stem: '微软谷歌面试算法难度 | 你想象不到的简单',
    content: '内推 候选人可以找到认识的微软员工,员工会把简历提交到微软人才库。这样微软HR就可以在人才库的系统中查看到你的简历。',
    likeCount: 13,
    views: 347,
    creatorName: '凡人的积累',
    creatorAvatar: $r('app.media.ic_interview_avatar'),
    createdAt: '一周前',
    stage: ['大厂', '算法'],
    likeFlag: 1,
    relatedQuestions: []
  },
  {
    id: '10002',
    stem: '美团-工程效能组-开发工程师实习生(工程基建方向)-一面',
    content: '项目介绍网页音视频项目项目代码量多少？是一个人完成的吗？介绍SaaS视频项目SpringSpring框架有什么特性？(不知道这个问题要问什么，答的扩展性、封装性啥的)控制反转了解吗？',
    likeCount: 32,
    views: 503,
    creatorName: '响亮的名字',
    creatorAvatar: $r('app.media.ic_interview_avatar'),
    createdAt: '10 小时前',
    stage: ['大厂', 'Java'],
    likeFlag: 0,
    relatedQuestions: []
  },
  {
    id: '10003',
    stem: '中邮消费金融AI算法工程师（实习生）',
    content: '这个是在猎聘上投递的 能收到面试属实是意外之喜面试官是nlp方向的，主要是问nlp相关 首先自我介绍说一个在上段实习中的项目 这里说了一个搭建智能客服对话助手',
    likeCount: 10,
    views: 98,
    creatorName: '不想秃头的夜猫子',
    creatorAvatar: $r('app.media.ic_interview_avatar'),
    createdAt: '23 分钟前',
    stage: ['国企', '实习'],
    likeFlag: 1,
    relatedQuestions: []
  }
]