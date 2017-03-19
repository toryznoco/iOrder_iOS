<%--
  Created by IntelliJ IDEA.
  User: 81062
  Date: 2017/3/15
  Time: 19:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>iOrder</title>
</head>
<body>
<h1>iOrder</h1>
<div class="page">
    <h2>度分秒 TO 小数点 转换</h2>
    <div class="panel">
        <i class="corner"><i class="l1"></i><i class="l2"></i><i class="l3"></i><i class="l4"></i></i>
        <div class="cbody">
            <div style="text-align:center;height:60px;">
                <div style="float:left;color:green;font-weight:bold;font-size:14px;width:50px;" id="sign1">&nbsp;</div>
                <div style="float:left;">

                    <input type="text" id="deg" name="deg" onKeyUp="Convert2Dec()"/>度
                    <input type="text" id="min" name="min" onKeyUp="Convert2Dec()"/>分
                    <input type="text" id="sec" name="sec" onKeyUp="Convert2Dec()"/>秒<br/><br/>
                    =
                    <input type="text" id="deg2" name="deg2" onkeyup="Convert2Deg()"/>度
                </div>
                <div style="float:left;color:green;font-weight:bold;font-size:14px;width:50px;" id="sign2">&nbsp;</div>
            </div>
        </div>
        <i class="corner"><i class="l4"></i><i class="l3"></i><i class="l2"></i><i class="l5"></i></i>
    </div>
    <h2>经纬度距离计算</h2>
    <div class="panel">
        <i class="corner"><i class="l1"></i><i class="l2"></i><i class="l3"></i><i class="l4"></i></i>
        <div class="cbody">
            <div style="text-align:center;height:100px;">
                <div style="text-align:left;float:left;margin-left:40px;">
                    A：纬度<input type="text" name="lat1" id="lat1" onKeyUp="calDis()"/> 经度<input type="text" name="lng1"
                                                                                               id="lng1"
                                                                                               onKeyUp="calDis()"/><br/><br/>
                    B：纬度<input type="text" name="lat2" id="lat2" onKeyUp="calDis()"/>经度<input type="text" name="lng2"
                                                                                              id="lng2"
                                                                                              onKeyUp="calDis()"/><br/><br/>
                    A-B：距离=<input type="text" name="distance" id="distance"/> Km
                </div>
                <div class="warning" id="warning"></div>
            </div>

        </div>
        <i class="corner"><i class="l4"></i><i class="l3"></i><i class="l2"></i><i class="l5"></i></i>
    </div>

    <SCRIPT LANGUAGE="JavaScript">
        <!--

        function getVal(obj) {
            if (document.getElementById(obj) != null)
                return document.getElementById(obj).value;
            else return 0;
        }
        function setVal(obj, val) {
            if (document.getElementById(obj) != null)
                document.getElementById(obj).value = val;

        }
        function Convert2Dec() {
            var deg = Math.abs(getVal('deg'));
            var min = Math.abs(getVal('min'));
            var sec = Math.abs(getVal('sec'));
            var deci = deg * 1 + ( sec * 1 + min * 60 ) / 3600;
            setVal("deg2", deci);
        }
        function Convert2Deg() {
            var deci = Math.abs(getVal('deg2'));
            var deci2 = deci + '';

            if (deci2.indexOf('.') == -1) {
                setVal("deg", deci);
                return false;
            }
            deci = deci2.split(".");
            setVal("deg", deci[0]);

            //
            deci[1] = "0." + deci[1];
            var min_sec = deci[1] * 3600;
            var min = Math.floor(min_sec / 60);
            var sec = ( min_sec - ( min * 60 ) );

            setVal("min", min);

            setVal("sec", sec);

        }
        function hide(m) {
            document.getElementById(m).style.display = "none";
            return true;
        }
        function show(m) {
            document.getElementById(m).style.display = "";
            return true;
        }
        //private const double EARTH_RADIUS = 6378.137;
        function rad(d) {
            return d * Math.PI / 180.0;
        }

        function GetDistance(lat1, lng1, lat2, lng2) {
            hide("warning");
            if (( Math.abs(lat1) > 90  ) || (  Math.abs(lat2) > 90 )) {
                document.getElementById("warning").innerHTML = ("兄台，这哪里是纬度啊？分明是想忽悠我嘛");
                show("warning");
                return "耍我？拒绝计算！";
            } else {
                hide("warning");
            }
            if (( Math.abs(lng1) > 180  ) || (  Math.abs(lng2) > 180 )) {

                show("warning");
                document.getElementById("warning").innerHTML = ("兄台，这哪里是经度啊？分明是想忽悠我嘛");
                return "耍我？拒绝计算！";
            } else {
                hide("warning");
            }
            var radLat1 = rad(lat1);
            var radLat2 = rad(lat2);
            var a = radLat1 - radLat2;
            var b = rad(lng1) - rad(lng2);
            var s = 2 * Math.asin(Math.sqrt(Math.pow(Math.sin(a / 2), 2) +
                    Math.cos(radLat1) * Math.cos(radLat2) * Math.pow(Math.sin(b / 2), 2)));
            s = s * 6378.137;// EARTH_RADIUS;
            s = Math.round(s * 10000) / 10000;
            return s;
        }
        function calDis() {
            var lat1 = document.getElementById("lat1").value * 1;
            var lat2 = document.getElementById("lat2").value * 1;
            var lng1 = document.getElementById("lng1").value * 1;
            var lng2 = document.getElementById("lng2").value * 1;

            var dis = GetDistance(lat1, lng1, lat2, lng2);
            document.getElementById("distance").value = dis;
        }
        //-->
    </SCRIPT>
</div>
</body>
</html>
