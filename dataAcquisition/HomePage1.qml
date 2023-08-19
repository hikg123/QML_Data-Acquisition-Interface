import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Rectangle {
    id: homePage1
    //color: list.color
    color:"transparent"
    width: w.width
    height: w.height-w.height/12
    Image{
        anchors.fill:parent
        //fillMode:Image.PreserveAspectFit
        source:"img/background.png"

    }
    Rectangle {
        id: leftWindow
        //color: "#505155"
        color:"transparent"
        opacity:1
        anchors.left:parent.left
        anchors.right:rightWindow.left
        anchors.top:parent.top
        anchors.bottom:parent.bottom


        Rectangle{
            id:list
            anchors.top:parent.top
            anchors.topMargin: 12/600*w.height
            anchors.left: parent.left
            anchors.leftMargin: parent.width/15
            anchors.right:parent.right
            // anchors.rightMargin:parent.width/60
            anchors.bottom:parent.bottom
            anchors.bottomMargin:12/600*w.height
            //color: "transparent"
            //color:"white"
            color:"#a3bed3"
            border.color: Qt.lighter("#C0C0C0",0.9)
            gradient: Gradient{
                GradientStop{position:0;color: "#a3bed3"}//从上到下颜色渐变
                GradientStop{position:1;color: "#ffffff"}
            }
            border.width: parent.width/180
            radius: parent.width/45
            ListView{
                id:lv
                property double ratio:ratio=0.006
                anchors.fill:parent
                anchors.topMargin:60/600*w.height
                anchors.leftMargin:ratio*w.width
                anchors.rightMargin:ratio*w.width
                spacing:1/600*w.height
                model: lm
                delegate:com
            }
            ListModel{
                id:lm
                ListElement{
                    name:"数据采集"
                    imageSource:"img/mode.ico"
                }
                ListElement{
                    name:"系统调试"
                    imageSource:"img/para.ico"
                }
            }

            Component{
                id: com
                Rectangle{
                    id:item
                    required property int index
                    required property string name
                    required property string imageSource
                    width:lv.width
                    height:40/600*w.height
                    radius:0.005*w.width
                    color: mouse.containsMouse?"lightblue":"transparent"
                    Rectangle{
                        id:img
                        width:0.6*parent.height
                        height:0.6*parent.height
                        anchors.top:parent.top
                        anchors.left:parent.left
                        anchors.topMargin: mouse.containsMouse?5/600*w.height:8/600*w.height
                        anchors.leftMargin: 0.01*w.width
                        color:"#f0ffff"
                        Image{
                            anchors.fill:parent
                            fillMode:Image.PreserveAspectFit
                            source:item.imageSource
                        }

                    }

                    Label{
                        anchors.left:img.right
                        anchors.leftMargin:0.004*w.width
                        anchors.verticalCenter:parent.verticalCenter
                        text:item.name
                        color: mouse.containsMouse?"#3d59ad":"black"
                        font.pixelSize: 0.4*parent.height
                        font.bold: mouse.containsMouse
                    }
                    MouseArea{
                        id:mouse
                        anchors.fill:parent
                        hoverEnabled:true
                        onClicked:{

                            sa.start()

                            if(item.index==0){

                                if(sv.currentItem!==sv.initialItem){//栈顶不是初始页，无参调用pop时，将栈顶的页面弹出
                                    sv.pop()
                                }
                                //栈顶是初始页，什么也不用做
                                //console.log("1--",sv.depth)

                            }
                            else{

                                //console.log("2--",sv.depth)
                                if(sv.depth<2){
                                    sv.push("Config.qml") //栈只有初始页，才允许入栈
                                }

                                //console.log("3--",sv.depth)

                            }


                        }

                    }
                    SequentialAnimation{
                        id:sa
                        property int duration:100
                        ParallelAnimation{
                            PropertyAnimation{
                                target:item
                                properties:"color"
                                to:"lightblue"
                                duration:sa.duration
                            }
                            NumberAnimation{
                                target:item
                                properties:"scale"
                                from:1
                                to:0.7
                                duration:sa.duration
                                easing.type:Easing.InOutQuad
                            }
                        }
                        NumberAnimation{
                            duration:50
                        }

                        ParallelAnimation{

                            PropertyAnimation{
                                target:item
                                properties:"color"
                                to:"lightblue"
                                duration:sa.duration
                            }
                            NumberAnimation{
                                target:item
                                properties:"scale"
                                from:0.7
                                to:1
                                duration:sa.duration
                                easing.type:Easing.InOutQuad
                            }
                        }
                    }

                }
            }
        }

    }

    Rectangle{
        id: rightWindow
        //color:"#f0f4f5"
        color:"transparent"
        anchors.fill: parent
        anchors.leftMargin: 0.18*w.width
        Behavior on anchors.leftMargin{
            NumberAnimation{
                duration:300
            }
        }
        state:"normal"
        states:[
            State{
                name:"normal"
                PropertyChanges{
                    target:rightWindow
                    anchors.leftMargin:0.18*w.width

                }
            },
            State{
                name:"full"
                PropertyChanges{
                    target:rightWindow
                    anchors.leftMargin:0
                }
            }

        ]
        StackView{
            id:sv
            anchors.fill:parent
            initialItem:Home{}
            property int time: 10
            pushEnter: Transition {
                PropertyAnimation {
                    property: "opacity"
                    from: 0
                    to:1
                    duration: time
                }
            }
            pushExit: Transition {
                PropertyAnimation {
                    property: "opacity"
                    from: 1
                    to:0
                    duration: time
                }
            }
            popEnter: Transition {
                PropertyAnimation {
                    property: "opacity"
                    from: 0
                    to:1
                    duration: time
                }
            }
            popExit: Transition {
                PropertyAnimation {
                    property: "opacity"
                    from: 1
                    to:0
                    duration: time
                }
            }
        }

    }

}




