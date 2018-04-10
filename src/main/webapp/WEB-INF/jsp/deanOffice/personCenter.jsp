<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/taglibs.jsp" %>
 <!DOCTYPE html>
 <html>
 <head>
     <title>个人中心</title>
 </head>
 <body>
 <div class="adminCurrentWrapper">
     <p class="publicDataTitle">个人中心</p>
     <div class="mainCont">
         <div class="personCenter">
             <div class="form-group formDiv">
                 <label for="username" class="letterSpacingThree">用户名</label>
                 <span  id="username" class="spanClass">周杰伦</span>
             </div>
             <div class="form-group formDiv">
                 <label for="name" class="letterSpacingTwo">姓名</label>
                 <span  id="name" class="spanClass">周杰伦</span>
             </div>
             <div class="form-group formDiv">
                 <label for="department">所属院系</label>
                 <span  id="department" class="spanClass">管理学院</span>
             </div>
             <div class="form-group formDiv">
                 <label for="personId" class="letterSpacingThree">身份证</label>
                 <span  id="personId" class="spanClass">612324199999999999</span>
             </div>
             <div class="form-group formDiv">
                 <label for="phone" class="letterSpacingThree">手机号</label>
                 <input type="text" class="form-control inputClass" id="phone" value="15050505500">
             </div>
             <div class="form-group formDiv">
                 <label for="email" class="letterSpacingTwo">邮箱</label>
                 <input type="text" class="form-control inputClass" id="email" value="JayChou@163.com">
             </div>
             <div class="changePassword">
                 <div class="form-group formDiv">
                     <label for="newPassword" class="letterSpacingThree">新密码</label>
                     <input type="password" class="form-control inputClass" id="newPassword" placeholder="若无需修改密码，请勿输入">
                 </div>
                 <div class="form-group formDiv">
                     <label for="confirmPassword">确认密码</label>
                     <input type="password" class="form-control inputClass" id="confirmPassword" placeholder="若无需修改密码，请勿输入">
                 </div>
             </div>
             <div class="button-group">
                 <button type="reset" class="btn btn-info">取消</button>
                 <button type="submit" class="btn btn-success">提交</button>
             </div>
         </div>
     </div>
 </div>
 </body>
 </html>