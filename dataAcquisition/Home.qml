import QtQuick
import QtQuick.Controls
import Qt.labs.platform
import org.fileio 1.0
import Qt.labs.settings 1.0
//rightWindow
Rectangle{
    id: p1
    color:"transparent"
    property string title:"数据采集"
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

        property bool isOpen : leftWindow.anchors.rightMargin>0.82*w.width?false:true
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
            text:sv.currentItem.title
            anchors.centerIn:parent
            font.pixelSize:16/820*rightWindow.width
            font.bold:true
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
        height:465/600*w.height
        function showPopupBottom(raiseItem) {
            popupBottom.raiseItem = raiseItem
            popupBottom.open()
        }
        FileDialog {
            id: fileDialog
            title:"选择文件"
            acceptLabel: "确定"
            rejectLabel: "取消"
            folder: StandardPaths.standardLocations(StandardPaths.DesktopLocation)[0]

            onFileChanged: {

                fileIO.file_source = fileDialog.file
                fileIO.read()
            }
            Component.onCompleted: {

            }
            onAccepted:{//选择了确定按钮，触发accepted信号
                console.log("file: ",fileDialog.file)//选择的文件路径
            }

        }
        FileIO{
            id:fileIO
        }
        Popup {
            id: popupBottom
            modal:true        //模态， 为 true后弹出窗口会叠加一个独特的背景调光效果
            focus:true        //焦点,  当弹出窗口实际接收到焦点时，activeFocus将为真
            closePolicy:Popup.CloseOnEscape | Popup.CloseOnPressOutside
            padding:0           //很重要
            property var raiseItem: null  //要显示的组件qml


            background: Rectangle {
                color: Qt.rgba(0,0,0,0)    //背景为无色
            }
            Loader {
                id: loaderBottom
                onLoaded: {

                    popupBottom.x = (rootWindow.width-popupBottom.width)/2
                    popupBottom.y = (rootWindow.height-popupBottom.height)/2


                }
            }
            Connections{
                target: loaderBottom.item.ack
                onClicked:{

                    loaderBottom.item.storeSettings()
                    popupBottom.close()
                }
            }

            onOpened: {
                loaderBottom.source = popupBottom.raiseItem
            }
            onClosed: {
                loaderBottom.source = null
                popupBottom.raiseItem = null
            }
        }

        Flickable {
            id: flick
            clip:true //不用全屏的子组件，我们应该设置clip属性为真
            anchors.fill: parent
            ScrollBar.vertical: ScrollBar{}
            contentWidth:rectRoot.width //要展示的内容宽高
            contentHeight:rectRoot.height
            Rectangle{
                id: rectRoot
                width: parent.width
                anchors.top: parent.top
                anchors.topMargin: 0.007*w.width
                height: w.width
                Component{//大量的重复组件可用
                    id:com_1
                    Rectangle{
                        id:rec_1
                        //color:"pink"
                        width:rightWindow.width-10/808*rightWindow.width
                        //implicitWidth:rightWindow.width-0.01*w.width
                        height:0.43*465/600*w.height-0.025*w.width
                        property alias title: label_1.text
                        property alias picture: img_11.source
                        property alias text: lab.text
                        //property alias textBox: file.visible
                        property alias hoverText:control_12.text
                        property alias btnText:control_11.text
                        property alias btn:control_11
                        property alias hideBtn:control_12
                        property alias isReady: canvas.isReady
                        property alias otp: outer.anchors.topMargin
                        property alias inner_box: inner
                        property string name
                        Label{
                            color:"#34495e"
                            id:label_1
                            text:"新建文件"
                            font.pixelSize:0.016*w.width
                        }
                        Canvas{
                            id: canvas
                            width: parent.width
                            height: parent.height
                            anchors.top: label_1.bottom
                            anchors.topMargin: 0.003*w.width
                            property bool isReady: true
                            onPaint: {
                                if(isReady){
                                    var ctx = getContext("2d");
                                    draw(ctx);
                                }
                            }
                            function draw(ctx ) {
                                // 画之前清空画布
                                //ctx.fillStyle = "blue";	//设置画刷颜色
                                //ctx.rect(100,80,120,80);	//绘制一个矩形
                                //ctx.fill();	//使用画刷颜色填充矩形
                                ctx.clearRect(0, 0, parent.width, parent.height);
                                ctx.strokeStyle = "red"; //画笔
                                ctx.lineWidth = 2.6 //画笔线宽
                                ctx.beginPath();                  // 开始一条路径
                                ctx.moveTo(0, 0);         // 移动到指定位置
                                ctx.lineTo(label_1.width, 0);
                                ctx.stroke();  //画笔绘制图形轮廓

                                ctx.beginPath();
                                ctx.moveTo(label_1.width, 0);
                                ctx.lineTo(parent.width, 0);
                                ctx.lineWidth = 1
                                ctx.strokeStyle = "#bbb";
                                ctx.stroke();
                            }
                        }

                        Rectangle {
                            anchors.top:rec_1.top
                            //anchors.topMargin:0.035*w.width
                            anchors.topMargin:40
                            id:outer
                            radius:0.005*w.width
                            width:808/820*rightWindow.width/3.2
                            height:465/600*w.height/3.5
                            gradient: Gradient{
                                GradientStop{position:0.9;color: "#c5c5c5"}//从上到下颜色渐变
                                GradientStop{position:1;color: "#efefef"}
                            }
                            Rectangle{
                                id:inner
                                anchors.fill: parent
                                anchors.leftMargin: 0.001*w.width
                                anchors.rightMargin: 0.001*w.width
                                anchors.bottomMargin: 0.005*w.width
                                color: "#f6f6f6"
                                radius:0.005*w.width
                                signal clicked
                                Rectangle{
                                    width: 0.06*w.width;height: 0.06*w.width
                                    x:0.025*w.width
                                    anchors.verticalCenter:parent.verticalCenter
                                    id:img_1
                                    Image {
                                        id:img_11
                                        anchors.fill: parent
                                        source: "img/cat.png"
                                    }
                                }
                                //states:[//[]多种状态，{}一个类表示一种状态
                                states:State{//当when为false，恢复为原状态，原状态为有阴影
                                    when: !mouse.containsMouse
                                    name:"mouse_out"
                                    PropertyChanges{//切换状态
                                        target:outer;gradient:Gradient
                                    }

                                }
                                Label{
                                    id:lab
                                    anchors.fill: parent
                                    anchors.leftMargin: img_1.width+0.006*w.width+img_1.x
                                    anchors.topMargin: 0.019*w.width
                                    text:"新建文件"
                                    color: mouse.containsMouse?"#ff7e75":"black"
                                    font.pixelSize: 0.012*w.width
                                    font.bold: mouse.containsMouse
                                }
                                MyButton {
                                    z:1  //x,y,z相对于父控件的定位,使按钮不冲突
                                    height:0.020*w.width
                                    width:0.020*w.width
                                    radius:control_11.height/2    //圆形
                                    opacity: mouse.containsMouse?1:0.3
                                    color:hover?"gray":parent.color
                                    id: control_11
                                    border.color:mouse.containsMouse ?"black":Qt.lighter(parent.color,0.2)
                                    clr: mouse.containsMouse ?"black":Qt.lighter(parent.color,0.2)
                                    anchors.right: parent.right
                                    anchors.rightMargin: 0.006*w.width
                                    size:0.014*w.width
                                    anchors.verticalCenter:parent.verticalCenter
                                    text:qsTr(">")
                                    //onClicked:{console.log("bbb")}
                                }
                                MyButton {//提示框
                                    visible:control_11.hover?true:false
                                    height:0.028*w.width
                                    width:0.054*w.width
                                    radius:0.003*w.width
                                    color:"black"
                                    id: control_12
                                    clr: "white"
                                    anchors.right: control_11.left
                                    anchors.rightMargin: 0.006*w.width
                                    size:0.012*w.width
                                    anchors.verticalCenter:parent.verticalCenter
                                    text:qsTr("输入文件")
                                }
//                                TextField{
//                                    visible: true
//                                    z:1
//                                    id:file
//                                    placeholderText: "输入文件名"
//                                    anchors.left: img_1.right
//                                    anchors.leftMargin: 0.006*w.width
//                                    anchors.bottom: parent.bottom
//                                    anchors.bottomMargin:0.02*w.width
//                                    cursorVisible: true;
//                                    hoverEnabled:true //接受悬停
//                                    background: Rectangle{
//                                        opacity: file.hovered?1:0.3
//                                        implicitWidth: 0.1*w.width
//                                        implicitHeight: 0.02*w.width
//                                        color:file.hovered?"#efefef":"#f6f6f6"
//                                        border.color:file.hovered?"black":Qt.lighter("#f6f6f6",0.2)
//                                    }
//                                }
                                MouseArea{
                                    id:mouse
                                    anchors.fill:parent
                                    hoverEnabled:true
                                    onClicked: {
                                        inner.clicked()
                                    }
                                }

                            }
                        }

                    }
                }

                Loader{//属性item：保存当前加载的根对象，上面的rec_1,Loader 可以加载 QML 文件（使用 source 属性）或 Component 对象（使用 sourceComponent 属性）
                    id:loader_1   //组件动态销毁（点按钮）,loader_1.sourceComponent=null
                    sourceComponent: com_1
                    //若要用anchors.fill: parent则必须指定anchors.topMargin等四个位置，默认与父控件一致

                    y: 1/60*w.height
                    x: 10/808*rightWindow.width
                    //source:"Mode.qml"
                    onLoaded:{
                        //item.color="gray"
                        //item.textBox=false
                    }
                }
                Connections{
                    target: loader_1.item.btn
                    onClicked:{
                        fileDialog.open()

                    }
                }


                Loader{//属性item：保存当前加载的根对象，上面的rec_1
                    id:loader_2
                    sourceComponent: com_1
                    y: 2/60*w.height+item.height
                    x: 10/808*rightWindow.width

                    onLoaded: {//加载完成后
                        item.title="采集参数"
                        item.text="自动采集"
                        item.picture="img/colect_auto.png"
                        //item.textBox=false
                        item.hoverText="勾选"
                        item.btnText=""
                        //item.color="orange"
                    }

                }
                Connections{
                    target: loader_2.item.btn
                    onClicked:{
                        if(!loader_2.item.btn.text)
                            loader_2.item.btn.text ="\u2714"
                        else
                            loader_2.item.btn.text=""
                    }
                }
                Loader{//属性item：保存当前加载的根对象，上面的rec_1
                    id:loader_3
                    sourceComponent: com_1
                    y: 2/60*w.height+item.height
                    x: 10/808*rightWindow.width+item.width/3.08
                    onLoaded: {//加载完成后
                        item.title=""
                        item.text="自定义采集"
                        item.picture="img/colect_self.png"
                        //item.textBox=false
                        item.hoverText="设置"
                        //item.color="gray"
                    }
                }
                Connections{
                    target: loader_3.item.btn
                    onClicked:{
                        rootWindow.showPopupBottom("SelfCollect.qml")
                    }
                }

                Loader{//属性item：保存当前加载的根对象，上面的rec_1
                    id:loader_4
                    sourceComponent: com_1
                    y: 3/60*w.height+item.height*2
                    x: 10/808*rightWindow.width
                    //anchors.bottomMargin: pageWindow.height*0.1
                    onLoaded: {//加载完成后
                        item.title="配置查找表"
                        item.text="配置查找表"
                        item.picture="img/set.png"
                        //item.textBox=false
                        item.hoverText="配置"

                        //item.color="gray"
                    }

                }
                Connections{
                    target: loader_4.item.btn
                    onClicked:{
                        rootWindow.showPopupBottom("SetTable.qml")
                    }
                }
                Loader{
                    id:loader_5
                    sourceComponent: com_1
                    y: 4/60*w.height+item.height*3
                    x: 10/808*rightWindow.width
                    onLoaded: {//加载完成后
                        item.title="数据采集模式/进度"
                        item.text="Flood数据采集模式"
                        item.picture="img/flood.ico"
                        //item.textBox=false
                        item.hoverText="设置"
                        item.name = "flood"
                        //item.color="orange"
                    }
                    Component{
                        id:info_5
                        Label{
                            //color:"#34495e"
                            id:label_1
                            text:cProgress.progress > 100?"采集完成":"正在采集"+loader_5.item.name+"数据..."
                            //font.pixelSize:0.016*w.width

                        }

                    }
                }
                Connections{
                    target: loader_5.item.btn
                    onClicked:{
                        rootWindow.showPopupBottom("Flood.qml")
                    }
                }


                Connections{
                    target: loader_5.item.inner_box
                    onClicked:{
                        cProgress.onStart()
                        com1 = info_5

                    }
                }

                Loader{
                    id:loader_6
                    sourceComponent: com_1
                    y: 4/60*w.height+item.height*3
                    x: 10/808*rightWindow.width+item.width/3.08
                    onLoaded: {//加载完成后
                        item.title=""
                        item.text="能谱数据采集模式"
                        item.picture="img/energy.ico"
                        //item.textBox=false
                        item.hoverText="设置"
                        item.name ="能谱"
                        //item.color="blue"
                    }
                    Component{
                        id:info_6
                        Label{
                            //color:"#34495e"
                            id:label_1
                            text:cProgress.progress > 100?"采集完成":"正在采集"+loader_6.item.name+"数据..."
                            //font.pixelSize:0.016*w.width

                        }

                    }
                }
                Connections{
                    target: loader_6.item.btn
                    onClicked:{
                        rootWindow.showPopupBottom("EnergySpectrum.qml")
                    }
                }
                Connections{
                    target: loader_6.item.inner_box
                    onClicked:{
                        cProgress.onStart()
                        //homePage1.com1 = null
                        com1 = info_6
                    }
                }
                Loader{
                    id:loader_7
                    sourceComponent: com_1
                    y: 4/60*w.height+item.height*3
                    x: 10/808*rightWindow.width+item.width/3.08*2
                    onLoaded: {//加载完成后
                        item.title=""
                        item.text="原始数据采集模式"
                        item.picture="img/origin.ico"
                        //item.textBox=false
                        item.hoverText="设置"
                        item.name ="原始"
                        //item.color="green"
                    }
                    Component{
                        id:info_7
                        Label{
                            //color:"#34495e"
                            id:label_1
                            text:cProgress.progress > 100?"采集完成":"正在采集"+loader_7.item.name+"数据..."
                            //font.pixelSize:0.016*w.width

                        }

                    }
                }
                Connections{
                    target: loader_7.item.btn
                    onClicked:{
                        rootWindow.showPopupBottom("OriginalData.qml")
                    }
                }
                Connections{
                    target: loader_7.item.inner_box
                    onClicked:{
                        cProgress.onStart()
                        com1 = info_7
                    }
                }
                Loader{
                    id:loader_8
                    sourceComponent: com_1
                    //y: 4/60*w.height+item.height*4
                    x: 10/808*rightWindow.width
                    anchors.top:loader_5.bottom
                    onLoaded: {//加载完成后
                        item.title=""
                        item.text="Singles数据采集模式"
                        item.picture="img/single.png"
                        //item.textBox=false
                        item.hoverText="设置"
                        item.isReady=false
                        item.name ="singles"
                        //item.color="gray"
                        item.otp=4

                    }
                    Component{
                        id:info_8
                        Label{
                            //color:"#34495e"
                            id:label_1
                            text:cProgress.progress > 100?"采集完成":"正在采集"+loader_8.item.name+"数据..."
                            //font.pixelSize:0.016*w.width

                        }

                    }
                }
                Connections{
                    target: loader_8.item.btn
                    onClicked:{
                        rootWindow.showPopupBottom("Singles.qml")
                    }
                }
                Connections{
                    target: loader_8.item.inner_box
                    onClicked:{
                        cProgress.onStart()
                        com1 = info_8
                    }
                }
                Loader{
                    id:loader_9
                    sourceComponent: com_1
                    y: 4/60*w.height+item.height*4
                    x: 10/808*rightWindow.width+item.width/3.08
                    onLoaded: {//加载完成后
                        item.title=""
                        item.text="符合数据采集模式"
                        item.picture="img/yes.ico"
                        //item.textBox=false
                        item.hoverText="设置"
                        item.isReady=false
                        item.name ="符合"
                        //item.color="orange"
                        item.otp=4
                    }
                    Component{
                        id:info_9
                        Label{
                            //color:"#34495e"
                            id:label_1
                            text:cProgress.progress > 100?"采集完成":"正在采集"+loader_9.item.name+"数据..."
                            //font.pixelSize:0.016*w.width

                        }

                    }


                }
                Connections{
                    target: loader_9.item.btn
                    onClicked:{
                        rootWindow.showPopupBottom("Coincide.qml")
                    }
                }
                Connections{
                    target: loader_9.item.inner_box
                    onClicked:{
                        cProgress.onStart()
                        com1 = info_9

                    }
                }


                Rectangle {
                    //y: 4/60*w.height+loader_9.item.height*4
                    x: 10/808*rightWindow.width+loader_9.item.width/3.08*2
                    anchors.top:loader_7.bottom
                    anchors.topMargin:4
                    id:outer2
                    radius:0.005*w.width
                    width:808/820*rightWindow.width/3.2-0.002*w.width
                    height:465/600*w.height/3.5-0.005*w.width
                    color: "#f6f6f6"
                    ProgressBar {
                        property color proColor: "#148014"
                        property color proBackgroundColor: parent.color
                        property real progress: 0
                        property real proRadius: 0.005*w.width
                        property alias interval: timer.interval

                        function isRunning(){
                            return(timer.running)
                        }

                        function onStart(){
                            cProgress.progress = 0;
                            timer.running = true;
                        }

                        function onStop(){
                            timer.running = false;
                        }

                        id: cProgress
                        anchors.fill: parent
                        value: (progress/100) //当前值更新进度，默认为0，范围0-1
                        //padding: 2

                        background: Rectangle {
                            width: parent.width
                            height: parent.height
                            color: cProgress.proBackgroundColor
                            radius: cProgress.proRadius
                        }

                        contentItem: Item {

                            Rectangle {
                                width: cProgress.visualPosition * parent.width
                                height: parent.height
                                radius: 0.005*w.width
                                color: cProgress.proColor
                            }
                        }

                        Timer{
                            id: timer
                            running: false //默认
                            //running:true
                            repeat: true //不断触发
                            interval: 50
                            onTriggered:{
                                cProgress.progress++;
                                if (cProgress.progress > 100){
                                    cProgress.onStop();
                                    return;
                                }
                            }
                        }
                    }
                    MyButton {
                        z:1  //x,y,z相对于父控件的定位,使按钮不冲突
                        height:0.020*w.width
                        width:0.020*w.width
                        radius:control_b.height/2    //圆形
                        opacity: hover?1:0.3
                        color:hover?"gray":parent.color
                        id: control_b
                        border.color:hover ?"black":Qt.lighter(parent.color,0.2)
                        clr: hover ?"black":Qt.lighter(parent.color,0.2)
                        anchors.right: parent.right
                        anchors.rightMargin: 0.006*w.width
                        size:0.014*w.width
                        anchors.verticalCenter:parent.verticalCenter
                        text:cProgress.isRunning()?"\u25c4":"||"
                        onClicked:{
                            if(cProgress.isRunning())
                                cProgress.onStop()
                            else
                                cProgress.onStart()
                        }
                    }
                }
            }

        }
    }
    Rectangle{//后生成的会覆盖在上面
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

















