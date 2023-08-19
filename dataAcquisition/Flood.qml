import QtQuick
import QtQuick.Controls

Rectangle{
    width:0.330*w.width
    height:0.200*w.width
    radius:height*0.1
    color: "#a3bed3"/*"#dcc390"*/
    border.width: 1
    border.color: "#303030"
    property alias ack: btn

    function storeSettings(){}
    Column{
        x:20
        y:20
        spacing:20
        Row{
            spacing:6
            Label{
                id:mode
                text:"能量测量模式:"
            }
            Rectangle{
                width:100
                height:20
                anchors.verticalCenter: mode.verticalCenter

                Text{
                    text:"38"
                    color:"#999999"
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
            ComboBox{

                //displayText:"数字求和点数"
                anchors.verticalCenter: mode.verticalCenter
                contentItem: Text { //界面上显示出来的文字
                    color: "#999999"    //文字颜色
                    text: "数字求和点数"
                    verticalAlignment: Text.AlignVCenter  //文字位置
                    elide: Text.ElideRight
                }
            }

        }
        Row{
            spacing:6
            Label{
                id:mode1
                text:"多点求和权重模式:"
            }
            Rectangle{
                width:100
                height:20
                anchors.verticalCenter: mode1.verticalCenter
                Text{
                    text:"00"
                    color:"#999999"
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

        }
        Row{
            spacing:6
            Label{
                id:mode2
                text:"SPU位置计算方法:"
            }
//            ComboBox{
//                displayText:"先求两侧位置再平均"
//                anchors.verticalCenter: mode2.verticalCenter
//            }
            ComboBox {
                anchors.verticalCenter: mode2.verticalCenter
                id: control
                model: ["先求两侧位置再平均", "两侧能量相加后直接求位置"]
                delegate: ItemDelegate { //控制单个项(每个model，上面是两个)的绘制
                    width: control.width
                    contentItem: Text {
                        text: modelData   //即model中的数据
                        color:"black"   //弹窗里文字的颜色
                        font: control.font
                        elide: Text.ElideRight
                        verticalAlignment: Text.AlignVCenter
                    }
                    highlighted: control.highlightedIndex === index
                    required property int index
                    required property var modelData


                }
                contentItem: Text { //界面上显示出来的文字
                    leftPadding: 5 //左部填充为5
                    text: control.displayText //表示ComboBox上显示的文本
                    font: control.font    //文字大小
                    color: control.pressed ? "#dcc390" : "black"   //文字颜色
                    verticalAlignment: Text.AlignVCenter  //文字位置
                    //elide: Text.ElideRight
                }
                background: Rectangle {   //背景项
                    implicitWidth: 0.1*w.width  //可根据里面文本内容动态调整
                    implicitHeight: 0.020*w.width
                    border.width: 1
                    radius: 2
                }
                popup: Popup {    //弹出项
                    y: control.height
                    width: control.width
                    implicitHeight: contentItem.implicitHeight //contenItem指的是model那些数据

                    padding: 1
                    //istView具有一个模型和一个委托。模型model定义了要显示的数据
                    contentItem: ListView {   //界面上显示出来的内容
                        clip: true
                        implicitHeight: contentHeight

                        model: control.popup.visible ? control.delegateModel : null
                       // currentIndex: control.highlightedIndex
                        //interactive:false //鼠标拖动页面就不能滑动
                        ScrollIndicator.vertical: ScrollIndicator {

                        }
                    }
                    background: Rectangle {

                        radius: 2
                    }
                }
            }

        }



    }
    MyButton{
        id:btn
        text: "确定"
        clr:"#333333"
        font:"宋体"
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width/5
        height: width/2
        size:13
        border.width: 1
        border.color: "#303030"
        radius:height*0.1
        color:hover?"#ffb24d":parent.color

    }
}

