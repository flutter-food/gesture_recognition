# gesture_recognition

[![Pub](https://img.shields.io/pub/v/gesture_recognition.svg?style=flat-square)](https://pub.dartlang.org/packages/gesture_recognition)
[![support](https://img.shields.io/badge/platform-flutter%7Cdart%20vm-ff69b4.svg?style=flat-square)](https://pub.dartlang.org/packages/gesture_recognition)

> 一个Flutter编写的手势识别验证锁。

### [中文](https://github.com/flutter-food/gesture_recognition/blob/master/README_ZH.md) [English](https://github.com/flutter-food/gesture_recognition/blob/master/README.md)

![](https://github.com/flutter-food/gesture_recognition/blob/master/img/icon.jpeg?raw=true)

### 引用
```
dependencies:
  gesture_recognition: ^version  
```

### 演示
![](https://github.com/flutter-food/gesture_recognition/blob/master/img/setting.gif?raw=true)
![](https://github.com/flutter-food/gesture_recognition/blob/master/img/verify.gif?raw=true)

### 例子

##### 设置密码例子
```
GestureView(
	immediatelyClear: true,
	size: MediaQuery.of(context).size.width,
	onPanUp: (List<int> items) {
	  setState(() {
	    result = items;
	  });
	},
)
```

##### 验证密码例子
```
GlobalKey<GestureState> gestureStateKey = GlobalKey();

GestureView(
    key: this.gestureStateKey,
    size: MediaQuery.of(context).size.width*0.8,
    selectColor: Colors.blue,
    onPanUp: (List<int> items) {
      analysisGesture(items);
    },
    onPanDown: () {
      gestureStateKey.currentState.selectColor = Colors.blue;
      setState(() {
        status = 0;
      });
    },
)
```

### 参数

| 属性 | 类型 | 描述 | 默认| 必填 |
| ------ | ----------- | ----------- | ----------- | ---- |
| size| double | 组件的大小，宽度等于高度 | | true |
| selectColor | Color | 被选择时的颜色 | Colors.blue | false |
| unSelectColor | Color| 未选择时的颜色 |Colors.grey| false  |
| ringWidth | double | 外圈环的宽度 | 4 | false |,
| ringRadius | double | 外圈环的半径 | 30 | false |,
| showUnSelectRing | bool | 未选择点时是否显示外圈 | true | false |,
| circleRadius | double | 点的内半径 |20| false |,
| lineWidth | double | 连接线的宽度 | 6 | false |
| onPanUp | Function(List<int>) | 手指抬起后回馈 |  | false |
| onPanDown | Function() | 手指按下时回馈 | | false |
| immediatelyClear | bool | 手指抬起后是否清理痕迹 | false| false|