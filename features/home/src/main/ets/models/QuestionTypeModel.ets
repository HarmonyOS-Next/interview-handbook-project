export interface QuestionType {
  id: number
  name: string
  displayNewestFlag: 0 | 1
}

export class QuestionTypeModel implements QuestionType {
  id: number = 0
  name: string = ''
  displayNewestFlag: 0 | 1 = 0

  constructor(model: QuestionType) {
    this.id = model.id
    this.name = model.name
    this.displayNewestFlag = model.displayNewestFlag
  }
}

export const questionTypeData: QuestionType[] = [
  {
    id: 1,
    name: "全部",
    displayNewestFlag: 0,
  },
  {
    id: 21,
    name: "鸿蒙",
    displayNewestFlag: 0,
  },
  {
    id: 18,
    name: "HTML5",
    displayNewestFlag: 0,
  },
  {
    id: 26,
    name: "Vue",
    displayNewestFlag: 1,
  },
  {
    id: 19,
    name: "CSS3",
    displayNewestFlag: 0,
  },
  {
    id: 20,
    name: "移动端布局",
    displayNewestFlag: 1,
  },
  {
    id: 22,
    name: "jQuery",
    displayNewestFlag: 0,
  },
  {
    id: 23,
    name: "AJAX",
    displayNewestFlag: 0,
  },
  {
    id: 25,
    name: "Node",
    displayNewestFlag: 0,
  },
  {
    id: 27,
    name: "React",
    displayNewestFlag: 0,
  },
  {
    id: 28,
    name: "小程序",
    displayNewestFlag: 0,
  },
  {
    id: 304,
    name: "其它",
    displayNewestFlag: 0,
  },
  {
    id: 399,
    name: "性能优化",
    displayNewestFlag: 1,
  },
  {
    id: 398,
    name: "兼容性问题",
    displayNewestFlag: 1,
  },
];
