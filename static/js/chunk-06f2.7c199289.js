(window.webpackJsonp=window.webpackJsonp||[]).push([["chunk-06f2"],{"2f65":function(t,e,n){},"7mY3":function(t,e,n){"use strict";var a=n("2f65");n.n(a).a},"9GgJ":function(t,e,n){"use strict";var a={name:"XrHeader",components:{},props:{iconClass:[String,Array],iconColor:String,label:String,showSearch:{type:Boolean,default:!1},searchIconType:{type:String,default:"text"},placeholder:{type:String,default:"请输入内容"},ftTop:{type:String,default:"15px"},content:[String,Number],inputAttr:{type:Object,default:function(){}}},data:function(){return{search:""}},computed:{},watch:{content:{handler:function(){this.search!=this.content&&(this.search=this.content)},immediate:!0}},mounted:function(){},beforeDestroy:function(){},methods:{inputChange:function(){this.$emit("update:content",this.search)},searchClick:function(){this.$emit("search",this.search)}}},i=(n("7mY3"),n("KHd+")),s=Object(i.a)(a,function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("flexbox",{staticClass:"xr-header"},[t.iconClass?n("div",{staticClass:"xr-header__icon",style:{backgroundColor:t.iconColor}},[n("i",{class:t.iconClass})]):t._e(),t._v(" "),n("div",{staticClass:"xr-header__label"},[t.$slots.label?t._t("label"):[t._v(t._s(t.label))]],2),t._v(" "),t.showSearch?n("el-input",t._b({staticClass:"xr-header__search",class:{"is-text":"text"===t.searchIconType},style:{"margin-top":t.ftTop},attrs:{placeholder:t.placeholder},on:{input:t.inputChange},nativeOn:{keyup:function(e){return"button"in e||!t._k(e.keyCode,"enter",13,e.key,"Enter")?t.searchClick(e):null}},model:{value:t.search,callback:function(e){t.search=e},expression:"search"}},"el-input",t.inputAttr,!1),["text"===t.searchIconType?n("el-button",{attrs:{slot:"append",type:"primary"},nativeOn:{click:function(e){return t.searchClick(e)}},slot:"append"},[t._v("搜索")]):n("el-button",{attrs:{slot:"append",icon:"el-icon-search"},nativeOn:{click:function(e){return t.searchClick(e)}},slot:"append"})],1):t._e(),t._v(" "),n("div",{staticClass:"xr-header__ft",style:{top:t.ftTop}},[t._t("ft")],2)],1)},[],!1,null,"acb6d756",null);s.options.__file="index.vue";e.a=s.exports},KWCB:function(t,e,n){"use strict";var a=n("n9M2");n.n(a).a},ZSWM:function(t,e,n){"use strict";var a=n("pzRz");n.n(a).a},bOnO:function(t,e,n){"use strict";n.r(e);var a=n("t3Un");var i=n("jzeO"),s=n("9GgJ"),l={name:"InitSet",components:{Reminder:i.a,XrHeader:s.a},data:function(){return{loading:!1,value:[],optionsObj:{},options:[{value:"all",label:"全部应用",index:1},{value:"crm",label:"客户管理",index:2},{value:"taskExamine",label:"任务/审批",index:3},{value:"log",label:"日志",index:4},{value:"project",label:"项目管理",index:5},{value:"calendar",label:"日历",index:6}]}},computed:{},watch:{value:function(t,e){t.includes("all")&&!e.includes("all")?this.value=this.options.map(function(t){return t.value}):!t.includes("all")&&e.includes("all")&&e.length===this.options.length?this.value=[]:t.includes("all")||t.length!==this.options.length-1?t.includes("all")&&t.length===this.options.length-1&&(this.value=t.filter(function(t){return"all"!==t})):this.value=this.options.map(function(t){return t.value})}},created:function(){var t=this;this.options.forEach(function(e){t.optionsObj[e.value]=e.label})},methods:{saveClick:function(){var t=this;this.$prompt("初始化数据需验证登录密码","提示",{confirmButtonText:"确定",cancelButtonText:"取消",inputType:"password",inputPlaceholder:"请输入密码"}).then(function(e){var n,i=e.value;t.loading=!0,(n={password:i},Object(a.a)({url:"admin/initialize/verification",method:"post",headers:{"Content-Type":"application/json;charset=UTF-8"},data:n})).then(function(e){t.loading=!1;var n=t.value.filter(function(t){return"all"!=t}),i=n.map(function(e){return"【"+t.optionsObj[e]+"】"}).join("、");t.$confirm("确定初始化应用"+i+"吗？<br/>数据将永久删除，不可恢复！","提示",{confirmButtonText:"确定",cancelButtonText:"取消",dangerouslyUseHTMLString:!0,type:"warning"}).then(function(){var e;t.loading=!0,(e={type:n},Object(a.a)({url:"admin/initialize/update",method:"post",headers:{"Content-Type":"application/json;charset=UTF-8"},data:e})).then(function(){t.loading=!1,t.value=[],t.$message({type:"success",message:"操作成功"}),setTimeout(function(){window.location.reload()},1500)}).catch(function(){t.loading=!1})}).catch(function(){})}).catch(function(){t.loading=!1})}).catch(function(){})}}},o=(n("ZSWM"),n("KHd+")),c=Object(o.a)(l,function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("div",{directives:[{name:"loading",rawName:"v-loading",value:t.loading,expression:"loading"}],staticClass:"init-set"},[n("xr-header",{attrs:{"icon-class":"wk wk-results-solid","icon-color":"#2362FB"}},[n("template",{slot:"label"},[t._v("初始化数据"),n("span",{staticClass:"label-des"},[t._v("（试用悟空CRM后需要删除测试数据，正式管理企业信息）")])])],2),t._v(" "),n("div",{staticClass:"init-set__body"},[n("reminder",{staticClass:"xr-reminder",attrs:{content:"提示：1、可以对单个应用或多个应用初始化，应用下的数据将全部删除；<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2、注意初始化单个应用后，将影响其他应用下与此应用关联的数据；<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style='color: red;'>初始化的数据不可恢复，请谨慎操作！</span>"}}),t._v(" "),n("div",{staticClass:"init__label"},[t._v("初始化应用")]),t._v(" "),n("div",{staticClass:"init__body"},[n("el-select",{attrs:{multiple:""},model:{value:t.value,callback:function(e){t.value=e},expression:"value"}},t._l(t.options,function(t){return n("el-option",{key:t.value,attrs:{label:t.label,value:t.value}})})),t._v(" "),n("el-button",{attrs:{disabled:0==t.value.length,type:"primary"},on:{click:t.saveClick}},[t._v("确定初始化")])],1)],1)],1)},[],!1,null,"6b523524",null);c.options.__file="Set.vue";e.default=c.exports},jzeO:function(t,e,n){"use strict";var a={name:"Reminder",components:{},props:{closeShow:{type:Boolean,default:!1},content:{type:String,default:"内容"},fontSize:{type:String,default:"13"}},data:function(){return{}},computed:{},mounted:function(){},destroyed:function(){},methods:{close:function(){this.$emit("close")}}},i=(n("KWCB"),n("KHd+")),s=Object(i.a)(a,function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("flexbox",{staticClass:"reminder-wrapper"},[n("flexbox",{staticClass:"reminder-body",attrs:{align:"stretch"}},[n("i",{staticClass:"wk wk-warning reminder-icon"}),t._v(" "),n("div",{staticClass:"reminder-content",style:{"font-size":t.fontSize+"px"},domProps:{innerHTML:t._s(t.content)}}),t._v(" "),t._t("default"),t._v(" "),t.closeShow?n("i",{staticClass:"el-icon-close close",on:{click:t.close}}):t._e()],2)],1)},[],!1,null,"36522fcc",null);s.options.__file="Reminder.vue";e.a=s.exports},n9M2:function(t,e,n){},pzRz:function(t,e,n){}}]);