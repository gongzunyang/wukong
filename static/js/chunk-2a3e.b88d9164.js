(window.webpackJsonp=window.webpackJsonp||[]).push([["chunk-2a3e"],{"/G0b":function(t,e,i){"use strict";var s=i("m1cH"),n=i.n(s),a=i("KTTK"),o=i("6iAj"),c=i("4XAY"),l=i("7Dod"),r=i("7Qib"),u=i("mkuN"),d=i("zMq1"),m=i("ye9D"),f=i("NYF1"),h=i("YIeP"),v=i("ZoMv"),p={name:"LogEditDialog",components:{CrmRelative:u.a,AddImageList:d.a,AddFileList:m.a,AddRelateList:f.a,CommonWords:h.a},props:{visible:{type:Boolean,required:!0,default:!1},data:Object},data:function(){return{loading:!1,crmType:"",content:"",imgFiles:[],businessAction:{},files:[],showBusinessPopover:!1,business:[],contacts:[],selectContactsId:"",followTypes:[],followType:"",next_time:"",showRelativeType:"",batchId:""}},computed:{autosize:function(){return{minRows:4,maxRows:8}},id:function(){return this.data?this.data.activity_type_id:""},showBusiness:function(){return"customer"==this.crmType},showContacts:function(){return this.showBusiness}},watch:{visible:{handler:function(t){if(t){var e=v.a.convertTypeToKey(this.data.activity_type);this.crmType!=e&&(this.crmType=e),this.handleDetailInfo(Object(r.t)(this.data))}},immediate:!0,deep:!0},id:{handler:function(){this.businessAction={type:"condition",data:{moduleType:this.crmType,customerId:this.id}}},immediate:!0}},created:function(){},beforeDestroy:function(){},methods:{handleDetailInfo:function(t){var e=this;this.showContacts&&this.getContactsList(),0==this.followTypes.length&&this.getLogTypeList(),this.content=t.content,this.imgFiles=t.imgList||[];var i=t.fileList||[];this.files=i.map(function(t){return t.icon=e.getFileTypeIcon(t.name),t});var s=t.business_list||[];this.business=s.map(function(t){return{businessName:t.name,business_id:t.business_id}}),this.selectContactsId=t.contacts_ids&&parseInt(t.contacts_ids),this.followType=t.category,this.next_time=t.next_time,this.batchId=t.batchId},getFileTypeIcon:function(t){if(!t)return"";var e=t?t.split("."):[],i="";return i=e.length>0?e[e.length-1]:"",Object(r.n)(i)},getLogTypeList:function(){var t=this;Object(o.r)().then(function(e){t.followTypes=e.data.map(function(t){return{value:t,label:t}})}).catch(function(){})},getContactsList:function(){var t=this;Object(l.I)({customer_id:this.id}).then(function(e){t.contacts=e.data.list}).catch(function(){})},getDefalutFollowType:function(){this.followTypes&&this.followTypes.length>0?this.followType=this.followTypes[0].value:this.followType=""},resetInfo:function(){this.next_time="",this.content="",this.imgFiles=[],this.files=[],this.business=[],this.selectContactsId=this.contactsId||"",this.showRelativeType="",this.batchId="",this.getDefalutFollowType()},commonWordsSelect:function(t){var e=this;this.content?this.$confirm("您选中的常用语将覆盖当前填写内容?","提示",{confirmButtonText:"确定",cancelButtonText:"取消",type:"warning",customClass:"is-particulars"}).then(function(){e.content=t}).catch(function(){}):this.content=t},checkRelativeInfos:function(t){"business"==this.showRelativeType&&(this.business=t.data)},barClick:function(t){this.showRelativeType=t,"business"==t?this.showBusinessPopover=!0:"file"==t?this.$refs.fileInput.click():"img"==t&&this.$refs.imgInput.click()},uploadFile:function(t){var e=t.target.files;if(e.length){for(var i=0;i<e.length;i++){if(-1==e[i].type.indexOf("image")&&"img"==this.showRelativeType)return void this.$message.error("请上传正确的文件类型")}for(var s="image/*"==t.target.accept?"img":"file",n=0;n<e.length;n++){var a=e[n];this.uploadFileRequest(a,s)}t.target.value=""}},uploadFileRequest:function(t,e,i){var s=this;this.$wkUploadFile.upload({file:t,params:{module_id:this.id,module:"crm_"+this.crmType,type:e,batchId:this.batchId}}).then(function(n){var a=n.res.data||{};a.size=Object(r.h)(t.size),"img"==e?s.imgFiles.push(a):(a.icon=Object(r.o)(t),s.files.push(a)),i&&i()}).catch(function(){})},deleteImage:function(t,e){this.deleteImgOrFile("image",t,e)},deleteFile:function(t,e){this.deleteImgOrFile("file",t,e)},deleteImgOrFile:function(t,e,i){var s=this;this.$confirm("确定删除?","提示",{confirmButtonText:"确定",cancelButtonText:"取消",type:"warning"}).then(function(){Object(a.c)({module:"crm_"+s.crmType,module_id:e.file_id,save_name:e.save_name}).then(function(e){"image"==t?s.imgFiles.splice(i,1):s.files.splice(i,1),s.$message.success("操作成功")}).catch(function(){})}).catch(function(){})},deleteAllFile:function(t){var e=this;this.$confirm("确定删除?","提示",{confirmButtonText:"确定",cancelButtonText:"取消",type:"warning"}).then(function(){Object(a.e)({module:"crm_"+e.crmType,module_id:e.id,file_id:[].concat(n()(e.imgFiles.map(function(t){return t.file_id})),n()(e.files.map(function(t){return t.file_id}))),batchId:e.batchId,type:t}).then(function(i){2==t?e.imgFiles=[]:e.files=[],e.$message.success("操作成功")}).catch(function(){})}).catch(function(){})},deleteRelate:function(t,e){this.business.splice(e,1)},inputFocus:function(){var t=this;this.$nextTick(function(){t.$refs.textarea.focus(),t.$emit("focus")})},handleConfirm:function(){var t=this;if(this.content){var e={};e.activity_id=this.data.activity_id,e.activity_type=this.data.activity_type,e.activity_type_id=this.id,e.content=this.content,e.category=this.followType,e.file_id=[].concat(n()(this.imgFiles.map(function(t){return t.file_id})),n()(this.files.map(function(t){return t.file_id})));var i=this.business.map(function(t){return t.business_id||t.id});e.batchId=this.batchId,e.business_ids=i,e.contacts_ids=this.contacts_id,e.next_time=this.next_time||"",e.is_event=0,this.loading=!0,Object(c.e)(e).then(function(e){t.loading=!1,t.$message.success("编辑成功"),t.$emit("save",e.data),t.handleCancel()}).catch(function(){t.loading=!1})}else this.$message.error("请输入跟进内容")},handleCancel:function(){this.$emit("update:visible",!1)}}},_=(i("uhC+"),i("KHd+")),g=Object(_.a)(p,function(){var t=this,e=t.$createElement,i=t._self._c||e;return i("el-dialog",{directives:[{name:"loading",rawName:"v-loading",value:t.loading,expression:"loading"}],attrs:{visible:t.visible,"append-to-body":!0,"close-on-click-modal":!1,title:"编辑跟进记录",width:"700px","custom-class":"no-padding-dialog"},on:{close:t.handleCancel}},[i("div",{staticClass:"mix-content"},[i("div",{staticClass:"mix-content__body"},[i("div",{staticClass:"mix-content-select"},[t.showContacts?i("el-select",{attrs:{clearable:"",placeholder:"选择联系人"},model:{value:t.selectContactsId,callback:function(e){t.selectContactsId=e},expression:"selectContactsId"}},t._l(t.contacts,function(t){return i("el-option",{key:t.contacts_id,attrs:{label:t.name,value:t.contacts_id}})})):t._e(),t._v(" "),i("el-select",{attrs:{clearable:"",placeholder:"选择跟进方式"},model:{value:t.followType,callback:function(e){t.followType=e},expression:"followType"}},t._l(t.followTypes,function(t){return i("el-option",{key:t.value,attrs:{label:t.label,value:t.value}})})),t._v(" "),i("el-date-picker",{attrs:{editable:!1,type:"datetime",placeholder:"选择下次联系时间","value-format":"yyyy-MM-dd HH:mm:ss"},model:{value:t.next_time,callback:function(e){t.next_time=e},expression:"next_time"}}),t._v(" "),i("common-words",{on:{select:t.commonWordsSelect}})],1),t._v(" "),i("div",{staticClass:"i-cont"},[i("el-input",{ref:"textarea",attrs:{autosize:t.autosize,maxlength:800,type:"textarea",clearable:"",resize:"none",placeholder:"请输入内容"},on:{focus:t.inputFocus},model:{value:t.content,callback:function(e){t.content=e},expression:"content"}})],1),t._v(" "),t.imgFiles.length>0?i("add-image-list",{attrs:{data:t.imgFiles},on:{delete:t.deleteImage,"delete-all":function(e){t.deleteAllFile(2)},upload:t.uploadFile}}):t._e(),t._v(" "),t.files.length>0?i("add-file-list",{attrs:{data:t.files},on:{delete:t.deleteFile,"delete-all":function(e){t.deleteAllFile(1)}}}):t._e(),t._v(" "),t.business.length>0?i("add-relate-list",{attrs:{data:t.business,type:"business"},on:{delete:t.deleteRelate}}):t._e()],1),t._v(" "),i("div",{staticClass:"bar-cont"},[i("el-button",{staticClass:"handle-button",attrs:{type:"text",icon:"wk wk-picture"},on:{click:function(e){t.barClick("img")}}},[t._v("图片")]),t._v(" "),i("el-button",{staticClass:"handle-button",attrs:{type:"text",icon:"wk wk-file"},on:{click:function(e){t.barClick("file")}}},[t._v("附件")]),t._v(" "),t.showBusiness?i("el-popover",{attrs:{placement:"bottom",width:"700","popper-class":"no-padding-popover",trigger:"click"},model:{value:t.showBusinessPopover,callback:function(e){t.showBusinessPopover=e},expression:"showBusinessPopover"}},[i("crm-relative",{ref:"crmrelative",attrs:{show:t.showBusinessPopover,radio:!1,action:t.businessAction,"selected-data":{business:t.business},"crm-type":"business"},on:{close:function(e){t.showBusinessPopover=!1},changeCheckout:t.checkRelativeInfos}}),t._v(" "),i("el-button",{staticClass:"handle-button",staticStyle:{"margin-left":"10px"},attrs:{slot:"reference",type:"text",icon:"wk wk-associate"},on:{click:function(e){t.barClick("business")}},slot:"reference"},[t._v("关联商机")])],1):t._e()],1),t._v(" "),i("input",{ref:"fileInput",staticClass:"file-input",attrs:{accept:"*.*",type:"file",multiple:""},on:{change:t.uploadFile}}),t._v(" "),i("input",{ref:"imgInput",staticClass:"file-input",attrs:{accept:"image/*",type:"file",multiple:""},on:{change:t.uploadFile}})]),t._v(" "),i("span",{staticClass:"dialog-footer",attrs:{slot:"footer"},slot:"footer"},[i("el-button",{nativeOn:{click:function(e){return t.handleCancel(e)}}},[t._v("取消")]),t._v(" "),i("el-button",{directives:[{name:"debounce",rawName:"v-debounce",value:t.handleConfirm,expression:"handleConfirm"}],attrs:{type:"primary"}},[t._v("确定")])],1)])},[],!1,null,"4baabbc8",null);g.options.__file="LogEditDialog.vue";e.a=g.exports},Aihl:function(t,e,i){},D67r:function(t,e,i){},JBWo:function(t,e,i){"use strict";var s=i("k3SN");i.n(s).a},JftJ:function(t,e,i){"use strict";var s=i("i2VW");i.n(s).a},NYF1:function(t,e,i){"use strict";var s={name:"AddRelateList",components:{},props:{data:Array,type:{type:[String,Number],require:!0},label:String},data:function(){return{}},computed:{typeName:function(){return this.label?this.label:{customer:"客户",contacts:"联系人",business:"商机",contract:"合同"}[this.type]}},watch:{},mounted:function(){},beforeDestroy:function(){},methods:{getItemName:function(t){return t[{customer:"customerName",contacts:"name",business:"businessName",contract:"name"}[this.type]]||t.name},deleteItem:function(t,e){this.$emit("delete",t,e,this.type)}}},n=(i("s357"),i("KHd+")),a=Object(n.a)(s,function(){var t=this,e=t.$createElement,i=t._self._c||e;return i("section",{staticClass:"c-cont"},[i("flexbox",{staticClass:"c-header"},[i("i",{class:["wk","wk-"+t.type]}),t._v(" "),i("div",{staticClass:"c-name"},[t._v(t._s(t.typeName))])]),t._v(" "),i("div",{staticClass:"c-body"},[i("flexbox",{attrs:{wrap:"wrap"}},t._l(t.data,function(e,s){return i("flexbox",{key:s,staticClass:"c-item"},[i("div",{staticClass:"c-item-name"},[t._v(t._s(t.getItemName(e)))]),t._v(" "),i("div",{staticClass:"c-item-close",on:{click:function(i){t.deleteItem(e,s)}}},[t._v("×")])])}))],1)],1)},[],!1,null,"60fd2091",null);a.options.__file="AddRelateList.vue";e.a=a.exports},O8VQ:function(t,e,i){"use strict";var s=i("QbLZ"),n=i.n(s),a=i("4XAY"),o=i("Vm8M"),c=i("7Qib"),l=i("Z+Ht"),r=i("vvxI"),u=i("L2JU"),d={name:"LogCell",components:{MapView:o.a},filters:{getFileSize:function(t){return Object(c.h)(t)}},mixins:[l.a,r.a],props:{item:{type:Object,default:function(){return{}}},section:[String,Number],index:[String,Number],canDelete:{type:Boolean,default:!0}},data:function(){return{showMapView:!1,mapViewInfo:{}}},computed:n()({},Object(u.b)(["crm"]),{hasEditAuth:function(){return this.crm&&this.crm.activity&&this.crm.activity.update},hasDeleteAuth:function(){return this.crm&&this.crm.activity&&this.crm.activity.delete},activityIcon:function(){return this.getXrIcon(this.getActivityType(this.item.activity_type))},activityIconColor:function(){return this.getXrIconColor(this.getActivityType(this.item.activity_type))}}),mounted:function(){},methods:{previewImg:function(t,e){this.$bus.emit("preview-image-bus",{index:e,data:t.map(function(t){return t.url=t.file_path,t})})},downloadFile:function(t){Object(c.d)({path:t.file_path,save_name:t.save_name,name:t.name})},handleCommand:function(t){var e=this;"delete"==t?this.$confirm("确定删除?","提示",{confirmButtonText:"确定",cancelButtonText:"取消",type:"warning"}).then(function(){(4==e.item.type?a.d:a.b)({activity_id:e.item.activity_id}).then(function(t){e.$emit("delete",e.item,e.index,e.section),e.$store.dispatch("GetMessageNum"),e.$message.success("操作成功")}).catch(function(){})}).catch(function(){}):"edit"==t&&this.$emit("edit",this.item,this.index,this.section)},checkRelationDetail:function(t,e){this.$emit("crm-detail",t,e)},checkMapView:function(t){t.address&&(this.mapViewInfo={title:t.address,lat:t.lat,lng:t.lng},this.showMapView=!0)}}},m=(i("JBWo"),i("KHd+")),f=Object(m.a)(d,function(){var t=this,e=t.$createElement,i=t._self._c||e;return i("div",{staticClass:"fl-c"},[i("flexbox",{staticClass:"fl-h"},[i("xr-avatar",{staticClass:"fl-h-img",attrs:{name:t.item.create_user_name,id:t.item.create_user_id,size:30,src:t.item.thumb_img,disabled:!1}}),t._v(" "),i("div",{staticClass:"fl-h-b"},[i("div",{staticClass:"fl-h-name"},[t._v(t._s(t.item.create_user_name))]),t._v(" "),i("div",{staticClass:"fl-h-time"},[t._v(t._s(t.item.update_time))])]),t._v(" "),t.item.category?i("div",{staticClass:"follow"},[i("span",{staticClass:"follow-info"},[t._v(t._s(t.item.category))])]):t._e(),t._v(" "),i("span",{staticClass:"log-mark",style:{right:t.canDelete?"40px":"15px"}},[i("i",{class:t.activityIcon,style:{color:t.activityIconColor}}),t._v(" "),i("span",{staticClass:"log-mark__label"},[t._v(t._s(t.getActivityTypeName(t.item.activity_type)+"-"+t.getRecordLogTypeName(t.item.type)))])]),t._v(" "),t.canDelete&&(t.hasDeleteAuth||t.hasEditAuth)?i("el-dropdown",{staticClass:"more-drop",attrs:{trigger:"click"},on:{command:t.handleCommand}},[i("i",{staticClass:"el-icon-arrow-down el-icon-more"}),t._v(" "),i("el-dropdown-menu",{attrs:{slot:"dropdown"},slot:"dropdown"},[t.hasEditAuth?i("el-dropdown-item",{attrs:{command:"edit"}},[t._v("编辑")]):t._e(),t._v(" "),t.hasDeleteAuth?i("el-dropdown-item",{attrs:{command:"delete"}},[t._v("删除")]):t._e()],1)],1):t._e()],1),t._v(" "),i("div",{staticClass:"fl-b"},[i("div",{staticClass:"fl-b-content"},[t._v(t._s(t.item.content))]),t._v(" "),t.item.imgList&&t.item.imgList.length>0?i("flexbox",{staticClass:"fl-b-images",attrs:{wrap:"wrap"}},t._l(t.item.imgList,function(e,s){return i("div",{directives:[{name:"src",rawName:"v-src:background-image",value:e.file_path,expression:"file.file_path",arg:"background-image"}],key:e.file_path,staticClass:"fl-b-img-item",on:{click:function(e){t.previewImg(t.item.imgList,s)}}})})):t._e(),t._v(" "),t.item.fileList&&t.item.fileList.length>0?i("div",t._l(t.item.fileList,function(e,s){return i("flexbox",{key:s,staticClass:"cell",attrs:{align:"stretch"}},[i("div",{staticClass:"cell-hd first-show"},[i("i",{staticClass:"wk wk-file"})]),t._v(" "),i("div",{staticClass:"cell-hd first-show"},[t._v("\n          附件：\n        ")]),t._v(" "),i("div",{staticClass:"cell-bd text-one-line"},[t._v("\n          "+t._s(e.name)+"\n        ")]),t._v(" "),i("div",{staticClass:"cell-ft"},[i("span",{staticClass:"des"},[t._v("（"+t._s(t._f("getFileSize")(e.size))+"）")]),t._v(" "),i("a",{on:{click:function(e){t.previewImg(t.item.fileList,s)}}},[t._v("预览")]),t._v(" "),i("a",{on:{click:function(i){t.downloadFile(e)}}},[t._v("下载")])])])})):t._e(),t._v(" "),t.item.contacts_list&&t.item.contacts_list.length>0?i("div",[i("flexbox",{staticClass:"cell",attrs:{align:"stretch"}},[i("div",{staticClass:"cell-hd"},[i("i",{staticClass:"wk wk-contacts"})]),t._v(" "),i("div",{staticClass:"cell-bd"},[t._v("\n          相关联系人：\n        ")]),t._v(" "),t._l(t.item.contacts_list,function(e,s){return i("div",{key:s,staticClass:"cell-ft__item text-one-line"},[i("a",{on:{click:function(i){t.checkRelationDetail("contacts",e.contacts_id)}}},[t._v(t._s(e.name))])])})],2)],1):t._e(),t._v(" "),t.item.business_list&&t.item.business_list.length>0?i("div",[i("flexbox",{staticClass:"cell",attrs:{align:"stretch"}},[i("div",{staticClass:"cell-hd"},[i("i",{staticClass:"wk wk-business"})]),t._v(" "),i("div",{staticClass:"cell-bd"},[t._v("\n          相关商机：\n        ")]),t._v(" "),i("div",{staticClass:"cell-ft"},t._l(t.item.business_list,function(e,s){return i("div",{key:s,staticClass:"cell-ft__item text-one-line"},[i("a",{on:{click:function(i){t.checkRelationDetail("business",e.business_id)}}},[t._v(t._s(e.name))])])}))])],1):t._e(),t._v(" "),t.item.next_time?i("div",{staticClass:"cell-top"},[i("flexbox",{staticClass:"cell",attrs:{align:"stretch"}},[i("div",{staticClass:"cell-hd"},[i("i",{staticClass:"wk wk-time"})]),t._v(" "),i("div",{staticClass:"cell-bd text-one-line"},[t._v("\n          下次联系时间："+t._s(t.item.next_time)+"\n        ")])])],1):t._e(),t._v(" "),t.item.address?i("div",{staticClass:"cell-top"},[i("flexbox",{staticClass:"cell",attrs:{align:"stretch"}},[i("div",{staticClass:"cell-hd is-address"},[i("i",{staticClass:"wk wk-location"})]),t._v(" "),i("div",{staticClass:"cell-bd text-one-line can-visit--underline",on:{click:function(e){t.checkMapView(t.item)}}},[t._v(t._s(t.item.address))])])],1):t._e()],1),t._v(" "),t.showMapView?i("map-view",{attrs:{title:t.mapViewInfo.title,lat:t.mapViewInfo.lat,lng:t.mapViewInfo.lng},on:{hidden:function(e){t.showMapView=!1}}}):t._e(),t._v(" "),t._t("default")],2)},[],!1,null,"0f095540",null);f.options.__file="LogCell.vue";e.a=f.exports},TDiV:function(t,e,i){},WhDH:function(t,e,i){"use strict";var s=i("fV8c");i.n(s).a},YIeP:function(t,e,i){"use strict";var s=i("4XAY"),n=i("XJYT"),a=i("t2rG"),o={name:"Set",components:{draggable:i.n(a).a},props:{visible:{type:Boolean,required:!0,default:!1},list:Array},data:function(){return{setList:[],isDrag:!1}},computed:{},watch:{list:{handler:function(){this.initInfo()},immediate:!0},visible:function(t){t&&this.initInfo()}},created:function(){},beforeDestroy:function(){},methods:{initInfo:function(){this.setList=this.list.map(function(t){return{value:t}}),0==this.setList.length&&(this.setList=[{value:""}])},close:function(){this.$emit("update:visible",!1)},addClick:function(){this.setList.push({value:""})},deleteClick:function(t){this.setList.splice(t,1)},sureClick:function(){for(var t=this,e=[],i=0;i<this.setList.length;i++){var a=this.setList[i];a.value&&e.push(a.value)}if(0!=e.length){var o=n.Loading.service({target:document.querySelector('.el-dialog[aria-label="常用语管理"]')});Object(s.G)({phrase:e}).then(function(i){o.close(),t.$emit("update",e),t.close()}).catch(function(){o.close()})}else this.$message.error("请输入常用语")},dragEnter:function(){this.isDrag=!0},dragLeave:function(){this.isDrag=!1}}},c=(i("WhDH"),i("KHd+")),l=Object(c.a)(o,function(){var t=this,e=t.$createElement,i=t._self._c||e;return i("el-dialog",{attrs:{visible:t.visible,"append-to-body":!0,"close-on-click-modal":!1,title:"常用语管理",width:"600px"},on:{close:t.close}},[i("div",{staticClass:"set"},[i("draggable",{attrs:{options:{group:"list",forceFallback:!1,fallbackClass:"draggingStyle",filter:".el-input__inner",preventOnFilter:!1}},model:{value:t.setList,callback:function(e){t.setList=e},expression:"setList"}},t._l(t.setList,function(e,s){return i("flexbox",{key:s,staticClass:"set-item",class:{"is-drag":t.isDrag}},[i("el-input",{attrs:{maxlength:100},model:{value:e.value,callback:function(i){t.$set(e,"value",i)},expression:"item.value"}},[i("div",{staticClass:"drag-handle",attrs:{slot:"suffix"},on:{mouseenter:t.dragEnter,mouseleave:t.dragLeave},slot:"suffix"},[t._v("⋮⋮")])]),t._v(" "),i("i",{staticClass:"el-icon-remove",on:{click:function(e){t.deleteClick(s)}}})],1)})),t._v(" "),i("el-button",{attrs:{type:"text",icon:"el-icon-circle-plus"},on:{click:t.addClick}},[t._v("添加常用语")])],1),t._v(" "),i("span",{staticClass:"dialog-footer",attrs:{slot:"footer"},slot:"footer"},[i("el-button",{directives:[{name:"debounce",rawName:"v-debounce",value:t.sureClick,expression:"sureClick"}],attrs:{type:"primary"}},[t._v("保存")])],1)])},[],!1,null,"1acbaeb8",null);l.options.__file="Set.vue";var r={name:"CommonWords",components:{Set:l.exports},props:{},data:function(){return{loading:!1,showPopover:!1,setShow:!1,list:[]}},computed:{},watch:{showPopover:function(t){t&&0==this.list.length&&this.getCommonWords()}},mounted:function(){},beforeDestroy:function(){},methods:{selectScene:function(t,e){this.$emit("select",t),this.showPopover=!1},setClick:function(){this.setShow=!0},getCommonWords:function(){var t=this;this.loading=!0,Object(s.F)().then(function(e){t.loading=!1,t.list=e.data||[]}).catch(function(){t.loading=!1})},udpateCommonWords:function(t){this.list=t}}},u=(i("q0fG"),Object(c.a)(r,function(){var t=this,e=t.$createElement,i=t._self._c||e;return i("el-popover",{attrs:{placement:"bottom",width:"320",trigger:"click","popper-class":"no-padding-popover"},model:{value:t.showPopover,callback:function(e){t.showPopover=e},expression:"showPopover"}},[i("div",{directives:[{name:"loading",rawName:"v-loading",value:t.loading,expression:"loading"}],staticClass:"common-words"},[i("div",{directives:[{name:"empty",rawName:"v-empty",value:t.list&&0==t.list.length,expression:"list && list.length == 0"}],staticClass:"word",attrs:{"xs-empty-icon":"none"}},t._l(t.list,function(e,s){return i("div",{key:s,staticClass:"word-item",on:{click:function(i){t.selectScene(e,s)}}},[t._v("\n        "+t._s(e)+"\n      ")])})),t._v(" "),i("div",{staticClass:"handle-interval"},[i("flexbox",{staticClass:"handle-button",nativeOn:{click:function(e){return t.setClick(e)}}},[i("i",{staticClass:"wk wk-manage handle-button-icon"}),t._v(" "),i("div",{staticClass:"handle-button-name"},[t._v("管理")])])],1)]),t._v(" "),i("el-button",{staticClass:"word-button",attrs:{slot:"reference"},slot:"reference"},[t._v("常用语")]),t._v(" "),i("set",{attrs:{visible:t.setShow,list:t.list},on:{"update:visible":function(e){t.setShow=e},update:t.udpateCommonWords}})],1)},[],!1,null,"6ddd3652",null));u.options.__file="index.vue";e.a=u.exports},"Z+Ht":function(t,e,i){"use strict";e.a={methods:{getXrIcon:function(t){return{leads:"wk wk-leads",customer:"wk wk-customer",contacts:"wk wk-contacts",product:"wk wk-product",business:"wk wk-business",contract:"wk wk-contract",receivables:"wk wk-receivables",invoice:"wk wk-invoice",log:"wk wk-log",examine:"wk wk-approve",task:"wk wk-o-task",record:"wk wk-record"}[t]},getXrIconColor:function(t){return{leads:"#704afd",customer:"#487DFF",contacts:"#27BA4A",product:"#26d4da",business:"#FB9323",contract:"#FD5B4A",receivables:"#FFB940",invoice:"#1cbaf5",log:"#5864FF",approve:"#9376FF",task:"#D376FF",record:"#19B5F6"}[t]}}}},ep8U:function(t,e,i){},fV8c:function(t,e,i){},i2VW:function(t,e,i){},k3SN:function(t,e,i){},paiq:function(t,e,i){"use strict";var s=i("D67r");i.n(s).a},q0fG:function(t,e,i){"use strict";var s=i("ep8U");i.n(s).a},s357:function(t,e,i){"use strict";var s=i("TDiV");i.n(s).a},"uhC+":function(t,e,i){"use strict";var s=i("Aihl");i.n(s).a},vvxI:function(t,e,i){"use strict";e.a={filters:{},methods:{getActivityType:function(t){return{1:"leads",2:"customer",3:"contacts",4:"product",5:"business",6:"contract",7:"receivables",8:"log",9:"examine",10:"schedule",11:"task"}[t]},getActivityTypeName:function(t){return{1:"线索",2:"客户",3:"联系人",4:"产品",5:"商机",6:"合同",7:"回款",8:"日志",9:"审批",10:"日程",11:"任务",12:"发邮件"}[t]},getRecordLogTypeName:function(t){return t?{1:"跟进记录",2:"创建记录",3:"商机阶段变更",4:"外勤签到"}[t]:"跟进记录"}}}},ye9D:function(t,e,i){"use strict";var s={name:"AddFileList",components:{},props:{data:Array},data:function(){return{}},computed:{},watch:{},mounted:function(){},beforeDestroy:function(){},methods:{deleteItem:function(t,e){this.$emit("delete",t,e)},deleteAll:function(){this.$emit("delete-all")}}},n=(i("paiq"),i("KHd+")),a=Object(n.a)(s,function(){var t=this,e=t.$createElement,i=t._self._c||e;return i("section",{staticClass:"file-cont"},[i("flexbox",{staticClass:"f-header"},[i("i",{staticClass:"wk wk-file"}),t._v(" "),i("div",{staticClass:"f-name"},[t._v("附件")])]),t._v(" "),i("div",{staticClass:"f-body"},t._l(t.data,function(e,s){return i("flexbox",{key:s,staticClass:"f-item"},[i("img",{staticClass:"f-img",attrs:{src:e.icon}}),t._v(" "),i("div",{staticClass:"f-name"},[t._v(t._s(e.name)),i("span",{staticClass:"f-size"},[t._v(t._s("（"+e.size+"）"))])]),t._v(" "),i("div",{staticClass:"close-button",on:{click:function(i){t.deleteItem(e,s)}}},[t._v("×")])])})),t._v(" "),i("el-button",{attrs:{type:"text"},on:{click:t.deleteAll}},[t._v("全部删除")])],1)},[],!1,null,"472fadca",null);a.options.__file="AddFileList.vue";e.a=a.exports},zMq1:function(t,e,i){"use strict";var s={name:"AddImageList",components:{},props:{data:Array},data:function(){return{}},computed:{},watch:{},mounted:function(){},beforeDestroy:function(){},methods:{mouseImgOver:function(t,e){t.showDelete=!0,this.$set(this.data,e,t)},mouseImgLeave:function(t,e){t.showDelete=!1,this.$set(this.data,e,t)},deleteItem:function(t,e){this.$emit("delete",t,e)},deleteAll:function(){this.$emit("delete-all")},uploadFile:function(t){this.$emit("upload",t)}}},n=(i("JftJ"),i("KHd+")),a=Object(n.a)(s,function(){var t=this,e=t.$createElement,i=t._self._c||e;return i("section",{staticClass:"img-cont"},[i("flexbox",{attrs:{wrap:"wrap"}},[t._l(t.data,function(e,s){return i("div",{directives:[{name:"src",rawName:"v-src:background-image",value:e.file_path||e.path||e.url,expression:" item.file_path || item.path || item.url",arg:"background-image"}],key:s,staticClass:"img-item",on:{mouseover:function(i){t.mouseImgOver(e,s)},mouseleave:function(i){t.mouseImgLeave(e,s)}}},[e.showDelete?i("div",{staticClass:"img-delete",on:{click:function(i){t.deleteItem(e,s)}}},[t._v("×")]):t._e()])}),t._v(" "),i("div",{staticClass:"img-item-add"},[i("input",{staticClass:"img-item-iput",attrs:{type:"file",accept:"image/*",multiple:""},on:{change:t.uploadFile}})])],2),t._v(" "),i("el-button",{attrs:{type:"text"},on:{click:t.deleteAll}},[t._v("全部删除")])],1)},[],!1,null,"99238776",null);a.options.__file="AddImageList.vue";e.a=a.exports}}]);