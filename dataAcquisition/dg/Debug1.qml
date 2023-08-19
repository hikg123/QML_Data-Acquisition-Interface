import QtQuick
import QtQuick.Controls
import "../"  //import目录
Rectangle{
    id:debug1
    property alias ack: sp
//    width:0.808*w.width
//    height:392/600*w.height

    Column{
        anchors.centerIn:parent
        anchors.verticalCenterOffset: -50
        anchors.horizontalCenterOffset: -40
        //anchors.horizontalCenterOffset: 20 //水平中心的偏移量,右下为正
        spacing:40
        RadioButton{
            id:time
            text:"采集时间"
            font.pixelSize: 15
            TextField{
                id:inp_time
                anchors.left:time.right
                anchors.verticalCenter: time.verticalCenter
                anchors.leftMargin:6
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



