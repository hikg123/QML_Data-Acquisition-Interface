import QtQuick
import QtQuick.Controls
import "../"  //import目录
Rectangle{
    id:debug1
    property alias ack: sp
    width:0.808*w.width
    height:392/600*w.height
    Row{//给定x,y,spacing
        x: 0.808*w.width/7
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -40
        spacing:130
        Column{
            spacing:40
            Row{
                spacing:6
                RadioButton{
                    id:time
                    text:"采集时间"
                    font.pixelSize: 15

                }
                TextField{
                    id:inp_time
                    width:173
                    selectByMouse: true
                }
            }


            RadioButton{
                id:num
                text:"采集数据包个数"
                font.pixelSize: 15
                TextField{
                    id:inp_num
                    anchors.left:num.right
                    anchors.verticalCenter: num.verticalCenter
                    anchors.leftMargin:6
                    selectByMouse: true
                }
            }
        }
        Column{
            spacing:40
            Row{
                spacing:6
                CheckBox{
                    text:"子模块"
                    font.pixelSize: 15
                    id:sub
                }
                TextField{
                    id:submodule
                    width:120
                    cursorVisible: true;
                    text:"00"
                    selectByMouse: true
                }
            }
            ComboBox {
                font.pixelSize: 15
                font.bold:(control_set.hovered ||pop_set.opened)?true:false
                id: control_set
                rightPadding: 8
                implicitWidth:contentItem.implicitWidth + 30//隐式宽度
                height:30

                model: ["复位","启动","停止"]
                indicator: Canvas {
                    id: canvas_set
                    x: control_set.width - width - control_set.rightPadding
                    y: control_set.topPadding + (control_set.availableHeight - height) / 2
                    width: (control_set.hovered ||pop_set.opened)?12:9
                    height: (control_set.hovered ||pop_set.opened)?8:5
                    contextType: "2d"
                    Connections {
                        target: control_set
                        function onHoveredChanged() { canvas_set.requestPaint(); }
                    }

                    onPaint: {
                        context.reset();
                        context.moveTo(0, 0);
                        context.lineTo(width, 0);
                        context.lineTo(width / 2, height);
                        context.closePath();
                        context.fillStyle = (control_set.hovered ||pop_set.opened) ? "#359f8d" : "#333";
                        context.fill();
                    }
                }

                delegate: Rectangle{
                    id:rect2
                    implicitWidth: control_set.width
                    implicitHeight: 30
                    color:mouse2.containsMouse?"#e5f3ff":"transparent"
                    MouseArea{
                        id:mouse2
                        anchors.fill:parent
                        hoverEnabled:true
                        onClicked:{
                            control_set.displayText = txt2.text
                            pop_set.close()
                        }
                    }
                    Text{
                        id:txt2
                        text: modelData   //即model中的数据
                        color:"black"
    //                    elide: Text.ElideRight
                        anchors.centerIn: parent
                    }
                    required property var modelData


                }
                contentItem: Text { //界面上显示出来的文字
                    leftPadding: 5 //左部填充为5

                    text: control_set.displayText //表示ComboBox上显示的文本
                    font: control_set.font    //文字大小
                    color: (control_set.hovered ||pop_set.opened)?"#359f8d":"black"   //文字颜色
                    verticalAlignment: Text.AlignVCenter  //文字位置
                    //elide: Text.ElideRight
                }
                background: Rectangle {   //背景项
                    color:"transparent"
                }
                popup: Popup {    //弹出项
                    y: control_set.height
                    implicitWidth: control_set.implicitWidth
                    //height: 90
                    implicitHeight: contentItem.implicitHeight //contenItem指的是model那些数据
                    id:pop_set
                    visible: (control_set.hovered ||pop_set.opened)? true:false
                    padding: 3
                    //istView具有一个模型和一个委托。模型model定义了要显示的数据
                    contentItem: ListView {   //界面上显示出来的内容
                        clip: true
                        implicitHeight: contentHeight
                        //若组件没有定义宽高，则该项implicitHeight可以来指定其宽高，隐式尺寸根据内容定义组件的尺寸（默认值是0）。
                        model: control_set.popup.visible ? control_set.delegateModel : null
                       // currentIndex: control.highlightedIndex
                        //interactive:false //鼠标拖动页面就不能滑动
                        ScrollIndicator.vertical: ScrollIndicator {

                        }
                    }
                    background: Rectangle {
                        id:r2
                        border.color: "#359f8d"
                        border.width: 0.5

                    }
                }
            }



        }
    }



    MyButton{
        id:sp
        width: 50
        height: 30
        text: "start"
        //font.pixelSize: 15
        clr:"#333333"
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        //color:hover?"#ffb24d":"transparent"
        color:"#ffb24d"
        onClicked:{
            if(text === "start"){
                text = "pause"
            }
            else{
                text = "start"
            }
        }

    }
}




