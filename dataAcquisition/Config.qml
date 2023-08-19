import QtQuick
import QtQuick.Controls


Rectangle{
    id: p2
    color:"transparent"
    property string title:"系统调试"
    property Component com1:info_ //组件属性，放在根文件，接收从外面的qml文件传进来的组件
    Rectangle{
        id:titleBar
        gradient: Gradient {

            GradientStop { position: 0; color: "transparent" }
            GradientStop { position: 1; color: "#efe6e6e6" }
        }
        radius:parent.width/100
        anchors.fill:parent
        anchors.leftMargin: 0.006*w.width
        anchors.rightMargin: 0.006*w.width
        anchors.topMargin:0
        anchors.bottomMargin: 478/600*w.height
        ToolButton{
            id: tb
            font.pixelSize:16/820*rightWindow.width
            anchors.verticalCenter:parent.verticalCenter
            text:rightWindow.state==="normal"?"\u25C0":"\u2630"
            onClicked:{
                if(rightWindow.state==="normal"){
                    rightWindow.state="full"

                }
                else{
                    rightWindow.state="normal"
                }
            }

        }
        Label{
            id:lab
            text:sv.currentItem.title
            anchors.centerIn:parent
            font.pixelSize:16/820*rightWindow.width
            font.bold:true
        }


        ComboBox {


            font.pixelSize: (control.hovered ||pop1.opened)?16:14
            font.bold:(control.hovered ||pop1.opened)?true:false
            anchors.left:parent.left
            anchors.leftMargin: (lab.x-control.width-control_2.width)/3
            anchors.verticalCenter: parent.verticalCenter
            id: control
            rightPadding: 8
            implicitWidth:contentItem.implicitWidth + 30//隐式宽度
            height:30
            onHoveredChanged:{//mice进入就打开弹窗,hovered可能是true/false
                if(control.hovered){
                    pop1.open()
                    pop2.close()
                    pop3.close()
                    pop4.close()
                }

            }

            model: ["调试命令","1. 基本信息","2. 基本控制","3. 基本工作模式"]
            indicator: Canvas {
                id: canvas
                x: control.width - width - control.rightPadding
                y: control.topPadding + (control.availableHeight - height) / 2
                width: (control.hovered ||pop1.opened)?12:9
                height: (control.hovered ||pop1.opened)?8:5
                contextType: "2d"
                Connections {
                    target: control
                    function onHoveredChanged() { canvas.requestPaint(); }
                }

                onPaint: {
                    context.reset();
                    context.moveTo(0, 0);
                    context.lineTo(width, 0);
                    context.lineTo(width / 2, height);
                    context.closePath();
                    context.fillStyle = (control.hovered ||pop1.opened) ? "#359f8d" : "#333";
                    context.fill();
                }
            }

            delegate: Rectangle{
                id:rect
                implicitWidth: control.width
                implicitHeight: 30
                color:mouse.containsMouse?"#e5f3ff":"transparent"
                MouseArea{
                    id:mouse
                    anchors.fill:parent
                    hoverEnabled:true
                    onClicked:{
                        control.displayText = txt.text
                        pop1.close()
                    }
                }
                Text{
                    id:txt
                    text: modelData   //即model中的数据
                    color:"black"
//                    elide: Text.ElideRight
                    anchors.centerIn: parent
                }
                required property var modelData


            }
            contentItem: Text { //界面上显示出来的文字
                leftPadding: 5 //左部填充为5

                text: control.displayText //表示ComboBox上显示的文本
                font: control.font    //文字大小
                color: (control.hovered ||pop1.opened)?"#359f8d":"black"   //文字颜色
                verticalAlignment: Text.AlignVCenter  //文字位置
                //elide: Text.ElideRight
            }
            background: Rectangle {   //背景项
                color:"transparent"
            }
            popup: Popup {    //弹出项

                y: control.height
                implicitWidth: control.implicitWidth
                //height: 90
                implicitHeight: contentItem.implicitHeight //contenItem指的是model那些数据
                id:pop1
                //visible: control.hovered || pop1.opened?true:false

                padding: 3
                //istView具有一个模型和一个委托。模型model定义了要显示的数据
                contentItem: ListView {   //界面上显示出来的内容
                    clip: true
                    implicitHeight: contentHeight

                    //若组件没有定义宽高，则该项implicitHeight可以来指定其宽高，隐式尺寸根据内容定义组件的尺寸（默认值是0）。
                    model: control.popup.visible ? control.delegateModel : null
                   // currentIndex: control.highlightedIndex
                    //interactive:false //鼠标拖动页面就不能滑动
                    ScrollIndicator.vertical: ScrollIndicator {

                    }
                }
                background: Rectangle {
                    id:r1
                    color: "#359f8d"
                    Rectangle{
                        anchors.fill: parent
                        anchors.topMargin: 3

                    }
                }
            }
        }

        ComboBox {
            font.pixelSize: (control_2.hovered ||pop2.opened)?16:14
            font.bold:(control_2.hovered ||pop2.opened)?true:false
            anchors.right:lab.left
            anchors.rightMargin: (lab.x-control.width-control_2.width)/3
            anchors.verticalCenter: parent.verticalCenter
            id: control_2
            rightPadding: 8
            implicitWidth:contentItem.implicitWidth + 30//隐式宽度
            height:30
            onHoveredChanged:{//mice进入就打开弹窗
                if(control_2.hovered){
                    pop2.open()
                    pop1.close()
                    pop3.close()
                    pop4.close()
                }


            }
            model: ["配置","查询"]
            indicator: Canvas {
                id: canvas_2
                x: control_2.width - width - control_2.rightPadding
                y: control_2.topPadding + (control_2.availableHeight - height) / 2
                width: (control_2.hovered ||pop2.opened)?12:9
                height: (control_2.hovered ||pop2.opened)?8:5
                contextType: "2d"
                Connections {
                    target: control_2
                    function onHoveredChanged() { canvas_2.requestPaint(); }
                }

                onPaint: {
                    context.reset();
                    context.moveTo(0, 0);
                    context.lineTo(width, 0);
                    context.lineTo(width / 2, height);
                    context.closePath();
                    context.fillStyle = (control_2.hovered ||pop2.opened) ? "#359f8d" : "#333";
                    context.fill();
                }
            }

            delegate: Rectangle{
                id:rect2
                implicitWidth: control_2.width
                implicitHeight: 30
                color:mouse2.containsMouse?"#e5f3ff":"transparent"
                MouseArea{
                    id:mouse2
                    anchors.fill:parent
                    hoverEnabled:true
                    onClicked:{
                        control_2.displayText = txt2.text
                        pop2.close()
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

                text: control_2.displayText //表示ComboBox上显示的文本
                font: control_2.font    //文字大小
                color: (control_2.hovered ||pop2.opened)?"#359f8d":"black"   //文字颜色
                verticalAlignment: Text.AlignVCenter  //文字位置
                //elide: Text.ElideRight
            }
            background: Rectangle {   //背景项
                color:"transparent"
            }
            popup: Popup {    //弹出项

                y: control_2.height
                implicitWidth: control_2.implicitWidth
                //height: 90
                implicitHeight: contentItem.implicitHeight //contenItem指的是model那些数据
                id:pop2
                //visible: (control_2.hovered ||pop2.opened)? true:false
                padding: 3
                //istView具有一个模型和一个委托。模型model定义了要显示的数据
                contentItem: ListView {   //界面上显示出来的内容
                    clip: true
                    implicitHeight: contentHeight

                    //若组件没有定义宽高，则该项implicitHeight可以来指定其宽高，隐式尺寸根据内容定义组件的尺寸（默认值是0）。
                    model: control_2.popup.visible ? control_2.delegateModel : null
                   // currentIndex: control.highlightedIndex
                    //interactive:false //鼠标拖动页面就不能滑动
                    ScrollIndicator.vertical: ScrollIndicator {

                    }
                }
                background: Rectangle {
                    id:r2
                    color: "#359f8d"
                    implicitWidth:pop2.width
                    implicitHeight: pop2.height
                    Rectangle{
                        anchors.fill: parent
                        anchors.topMargin: 3

                    }
                }
            }
        }

        ComboBox {
            font.pixelSize: (control_3.hovered ||pop3.opened)?16:14
            font.bold:(control_3.hovered ||pop3.opened)?true:false
            anchors.left:lab.right
            anchors.leftMargin: (lab.x-control_3.width-control_4.width)/3
            anchors.verticalCenter: parent.verticalCenter
            id: control_3
            rightPadding: 8
            implicitWidth:contentItem.implicitWidth + 30//隐式宽度
            height:30
            onHoveredChanged:{//mice进入就打开弹窗
                if(control_3.hovered){
                    pop3.open()
                    pop1.close()
                    pop2.close()
                    pop4.close()
                }


            }
            model: ["Block1","Block2","Block3","Block4"]
            indicator: Canvas {
                id: canvas_3
                x: control_3.width - width - control_3.rightPadding
                y: control_3.topPadding + (control_3.availableHeight - height) / 2
                width: (control_3.hovered ||pop3.opened)?12:9
                height: (control_3.hovered ||pop3.opened)?8:5
                contextType: "2d"
                Connections {
                    target: control_3
                    function onHoveredChanged() { canvas_3.requestPaint(); }
                }

                onPaint: {
                    context.reset();
                    context.moveTo(0, 0);
                    context.lineTo(width, 0);
                    context.lineTo(width / 2, height);
                    context.closePath();
                    context.fillStyle = (control_3.hovered ||pop3.opened)? "#359f8d" : "#333";
                    context.fill();
                }
            }

            delegate: Rectangle{
                id:rect3
                implicitWidth: control_3.width
                implicitHeight: 30
                color:mouse3.containsMouse?"#e5f3ff":"transparent"
                MouseArea{
                    id:mouse3
                    anchors.fill:parent
                    hoverEnabled:true
                    onClicked:{
                        control_3.displayText = txt3.text
                        pop3.close()
                    }
                }
                Text{
                    id:txt3
                    text: modelData   //即model中的数据
                    color:"black"
//                    elide: Text.ElideRight
                    anchors.centerIn: parent
                }
                required property var modelData


            }
            contentItem: Text { //界面上显示出来的文字
                leftPadding: 5 //左部填充为5

                text: control_3.displayText //表示ComboBox上显示的文本
                font: control_3.font    //文字大小
                color: (control_3.hovered ||pop3.opened)?"#359f8d":"black"   //文字颜色
                verticalAlignment: Text.AlignVCenter  //文字位置
                //elide: Text.ElideRight
            }
            background: Rectangle {   //背景项
                color:"transparent"
            }
            popup: Popup {    //弹出项
                y: control_3.height
                implicitWidth: control_3.implicitWidth
                //height: 90
                implicitHeight: contentItem.implicitHeight //contenItem指的是model那些数据
                id:pop3
                //visible: (control_3.hovered ||pop3.opened)? true:false
                padding: 3
                //istView具有一个模型和一个委托。模型model定义了要显示的数据
                contentItem: ListView {   //界面上显示出来的内容
                    clip: true
                    implicitHeight: contentHeight

                    //若组件没有定义宽高，则该项implicitHeight可以来指定其宽高，隐式尺寸根据内容定义组件的尺寸（默认值是0）。
                    model: control_3.popup.visible ? control_3.delegateModel : null
                   // currentIndex: control.highlightedIndex
                    //interactive:false //鼠标拖动页面就不能滑动
                    ScrollIndicator.vertical: ScrollIndicator {

                    }
                }
                background: Rectangle {
                    color: "#359f8d"
                    Rectangle{
                        anchors.fill: parent
                        anchors.topMargin: 3

                    }
                }
            }
        }
        ComboBox {
            font.pixelSize: (control_4.hovered ||pop4.opened)?16:14
            font.bold:(control_4.hovered ||pop4.opened)?true:false
            anchors.right:parent.right
            anchors.rightMargin: (lab.x-control_3.width-control_4.width)/3
            anchors.verticalCenter: parent.verticalCenter
            id: control_4
            rightPadding: 8
            implicitWidth:contentItem.implicitWidth + 30//隐式宽度
            height:30
            onHoveredChanged:{//mice进入就打开弹窗
                if(control_4.hovered){
                    pop4.open()
                    pop1.close()
                    pop3.close()
                    pop2.close()
                }


            }
            model:12
            indicator: Canvas {
                id: canvas_4
                x: control_4.width - width - control_4.rightPadding
                y: control_4.topPadding + (control_4.availableHeight - height) / 2
                width: (control_4.hovered ||pop4.opened)?12:9
                height: (control_4.hovered ||pop4.opened)?8:5
                contextType: "2d"
                Connections {
                    target: control_4
                    function onHoveredChanged() { canvas_4.requestPaint(); }
                }

                onPaint: {
                    context.reset();
                    context.moveTo(0, 0);
                    context.lineTo(width, 0);
                    context.lineTo(width / 2, height);
                    context.closePath();
                    context.fillStyle = (control_4.hovered ||pop4.opened)? "#359f8d" : "#333";
                    context.fill();
                }
            }

            delegate: Rectangle{
                id:rect4
                implicitWidth: control_4.width
                implicitHeight: 30
                color:mouse4.containsMouse?"#e5f3ff":"transparent"
                MouseArea{
                    id:mouse4
                    anchors.fill:parent
                    hoverEnabled:true
                    onClicked:{
                        tt.text = txt4.text
                        pop4.close()
                    }
                }
                Text{
                    id:txt4
                    text: "SPU"+(index+1)  //即model中的数据
                    color:"black"
//                    elide: Text.ElideRight
                    anchors.centerIn: parent
                }
                required property var modelData
                required property int index


            }
            contentItem: Text { //界面上显示出来的文字
                id:tt
                leftPadding: 5 //左部填充为5
                text: "SPU"+(Number(control_4.displayText)+1) //表示ComboBox上显示的文本
                //text: control_4.displayText //表示ComboBox上显示的文本
                font: control_4.font    //文字大小
                color: (control_4.hovered ||pop4.opened)?"#359f8d":"black"   //文字颜色
                verticalAlignment: Text.AlignVCenter  //文字位置
                //elide: Text.ElideRight
            }
            background: Rectangle {   //背景项
                color:"transparent"
            }
            popup: Popup {    //弹出项
                y: control_4.height
                implicitWidth: control_4.implicitWidth
                //height: 90
                implicitHeight: contentItem.implicitHeight //contenItem指的是model那些数据
                id:pop4
                //visible: (control_4.hovered ||pop4.opened)? true:false
                padding: 3
                //istView具有一个模型和一个委托。模型model定义了要显示的数据
                contentItem: ListView {   //界面上显示出来的内容
                    clip: true
                    implicitHeight: contentHeight

                    //若组件没有定义宽高，则该项implicitHeight可以来指定其宽高，隐式尺寸根据内容定义组件的尺寸（默认值是0）。
                    model: control_4.popup.visible ? control_4.delegateModel : null
                   // currentIndex: control.highlightedIndex
                    //interactive:false //鼠标拖动页面就不能滑动
                    ScrollIndicator.vertical: ScrollIndicator {

                    }
                }
                background: Rectangle {
                    color: "#359f8d"
                    Rectangle{
                        anchors.fill: parent
                        anchors.topMargin: 3

                    }
                }
            }
        }
    }

    Rectangle{
        id:rootWindow
        color:"white"
        radius: parent.width/100
        anchors.top:titleBar.bottom
        anchors.topMargin: 1/600*w.height
        anchors.left: parent.left
        anchors.leftMargin: 0.006*w.width
        anchors.right: parent.right
        anchors.rightMargin: 0.006*w.width
        width:0.808*w.width //所看到的视图宽高
        height:392/600*w.height
        Loader{
            id:lod_1
            anchors.fill:parent
            source:(control.displayText==="1. 基本信息")&&(control_2.displayText==="配置")?"dg/Debug1.qml":""

        }
        Loader{
            id:lod_2
            anchors.fill:parent
            source:(control.displayText==="2. 基本控制")&&(control_2.displayText==="配置")?"dg/Debug2.qml":""

        }
    }
    Rectangle{
        visible: true
        radius: parent.width/100
        id:stateBar_mask
        anchors.fill: parent
        anchors.bottomMargin: 0.02*w.height
        anchors.topMargin: rightWindow.height-0.084*w.width
        anchors.leftMargin: 0.006*w.width
        anchors.rightMargin: 0.006*w.width
        gradient: Gradient {
            GradientStop { position: 0; color: "#efffffff" }
            GradientStop { position: 1; color: "#efe6e6e6" }
        }

        Row{

            y:20/820*rightWindow.width
            anchors.horizontalCenter: parent.horizontalCenter//水平线中心的定位
            //anchors.horizontalCenterOffset: 20 //水平中心的偏移量,右下为正
            spacing:10/820*rightWindow.width
            Repeater{
                model:12
                CheckBox{//省略了 delegate
                    text:"SPU"+(index+1)

                }
            }
            CheckBox{
                text:"CPU"
                id:cpu

            }

        }
        Component{
            id:info_
            Label{
                id:label_
                text:"等待采集数据"

            }

        }



        Loader{//占位符
            id:loader_info
            sourceComponent:com1 //组件从外面的qml文件传进来
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 6
            anchors.right: parent.right
            anchors.rightMargin: 0.015*w.width

        }
    }

}




