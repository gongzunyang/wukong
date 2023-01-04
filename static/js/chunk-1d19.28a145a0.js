(window.webpackJsonp=window.webpackJsonp||[]).push([["chunk-1d19"],{"+H+P":function(e,t,i){"use strict";var a={name:"EditImage",components:{VueCropper:i("fnnb").VueCropper},props:{width:{type:String,default:"450px"},title:{type:String,default:"编辑头像"},saveButtonTitle:{type:String,default:"开始上传"},show:{type:Boolean,default:!1},fixedNumber:{type:Array,default:function(){return[1,1]}},previewWidth:{type:String,default:"70px"},previewHeight:{type:String,default:"70px"},previewRadius:{type:String,default:"35px"},file:[File],image:String},data:function(){return{loading:!1,showDialog:!1,cropperImg:"",previewImg:""}},computed:{},watch:{show:{handler:function(e){this.showDialog=e},deep:!0,immediate:!0},image:function(e){this.cropperImg=e}},mounted:function(){this.cropperImg=this.image},methods:{realTime:function(e){var t=this;this.$refs.cropper.getCropData(function(e){t.previewImg=e})},submiteImage:function(){var e=this;this.$refs.cropper.getCropBlob(function(t){e.$emit("save",{blob:t,file:e.file,image:e.previewImg}),e.hiddenView()})},hiddenView:function(){this.$emit("close")}}},n=(i("0H2c"),i("KHd+")),r=Object(n.a)(a,function(){var e=this,t=e.$createElement,i=e._self._c||t;return i("el-dialog",{directives:[{name:"loading",rawName:"v-loading",value:e.loading,expression:"loading"}],attrs:{title:e.title,width:e.width,"append-to-body":!0,"close-on-click-modal":!1,visible:e.showDialog},on:{"update:visible":function(t){e.showDialog=t},close:e.hiddenView}},[i("flexbox",{staticClass:"content"},[i("div",{staticClass:"cropper-box"},[i("vueCropper",{ref:"cropper",attrs:{"can-move":!0,"auto-crop":!0,fixed:!0,"fixed-number":e.fixedNumber,img:e.cropperImg,"output-type":"png"},on:{realTime:e.realTime}})],1),e._v(" "),i("div",{staticClass:"preview"},[i("div",{staticClass:"preview-name"},[e._v("预览")]),e._v(" "),i("img",{staticClass:"preview-img",style:{width:e.previewWidth,height:e.previewHeight,"border-radius":e.previewRadius},attrs:{src:e.previewImg}})])]),e._v(" "),i("div",{staticClass:"dialog-footer",attrs:{slot:"footer"},slot:"footer"},[i("el-button",{attrs:{type:"primary"},on:{click:function(t){e.submiteImage()}}},[e._v(e._s(e.saveButtonTitle))])],1)],1)},[],!1,null,"923b6484",null);r.options.__file="EditImage.vue";t.a=r.exports},"0H2c":function(e,t,i){"use strict";var a=i("T45K");i.n(a).a},"44Km":function(e,t,i){"use strict";i.r(t);var a=i("QbLZ"),n=i.n(a),r=i("L2JU"),s=i("EJiy"),l=i.n(s),o=i("P2sY"),d=i.n(o),c=i("ef+5"),u=i("7Qib"),f={name:"EditUserInfo",components:{EditImage:i("+H+P").a},data:function(){return{fieldList:[{label:"姓名",field:"realname"},{label:"手机号(登录名)",field:"mobile",disabled:!0},{label:"直属上级",field:"parent_name",disabled:!0},{label:"性别",field:"sex",type:"select",setting:[{label:"请选择",value:0},{label:"男",value:1},{label:"女",value:2}]},{label:"邮箱",field:"email"},{label:"部门",field:"structure_name",disabled:!0},{label:"岗位",field:"post"}],rules:{realname:[{required:!0,message:"请填写姓名",trigger:"blur"}],email:[{validator:function(e,t,i){!t||""==t||Object(u.u)(t)?i():i(new Error("邮箱格式有误"))},trigger:"change"}],username:[{required:!0,message:"请填写姓名",trigger:"blur"},{validator:function(e,t,i){!t||""==t||Object(u.v)(t)?i():i(new Error("手机格式有误"))},trigger:"change"}]},form:{},loading:!1,showEditImage:!1,editFile:null,editImage:null}},computed:n()({},Object(r.b)(["userInfo"])),watch:{userInfo:{handler:function(){this.initData()},deep:!0,immediate:!0}},methods:{initData:function(){this.form=d()({},this.userInfo)},handleChangeAvatar:function(){document.getElementById("inputFile").click()},uploadFile:function(e){var t=e.target.files[0],i=new FileReader,a=this;i.onload=function(e){var i=void 0;i="object"===l()(e.target.result)?window.URL.createObjectURL(new Blob([e.target.result])):e.target.result,a.editImage=i,a.editFile=t,a.showEditImage=!0,e.target.value=""},i.readAsDataURL(t)},submitImage:function(e){var t=this;this.loading=!0;var i=new FormData;i.append("id",this.form.id),i.append("file",e.blob,e.file.name),Object(c.d)(i).then(function(){t.loading=!1,t.$emit("change")}).catch(function(){t.loading=!1})},handleSave:function(){var e=this,t={realname:this.form.realname,sex:"请选择"===this.form.sex?"":this.form.sex,email:this.form.email,post:this.form.post,username:this.form.username};this.$refs.form.validate(function(i){if(!i)return!1;e.loading=!0,Object(c.c)(t).then(function(){e.loading=!1,e.$message.success("保存成功"),e.$emit("change")}).catch(function(){e.loading=!1})})}}},m=(i("zlsi"),i("KHd+")),p=Object(m.a)(f,function(){var e=this,t=e.$createElement,i=e._self._c||t;return i("div",{directives:[{name:"loading",rawName:"v-loading",value:e.loading,expression:"loading"}],staticClass:"edit-user-info"},[e._m(0),e._v(" "),i("el-form",{ref:"form",attrs:{model:e.form,rules:e.rules,"label-position":"left","label-width":"120px"}},[i("el-form-item",{attrs:{label:"头像"}},[i("flexbox",{staticClass:"user-box"},[i("xr-avatar",{staticClass:"user-img",attrs:{name:e.userInfo.realname,size:70,src:e.userInfo.img}}),e._v(" "),i("div",{staticClass:"change-avatar",on:{click:e.handleChangeAvatar}},[e._v("\n          更换头像\n        ")])],1)],1),e._v(" "),e._l(e.fieldList,function(t,a){return i("el-form-item",{key:a,attrs:{prop:t.field,label:t.label}},["select"!==t.type?i("el-input",{attrs:{maxlength:30,disabled:t.disabled},model:{value:e.form[t.field],callback:function(i){e.$set(e.form,t.field,i)},expression:"form[item.field]"}}):i("el-select",{model:{value:e.form[t.field],callback:function(i){e.$set(e.form,t.field,i)},expression:"form[item.field]"}},e._l(t.setting,function(e){return i("el-option",{key:e.value,attrs:{label:e.label,value:e.label}})}))],1)}),e._v(" "),i("el-form-item",[i("el-button",{attrs:{type:"primary"},on:{click:e.handleSave}},[e._v("保存")])],1)],2),e._v(" "),i("input",{staticStyle:{display:"none"},attrs:{id:"inputFile",type:"file",accept:"image/png, image/jpeg, image/gif, image/jpg"},on:{change:e.uploadFile}}),e._v(" "),i("edit-image",{attrs:{show:e.showEditImage,file:e.editFile,image:e.editImage},on:{save:e.submitImage,close:function(t){e.showEditImage=!1}}})],1)},[function(){var e=this.$createElement,t=this._self._c||e;return t("div",{staticClass:"head"},[t("span",{staticClass:"wk wk-user icon"}),this._v(" "),t("span",{staticClass:"text"},[this._v("个人信息")])])}],!1,null,"87b16550",null);p.options.__file="EditUserInfo.vue";var g=p.exports,v=i("X4fA"),h={name:"EditPwd",data:function(){var e=/^(?=.*[a-zA-Z])(?=.*\d).{6,20}$/;return{loading:!1,form:{},rules:{oldPwd:[{required:!0,message:"请输入原密码",trigger:"blur"},{pattern:e,message:"密码必须由6-20位字母、数字组成",trigger:"blur"}],newPwd:[{required:!0,message:"请输入新密码",trigger:"blur"},{pattern:e,message:"密码必须由6-20位字母、数字组成",trigger:"blur"}],confirmPwd:[{required:!0,message:"请再次输入密码",trigger:"blur"},{validator:this.validatedConfirmPwd,trigger:"blur"}]}}},computed:n()({},Object(r.b)(["userInfo"])),methods:{validatedConfirmPwd:function(e,t,i){""===t?i(new Error("请再次输入密码")):t!==this.form.newPwd?i(new Error("两次输入密码不一致!")):i()},handleSave:function(){var e=this;this.$refs.form.validate(function(t){if(!t)return!1;e.loading=!0;var i={id:e.userInfo.id,old_pwd:e.form.oldPwd,new_pwd:e.form.newPwd};Object(c.b)(i).then(function(){e.loading=!1,Object(v.c)().then(function(){e.$confirm("修改成功, 请重新登录","提示",{confirmButtonText:"确定",showCancelButton:!1,type:"warning"}).then(function(){e.$router.push("/login")}).catch(function(){e.$router.push("/login")})})}).catch(function(){e.loading=!1})})}}},w=(i("afPI"),Object(m.a)(h,function(){var e=this,t=e.$createElement,i=e._self._c||t;return i("div",{staticClass:"edit-pwd"},[e._m(0),e._v(" "),i("el-form",{directives:[{name:"loading",rawName:"v-loading",value:e.loading,expression:"loading"}],ref:"form",attrs:{model:e.form,rules:e.rules,"label-position":"left","label-width":"120px"}},[i("el-form-item",{attrs:{label:"原密码",prop:"oldPwd"}},[i("el-input",{attrs:{maxlength:20,type:"password"},model:{value:e.form.oldPwd,callback:function(t){e.$set(e.form,"oldPwd","string"==typeof t?t.trim():t)},expression:"form.oldPwd"}})],1),e._v(" "),i("el-form-item",{attrs:{label:"新密码",prop:"newPwd"}},[i("el-input",{attrs:{maxlength:20,type:"password"},model:{value:e.form.newPwd,callback:function(t){e.$set(e.form,"newPwd","string"==typeof t?t.trim():t)},expression:"form.newPwd"}})],1),e._v(" "),i("el-form-item",{attrs:{label:"确认密码",prop:"confirmPwd"}},[i("el-input",{attrs:{maxlength:20,type:"password"},model:{value:e.form.confirmPwd,callback:function(t){e.$set(e.form,"confirmPwd","string"==typeof t?t.trim():t)},expression:"form.confirmPwd"}})],1),e._v(" "),i("el-form-item",[i("el-button",{attrs:{type:"primary"},on:{click:e.handleSave}},[e._v("保存")])],1)],1)],1)},[function(){var e=this.$createElement,t=this._self._c||e;return t("div",{staticClass:"head"},[t("span",{staticClass:"wk wk-circle-password icon"}),this._v(" "),t("span",{staticClass:"text"},[this._v("账号密码")])])}],!1,null,"0697c9c8",null));w.options.__file="EditPwd.vue";var b={name:"PersonCenter",components:{EditUserInfo:g,EditPwd:w.exports},data:function(){return{selectedIndex:0}},computed:n()({},Object(r.b)(["userInfo"]),{navList:function(){return[{label:"个人信息",icon:"wk-user"},{label:"账号密码",icon:"wk-circle-password"}]}}),created:function(){this.getDetail()},methods:{getDetail:function(){var e=this;this.loading=!0,this.$store.dispatch("GetUserInfo").then(function(){e.loading=!1}).catch(function(){e.loading=!1})}}},_=(i("QkI1"),Object(m.a)(b,function(){var e=this,t=e.$createElement,i=e._self._c||t;return i("flexbox",{staticClass:"person-center",attrs:{align:"flex-start"}},[i("div",{staticClass:"left"},[i("flexbox",{staticClass:"user-box"},[i("xr-avatar",{staticClass:"user-img",attrs:{name:e.userInfo.realname,size:50,src:e.userInfo.img}}),e._v(" "),i("span",{staticClass:"username"},[e._v("\n        "+e._s(e.userInfo.realname)+"\n      ")])],1),e._v(" "),i("ul",{staticClass:"nav-list"},e._l(e.navList,function(t,a){return i("li",{key:a,staticClass:"nav-list-item",class:{active:e.selectedIndex===a},on:{click:function(t){e.selectedIndex=a}}},[i("span",{staticClass:"wk icon",class:t.icon}),e._v(" "),i("span",{staticClass:"text"},[e._v("\n          "+e._s(t.label)+"\n        ")])])}))],1),e._v(" "),i("div",{staticClass:"right"},[0===e.selectedIndex?i("edit-user-info",{on:{change:e.getDetail}}):e._e(),e._v(" "),1===e.selectedIndex?i("edit-pwd"):e._e()],1)])},[],!1,null,"118b6478",null));_.options.__file="index.vue";t.default=_.exports},BudI:function(e,t,i){},QkI1:function(e,t,i){"use strict";var a=i("cKy3");i.n(a).a},T45K:function(e,t,i){},afPI:function(e,t,i){"use strict";var a=i("xmXB");i.n(a).a},cKy3:function(e,t,i){},xmXB:function(e,t,i){},zlsi:function(e,t,i){"use strict";var a=i("BudI");i.n(a).a}}]);