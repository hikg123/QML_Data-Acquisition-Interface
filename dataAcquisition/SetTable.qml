import QtQuick
import QtQuick.Controls

Rectangle{
    id:rec_s
    width:0.26*w.width
    height:0.26*w.width
    radius:height*0.1
    color: "#a3bed3"
    border.width: 1
    border.color: "#303030"
    property alias ack: btn
    function storeSettings(){}
    Column{
        y:30
        anchors.horizontalCenter: parent.horizontalCenter
        spacing:15
        Label{
            id:find
            text:"查找表类别"
            color: "black"
            font.bold: true
            font.pixelSize: 15

        }
        CheckBox{
            text:"能量查找表"
            id:energy
        }
        CheckBox{
            text:"晶体查找表"
            id:crystal
        }
        CheckBox{
            text:"DOI查找表"
            id:doi
        }
        CheckBox{
            text:"时间查找表"
            id:time
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

