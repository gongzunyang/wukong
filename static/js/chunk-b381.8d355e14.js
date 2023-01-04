(window.webpackJsonp=window.webpackJsonp||[]).push([["chunk-b381"],{"+yYr":function(e,t,s){},"1q41":function(e,t,s){},"31UX":function(e,t,s){"use strict";var a=s("QbLZ"),i=s.n(a),l=s("4d7F"),n=s.n(l),o=s("CMIa"),u=s("ehos"),r=s("7Qib");t.a={data:function(){return{chartObj:null,chartOtherObj:null,chartColors:["#6CA2FF","#6AC9D7","#72DCA2","#48E78D","#FECD51","#DBB375","#FF7474","#F59561","#A3AEBC","#4C84FF","#0DBEB4","#00DEDE","#FFAA00","#C7C116","#F7A57C","#F661AC","#8652EE"],chartXAxisStyle:{axisTick:{alignWithLabel:!0,lineStyle:{width:0}},axisLabel:{color:"#333"},axisLine:{lineStyle:{color:"#333"}},splitLine:{show:!1}},chartYAxisStyle:{axisTick:{alignWithLabel:!0,lineStyle:{width:0}},axisLabel:{color:"#333"},axisLine:{lineStyle:{color:"#333"}},splitLine:{show:!1}},currentPage:1,pageSizes:[15,30,45,60],pageSize:0,total:0,toolbox:{showTitle:!1,feature:{saveAsImage:{show:!0,pixelRatio:2}}}}},components:{FiltrateHandleView:o.a},props:{},computed:{},watch:{},mounted:function(){var e=this;this.debouncedResize=Object(u.debounce)(300,this.resizeFn),this.$nextTick(function(){window.addEventListener("resize",e.debouncedResize)})},beforeDestroy:function(){window.removeEventListener("resize",this.debouncedResize)},methods:{resizeFn:function(){this.chartObj&&this.chartObj.resize(),this.chartOtherObj&&this.chartOtherObj.resize()},handleSizeChange:function(e){this.pageData.limit=e,this.getList(this.pageData)},handleCurrentChange:function(e){this.pageData.page=e,this.getList(this.pageData)},requestExportInfo:function(e,t,s){return new n.a(function(a,l){e(i()({},t,{excel_types:s,excel_type:1})).then(function(e){Object(r.c)(e),a&&a(e)}).catch(function(e){l&&l(e)})})}},deactivated:function(){}}},"77fj":function(e,t,s){"use strict";var a=s("Btlj");s.n(a).a},"7DYL":function(e,t,s){"use strict";s.r(t);var a=s("31UX"),i=s("MT78"),l=s.n(i),n=s("J8QC"),o={name:"CustomerPortrayalStatistics",mixins:[a.a],props:{},data:function(){return{loading:!1,axisOption:null,list:[],type:"",postParams:{},fieldList:[]}},computed:{filterTitle:function(){return{source:"客户来源分析",industry:"客户行业分析",level:"客户级别分析"}[this.type]||""}},created:function(){this.type=this.$route.params.type},mounted:function(){this.initAxis()},beforeRouteUpdate:function(e,t,s){this.type=e.params.type,this.getDataList(this.postParams),s()},methods:{getDataList:function(e){var t=this;this.postParams=e,this.loading=!0,e.type_analyse=this.type,Object(n.b)(e).then(function(e){t.loading=!1;for(var s=[],a=[],i=[],l=[{name:"所有客户（个）"},{name:"成交客户（个）"}],n=[{field:"name",name:{source:"客户来源",industry:"客户行业",level:"客户级别"}[t.type]}],o=0;o<e.data.length;o++){var u=e.data[o];s.push({name:u[t.type],value:u.allCustomer}),a.push({name:u[t.type],value:u.dealCustomer}),i.push(u[t.type]);var r="value"+o;n.length<=e.data.length&&n.push({field:r,name:u[t.type]});for(var c=["allCustomer","dealCustomer"],h=0;h<c.length;h++){var p=c[h];l[h][r]=u[p]}}t.axisOption.legend.data=i,t.axisOption.series[0].data=s,t.axisOption.series[1].data=a,t.chartObj.setOption(t.axisOption,!0),t.fieldList=n,t.list=l}).catch(function(){t.loading=!1})},initAxis:function(){this.chartObj=l.a.init(document.getElementById("axismain")),this.axisOption=this.getChartOptione(),this.chartObj.setOption(this.axisOption,!0)},getChartOptione:function(){return{title:[{text:"全部客户",x:"20%",bottom:"25"},{text:"成交客户",x:"70%",bottom:"25"}],color:this.chartColors,toolbox:this.toolbox,tooltip:{trigger:"item",formatter:"{b} : {c}"},legend:{x:"center",y:"bottom",type:"scroll",data:[]},series:[{name:"全部客户",type:"pie",radius:["35%","50%"],center:["25%","50%"],data:[]},{name:"成交客户",type:"pie",radius:["35%","50%"],center:["75%","50%"],data:[]}]}}}},u=(s("F4Qp"),s("KHd+")),r=Object(u.a)(o,function(){var e=this,t=e.$createElement,s=e._self._c||t;return s("div",{directives:[{name:"loading",rawName:"v-loading",value:e.loading,expression:"loading"}],staticClass:"main-container"},[s("filtrate-handle-view",{staticClass:"filtrate-bar",attrs:{title:e.filterTitle,"module-type":"portrait"},on:{load:function(t){e.loading=!0},change:e.getDataList}}),e._v(" "),s("div",{staticClass:"content"},[e._m(0),e._v(" "),s("div",{staticClass:"table-content"},[s("el-table",{attrs:{data:e.list,height:"400",stripe:"",border:"","highlight-current-row":""}},e._l(e.fieldList,function(e,t){return s("el-table-column",{key:t,attrs:{fixed:0==t,"min-width":0==t?180:100,prop:e.field,label:e.name,align:"center","header-align":"center","show-overflow-tooltip":""}})}))],1)])],1)},[function(){var e=this.$createElement,t=this._self._c||e;return t("div",{staticClass:"axis-content"},[t("div",{attrs:{id:"axismain"}})])}],!1,null,"57c68cac",null);r.options.__file="CustomerPortrayalStatistics.vue";t.default=r.exports},Btlj:function(e,t,s){},CMIa:function(e,t,s){"use strict";var a=s("QbLZ"),i=s.n(a),l=s("KTTK"),n=s("ERJp"),o=s("6iAj"),u=s("UCfG"),r=s("HHBN"),c=s("ZX9L"),h=s("wd/R"),p=s.n(h),d=s("L2JU"),f={name:"FiltrateHandleView",components:{TimeTypeSelect:c.a,XhStructureCell:u.a,XhUserCell:r.a},props:{moduleType:{type:String},title:{type:String,default:""},showFilterView:{default:!0,type:Boolean},showYearSelect:{default:!1,type:Boolean},showBusinessSelect:{default:!1,type:Boolean},showUserSelect:{default:!0,type:Boolean},showCustomSelect:{default:!1,type:Boolean},customDefault:"",customOptions:{default:function(){return[]},type:Array},showProductSelect:{default:!1,type:Boolean}},data:function(){return{pickerOptions:{disabledDate:function(e){return e.getTime()>Date.now()}},yearValue:"",timeTypeValue:{},dataSelect:1,structuresSelectValue:[],userSelectValue:[],businessOptions:[],businessStatusValue:"",productValue:[],productOptions:[],customValue:""}},computed:i()({},Object(d.b)(["userInfo"]),{showUserStrucSelect:function(){return this.showUserSelect}}),watch:{},mounted:function(){var e=this;this.showCustomSelect&&(this.customValue=this.customDefault),this.showYearSelect&&(this.yearValue=p()(new Date).year().toString()),this.$emit("load"),this.showBusinessSelect?this.getBusinessStatusList(function(){e.postFiltrateValue()}):this.postFiltrateValue(),this.showProductSelect&&this.getProductCategoryIndex()},beforeDestroy:function(){},methods:{structureChange:function(e){this.structuresSelectValue=e.value||[]},userChange:function(e){this.userSelectValue=e.value||[]},customSelectChange:function(){this.$emit("typeChange",this.customValue)},timeTypeChange:function(e){this.timeTypeValue=e},structuresValueChange:function(e){this.showUserSelect&&(this.userSelectValue="",this.userOptions=[],this.getUserList())},getUserList:function(){var e=this,t={};t.structure_id=this.structuresSelectValue,Object(l.n)(t).then(function(t){e.userOptions=t.data}).catch(function(){e.$emit("error")})},getBusinessStatusList:function(e){var t=this;Object(n.q)().then(function(s){var a=s.data||[];t.businessOptions=a.filter(function(e){return 1===e.status}),t.businessOptions.length>0&&(t.businessStatusValue=t.businessOptions[0].type_id),e(!0)}).catch(function(){t.$emit("error")})},getProductCategoryIndex:function(){var e=this;Object(o.K)({type:"tree"}).then(function(t){e.productOptions=t.data}).catch(function(){})},postFiltrateValue:function(){var e={};this.showUserStrucSelect?1==this.dataSelect&&(e.structure_id=this.structuresSelectValue.length>0?this.structuresSelectValue[0].id:this.userInfo.structure_id):e.structure_id=this.structuresSelectValue.length>0?this.structuresSelectValue[0].id:"1",this.showUserSelect&&2==this.dataSelect&&(e.user_id=this.userSelectValue.length>0?this.userSelectValue[0].id:""),this.showBusinessSelect&&(e.type_id=this.businessStatusValue),this.showProductSelect&&(e.category_id=this.productValue.length>0?this.productValue[this.productValue.length-1]:""),this.showYearSelect?e.year=this.yearValue:"custom"==this.timeTypeValue.type?(e.start_time=this.timeTypeValue.startTime.replace(/\./g,"-"),e.end_time=this.timeTypeValue.endTime.replace(/\./g,"-")):e.type=this.timeTypeValue.value,this.$emit("change",e)}}},y=(s("YzRf"),s("KHd+")),m=Object(y.a)(f,function(){var e=this,t=e.$createElement,s=e._self._c||t;return s("flexbox",{staticClass:"filtrate-content",attrs:{justify:"flex-start"}},[s("flexbox",{staticClass:"title-box",attrs:{justify:"flex-start"}},[s("div",{staticClass:"icon-box"},[s("span",{staticClass:"wk wk-my-task icon"})]),e._v(" "),s("span",{staticClass:"text"},[e._v(e._s(e.title))])]),e._v(" "),e.showFilterView?[e.showYearSelect?e._e():s("time-type-select",{on:{change:e.timeTypeChange}}),e._v(" "),e.showYearSelect?s("el-date-picker",{attrs:{clearable:!1,"picker-options":e.pickerOptions,type:"year","value-format":"yyyy",placeholder:"选择年"},model:{value:e.yearValue,callback:function(t){e.yearValue=t},expression:"yearValue"}}):e._e(),e._v(" "),e.showUserStrucSelect?s("el-select",{model:{value:e.dataSelect,callback:function(t){e.dataSelect=t},expression:"dataSelect"}},e._l([{label:"按部门",value:1},{label:"按员工",value:2}],function(e){return s("el-option",{key:e.value,attrs:{label:e.label,value:e.value}})})):e._e(),e._v(" "),1==e.dataSelect?s("xh-structure-cell",{staticClass:"xh-structure-cell",attrs:{radio:"",placeholder:"选择部门（默认为本部门及下属部门）"},on:{"value-change":e.structureChange}}):e._e(),e._v(" "),2==e.dataSelect&&e.showUserSelect?s("xh-user-cell",{staticClass:"xh-user-cell",attrs:{radio:"",placeholder:"选择员工（默认为本人及下属）\n"},on:{"value-change":e.userChange}}):e._e(),e._v(" "),e.showBusinessSelect?s("el-select",{attrs:{placeholder:"商机组"},model:{value:e.businessStatusValue,callback:function(t){e.businessStatusValue=t},expression:"businessStatusValue"}},e._l(e.businessOptions,function(e){return s("el-option",{key:e.type_id,attrs:{label:e.name,value:e.type_id}})})):e._e(),e._v(" "),e.showProductSelect?s("el-cascader",{staticStyle:{width:"100%"},attrs:{options:e.productOptions,"show-all-levels":!1,props:{children:"children",label:"label",value:"categoryId"},"change-on-select":""},model:{value:e.productValue,callback:function(t){e.productValue=t},expression:"productValue"}}):e._e(),e._v(" "),e.showCustomSelect?s("el-select",{on:{change:e.customSelectChange},model:{value:e.customValue,callback:function(t){e.customValue=t},expression:"customValue"}},e._l(e.customOptions,function(e){return s("el-option",{key:e.value,attrs:{label:e.name,value:e.value}})})):e._e(),e._v(" "),e._t("append"),e._v(" "),s("el-button",{attrs:{type:"primary"},nativeOn:{click:function(t){e.postFiltrateValue()}}},[e._v("搜索")]),e._v(" "),e._t("default")]:e._e()],2)},[],!1,null,"8c270fc6",null);m.options.__file="FiltrateHandleView.vue";t.a=m.exports},F4Qp:function(e,t,s){"use strict";var a=s("+yYr");s.n(a).a},J8QC:function(e,t,s){"use strict";s.d(t,"a",function(){return i}),s.d(t,"b",function(){return l});var a=s("t3Un");function i(e){return Object(a.a)({url:"bi/customer/addressAnalyse",method:"post",data:e,headers:{"Content-Type":"application/json;charset=UTF-8"}})}function l(e){var t=e.type_analyse;return"industry"===t?Object(a.a)({url:"bi/customer/portrait",method:"post",data:e,headers:{"Content-Type":"application/json;charset=UTF-8"}}):"level"===t?Object(a.a)({url:"bi/customer/portrait",method:"post",data:e,headers:{"Content-Type":"application/json;charset=UTF-8"}}):"source"===t?Object(a.a)({url:"bi/customer/portrait",method:"post",data:e,headers:{"Content-Type":"application/json;charset=UTF-8"}}):void 0}},YzRf:function(e,t,s){"use strict";var a=s("1q41");s.n(a).a},ZX9L:function(e,t,s){"use strict";var a={name:"TimeTypeSelect",props:{defaultType:[String,Object],width:{type:Number,default:200},options:{type:Array,default:function(){return[{label:"今天",value:"today"},{label:"昨天",value:"yesterday"},{label:"本周",value:"week"},{label:"上周",value:"lastWeek"},{label:"本月",value:"month"},{label:"上月",value:"lastMonth"},{label:"本季度",value:"quarter"},{label:"上季度",value:"lastQuarter"},{label:"本年",value:"year"},{label:"去年",value:"lastYear"}]}}},data:function(){return{selectType:{label:"本年",value:"year"},showTypePopover:!1,showCustomContent:!1,sureCustomContent:!1,startTime:"",endTime:""}},computed:{typeShowValue:function(){return this.sureCustomContent?this.startTime||this.endTime?(this.startTime||"")+"-"+(this.endTime||""):"":this.selectType.label}},watch:{defaultType:function(){this.selectType.value!=this.defaultType&&(this.selectType=this.getDefaultTypeValue(this.defaultType))}},mounted:function(){void 0!==this.defaultType?"string"==typeof this.defaultType?this.selectType=this.getDefaultTypeValue(this.defaultType):this.defaultType.label?this.selectType=this.defaultType:"default"==this.defaultType.type?this.selectType=this.getDefaultTypeValue(this.defaultType.value):"custom"==this.defaultType.type&&(this.sureCustomContent=!0,this.showCustomContent=!0,this.startTime=this.defaultType.startTime,this.endTime=this.defaultType.endTime):this.$emit("change",{type:"default",value:this.selectType.value})},methods:{getDefaultTypeValue:function(e){for(var t=0;t<this.options.length;t++){var s=this.options[t];if(s.value==e)return s}return{label:"本年",value:"year"}},typeSelectClick:function(e){this.showTypePopover=!1,this.sureCustomContent=!1,this.showCustomContent=!1,this.selectType=e,this.$emit("change",{type:"default",value:this.selectType.value})},customSureClick:function(){this.startTime&&this.endTime&&(this.sureCustomContent=!0,this.showTypePopover=!1,this.$emit("change",{type:"custom",startTime:this.startTime,endTime:this.endTime}))}}},i=(s("77fj"),s("KHd+")),l=Object(i.a)(a,function(){var e=this,t=e.$createElement,s=e._self._c||t;return s("el-popover",{staticClass:"time-type-select",attrs:{width:e.width,placement:"bottom","popper-class":"no-padding-popover",trigger:"click"},model:{value:e.showTypePopover,callback:function(t){e.showTypePopover=t},expression:"showTypePopover"}},[s("div",{staticClass:"type-popper"},[s("div",{staticClass:"type-content"},[e._l(e.options,function(t,a){return s("div",{key:a,staticClass:"type-content-item",class:{selected:e.selectType.value==t.value&&!e.showCustomContent},on:{click:function(s){e.typeSelectClick(t)}}},[s("div",{staticClass:"mark"}),e._v(e._s(t.label)+"\n      ")])}),e._v(" "),s("div",{staticClass:"type-content-item",class:{selected:e.showCustomContent},on:{click:function(t){e.showCustomContent=!0}}},[s("div",{staticClass:"mark"}),e._v("自定义\n      ")])],2),e._v(" "),e.showCustomContent?s("div",{staticClass:"type-content-custom"},[s("el-date-picker",{attrs:{type:"date","value-format":"yyyy.MM.dd",placeholder:"选择日期"},model:{value:e.startTime,callback:function(t){e.startTime=t},expression:"startTime"}}),e._v(" "),s("el-date-picker",{attrs:{type:"date","value-format":"yyyy.MM.dd",placeholder:"选择日期"},model:{value:e.endTime,callback:function(t){e.endTime=t},expression:"endTime"}}),e._v(" "),s("el-button",{on:{click:e.customSureClick}},[e._v("确定")])],1):e._e()]),e._v(" "),s("el-input",{staticClass:"type-select",style:{width:e.width+"px"},attrs:{slot:"reference",readonly:!0},slot:"reference",model:{value:e.typeShowValue,callback:function(t){e.typeShowValue=t},expression:"typeShowValue"}},[s("i",{class:["el-icon-arrow-up",{"is-reverse":e.showTypePopover}],attrs:{slot:"suffix"},slot:"suffix"})])],1)},[],!1,null,"20503202",null);l.options.__file="index.vue";t.a=l.exports}}]);