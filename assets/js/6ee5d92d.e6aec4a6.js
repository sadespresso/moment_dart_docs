"use strict";(self.webpackChunkmoment_dart_docs=self.webpackChunkmoment_dart_docs||[]).push([[45],{9613:(e,t,n)=>{n.d(t,{Zo:()=>d,kt:()=>f});var r=n(9496);function a(e,t,n){return t in e?Object.defineProperty(e,t,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[t]=n,e}function o(e,t){var n=Object.keys(e);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);t&&(r=r.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),n.push.apply(n,r)}return n}function i(e){for(var t=1;t<arguments.length;t++){var n=null!=arguments[t]?arguments[t]:{};t%2?o(Object(n),!0).forEach((function(t){a(e,t,n[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(n)):o(Object(n)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(n,t))}))}return e}function l(e,t){if(null==e)return{};var n,r,a=function(e,t){if(null==e)return{};var n,r,a={},o=Object.keys(e);for(r=0;r<o.length;r++)n=o[r],t.indexOf(n)>=0||(a[n]=e[n]);return a}(e,t);if(Object.getOwnPropertySymbols){var o=Object.getOwnPropertySymbols(e);for(r=0;r<o.length;r++)n=o[r],t.indexOf(n)>=0||Object.prototype.propertyIsEnumerable.call(e,n)&&(a[n]=e[n])}return a}var c=r.createContext({}),s=function(e){var t=r.useContext(c),n=t;return e&&(n="function"==typeof e?e(t):i(i({},t),e)),n},d=function(e){var t=s(e.components);return r.createElement(c.Provider,{value:t},e.children)},u="mdxType",m={inlineCode:"code",wrapper:function(e){var t=e.children;return r.createElement(r.Fragment,{},t)}},p=r.forwardRef((function(e,t){var n=e.components,a=e.mdxType,o=e.originalType,c=e.parentName,d=l(e,["components","mdxType","originalType","parentName"]),u=s(n),p=a,f=u["".concat(c,".").concat(p)]||u[p]||m[p]||o;return n?r.createElement(f,i(i({ref:t},d),{},{components:n})):r.createElement(f,i({ref:t},d))}));function f(e,t){var n=arguments,a=t&&t.mdxType;if("string"==typeof e||a){var o=n.length,i=new Array(o);i[0]=p;var l={};for(var c in t)hasOwnProperty.call(t,c)&&(l[c]=t[c]);l.originalType=e,l[u]="string"==typeof e?e:a,i[1]=l;for(var s=2;s<o;s++)i[s]=n[s];return r.createElement.apply(null,i)}return r.createElement.apply(null,n)}p.displayName="MDXCreateElement"},1670:(e,t,n)=>{n.r(t),n.d(t,{assets:()=>c,contentTitle:()=>i,default:()=>m,frontMatter:()=>o,metadata:()=>l,toc:()=>s});var r=n(8063),a=(n(9496),n(9613));const o={sidebar_position:3,id:"calendar"},i="Calendar",l={unversionedId:"calendar",id:"version-0.18.1/calendar",title:"Calendar",description:"Usage",source:"@site/versioned_docs/version-0.18.1/calendar.md",sourceDirName:".",slug:"/calendar",permalink:"/moment_dart_docs/0.18.1/calendar",draft:!1,editUrl:"https://github.com/sadespresso/moment_dart_docs/tree/main/versioned_docs/version-0.18.1/calendar.md",tags:[],version:"0.18.1",sidebarPosition:3,frontMatter:{sidebar_position:3,id:"calendar"},sidebar:"docs",previous:{title:"Short forms",permalink:"/moment_dart_docs/0.18.1/duration/short-forms"},next:{title:"Formatting",permalink:"/moment_dart_docs/0.18.1/formatting"}},c={},s=[{value:"Usage",id:"usage",level:2},{value:"Options",id:"options",level:2},{value:"Changing reference",id:"changing-reference",level:3},{value:"Omitting hours",id:"omitting-hours",level:3}],d={toc:s},u="wrapper";function m(e){let{components:t,...n}=e;return(0,a.kt)(u,(0,r.Z)({},d,n,{components:t,mdxType:"MDXLayout"}),(0,a.kt)("h1",{id:"calendar"},"Calendar"),(0,a.kt)("h2",{id:"usage"},"Usage"),(0,a.kt)("pre",null,(0,a.kt)("code",{parentName:"pre",className:"language-dart"},"final Moment now = Moment.now();\n\nprint(now.calendar()); // Today at 03:00 PM\n")),(0,a.kt)("p",null,"If the date is further than 7 days, result will be a date time formatted with\n",(0,a.kt)("inlineCode",{parentName:"p"},"MomentLocalization.localizationDefaultDateFormat"),", and hours omitted."),(0,a.kt)("pre",null,(0,a.kt)("code",{parentName:"pre",className:"language-dart"},"final epoch = Moment.fromMillisecondsSinceEpoch(0);\n\nepoch.calendar(); // 1/1/1970\n")),(0,a.kt)("h2",{id:"options"},"Options"),(0,a.kt)("h3",{id:"changing-reference"},"Changing reference"),(0,a.kt)("p",null,"By default, calendar date is calculated from the current date time. You can\nchange that by providing a custom reference date."),(0,a.kt)("pre",null,(0,a.kt)("code",{parentName:"pre",className:"language-dart"},"var now = DateTime(2023, DateTime.july, 14); // Current time\nvar ref = DateTime(2023, DateTime.july, 15);\n\nnow.calendar(omitHours: true); // Today\nnow.calendar(reference: ref, omitHours: true); // Yesterday\n")),(0,a.kt)("p",null,"Today is Tomorrow's Yesterday... I know, it can be confusing."),(0,a.kt)("h3",{id:"omitting-hours"},"Omitting hours"),(0,a.kt)("p",null,"Example:"),(0,a.kt)("pre",null,(0,a.kt)("code",{parentName:"pre",className:"language-dart"},"var yesterday = Moment.now() - const Duration(days: 1);\n\nyesterday.calendar(); // Yesterday at 01:17 AM\nyesterday.calendar(omitHours: true); // Yesterday\n")),(0,a.kt)("admonition",{type:"info"},(0,a.kt)("p",{parentName:"admonition"},"Hours are omitted if the date is further than 7 days.")))}m.isMDXComponent=!0}}]);