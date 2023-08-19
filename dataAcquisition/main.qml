//在QML中，发出信号是通过将信号作为方法调用来实现的。
//signal send(string val)
//send(27)      //发送信号
//function onSend(val){}    //接受自定义信号
//信号对象有一个connect()方法用来将信号连接到一个方法或信号

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
Window {
    id:w
    visible: true
    width: 1000
    height: 600
    color: "#252929"
    flags: Qt.Window | Qt.FramelessWindowHint

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton
        property point clickPos: "0,0"
        onPressed: {
            clickPos  = Qt.point(mouse.x,mouse.y)
            // 不能mouse.accepted = false
        }
        onPositionChanged: {
            var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)
            w.setX(w.x+delta.x)
            w.setY(w.y+delta.y)
        }
    }

    Connections{
        target:btn_max
        onClicked:{
            if( w.width===1000){
                w.showMaximized()
                

            }
            else{
                w.showNormal()
                
            }
        }
    }



    Column{
        anchors.fill: parent

        Rectangle {
            id: top_btn_rec
            color: "#252929"
            width: parent.width
            height: parent.height/12

            Row{
                anchors.fill: top_btn_rec
                spacing: 0

                Rectangle {
                    width: 0.3*top_btn_rec.width
                    height: top_btn_rec.height
                    Layout.alignment: Qt.AlignHCenter
                    color: "#252929"

                    Image {
                        id: exe_icon
                        anchors.left:parent.left
                        anchors.leftMargin:parent.width/10
                        anchors.verticalCenter: parent.verticalCenter
                        width: 0.072*parent.width
                        height: 0.072*parent.width
                        source: "img/PETDAQ.ico"
                        visible: true
                    }

                    Label {
                        anchors.left: exe_icon.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.leftMargin: 0.08*parent.height
                        text: qsTr("PET数据采集")
                        font.family: "华文行楷"
                        font.pixelSize: 0.2*0.08*w.width
                        font.bold: true
                        color: "#FFFFFF"
                    }

                }
                Rectangle {
                    width: 0.4*top_btn_rec.width
                    height: top_btn_rec.height
                    radius: 6
                    Layout.alignment: Qt.AlignHCenter
                    color: "#505155"

                    MyButton {
                        id: btn_home
                        x:parent.width/10
                        anchors.verticalCenter: parent.verticalCenter
                        text: qsTr("主界面")
                        onClicked:{
//                            ld.source="HomePage1.qml"
                            hp1.visible = true
                            hp2.visible = false
                            hp3.visible = false
                        }
                    }

                    MyButton {
                        id: btn_menu
                        anchors.right: btn_help.left
                        anchors.rightMargin: parent.width/10
                        anchors.verticalCenter: parent.verticalCenter
                        text: qsTr("菜单")
                        onClicked:{
//                            ld.source="HomePage2.qml"
//                            //使用loader会动态创建新的控件，丢失之前操作的数据
                            hp1.visible = false
                            hp2.visible = true
                            hp3.visible = false
                        }
                    }

                    MyButton {
                        id: btn_help
                        anchors.right: parent.right
                        anchors.rightMargin: parent.width/10
                        anchors.verticalCenter: parent.verticalCenter
                        text: qsTr("帮助")
                        onClicked:{
                            hp1.visible = false
                            hp2.visible = false
                            hp3.visible = true
                        }
                    }



                }
                Rectangle {
                   width: 0.3*top_btn_rec.width
                   height: top_btn_rec.height
                   Layout.alignment: Qt.AlignHCenter
                   color: "#252929"

                   MyButton {
                       color: hover ?"#CD5C5C":parent.color
                       id: btn_close
                       width: 0.8*parent.height
                       anchors.verticalCenter: parent.verticalCenter
                       anchors.right: parent.right
                       anchors.rightMargin: 0.4*parent.height
                       text: qsTr("x")
                       onClicked: w.close()
                   }

                   MyButton {
                       id: btn_max
                       width: 0.8*parent.height
                       anchors.verticalCenter: parent.verticalCenter
                       anchors.right: btn_close.left
                       anchors.rightMargin: 0.2*parent.height
                       text: qsTr("口")

                   }

                   MyButton {
                       id: btn_min
                       width: 0.8*parent.height
                       anchors.verticalCenter: parent.verticalCenter
                       anchors.right: btn_max.left
                       anchors.rightMargin: 0.2*parent.height
                       text: qsTr("-")
                       onClicked: w.showMinimized()
                   }
                }

            }
        }
        HomePage1{
            id:hp1 //main只能识别在自己文件中实例化的控件，其他qml文件之间调用则可直接使用id

        }
        HomePage2{
            id:hp2
            visible: false
        }
        HomePage3{
            id:hp3
            visible: false
        }

    }
}

