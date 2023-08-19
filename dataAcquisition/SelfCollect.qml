import QtQuick
import QtQuick.Controls
import Qt.labs.settings 1.0
Rectangle{
    id:rec_s
    width:280
    height:width/2
    radius:height*0.1
    color: "#a3bed3"/*"#c8d2dc"*/
    border.width: 1
    border.color: "#303030"
    property alias ack: btn

    Settings{
        id:settings
        property var time_s //声明,var类型默认是null，int默认是0
        property var num_s
        property var check_time
        property var check_num
        fileName: "E:\\qtProject\\untitled\\settings.ini"
        category: "selfCollect"

    }
    function storeSettings(){
        settings.time_s = inp_time.text //save
        settings.num_s = inp_num.text
        if(time.checked){
            settings.check_time = true
            settings.check_num = false
        }
        else{
            settings.check_time = false
            settings.check_num = true
        }
    }

    Column{
        x:20
        y:20
        spacing:20
        RadioButton{
            id:time
            text:"时间"
            TextField{
                id:inp_time
                text: settings.time_s
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
                text:settings.num_s
                anchors.left:num.right
                anchors.verticalCenter: num.verticalCenter
                anchors.leftMargin:6
                selectByMouse: true
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

//        1. 定义信号： signal sigFunc(type param)进行定义
//        2. 发送信号：sigFunc(实参);
//        3. 接受信号的槽：onSigFunc: { //...; //接收发送过来的参数时，直接用信号定义时的形参param即可 }
//        信号.connect(函数名/信号)

    }
}



