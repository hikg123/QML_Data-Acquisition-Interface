import QtQuick
import QtQuick.Controls

Rectangle{
    id:debug1
    property alias ack: sp
    width:0.808*w.width
    height:392/600*w.height

    Column{
        x:20
        y:20
        spacing:20
        RadioButton{
            id:time
            text:"采集时间"
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
        width: 45
        height: 30
        text: "start"
        clr:hover?"#359f8d":"#333333"
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




