"use strict";(self.webpackChunkmoment_dart_docs=self.webpackChunkmoment_dart_docs||[]).push([[843],{9613:(e,t,n)=>{n.d(t,{Zo:()=>l,kt:()=>f});var r=n(9496);function o(e,t,n){return t in e?Object.defineProperty(e,t,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[t]=n,e}function a(e,t){var n=Object.keys(e);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);t&&(r=r.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),n.push.apply(n,r)}return n}function i(e){for(var t=1;t<arguments.length;t++){var n=null!=arguments[t]?arguments[t]:{};t%2?a(Object(n),!0).forEach((function(t){o(e,t,n[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(n)):a(Object(n)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(n,t))}))}return e}function s(e,t){if(null==e)return{};var n,r,o=function(e,t){if(null==e)return{};var n,r,o={},a=Object.keys(e);for(r=0;r<a.length;r++)n=a[r],t.indexOf(n)>=0||(o[n]=e[n]);return o}(e,t);if(Object.getOwnPropertySymbols){var a=Object.getOwnPropertySymbols(e);for(r=0;r<a.length;r++)n=a[r],t.indexOf(n)>=0||Object.prototype.propertyIsEnumerable.call(e,n)&&(o[n]=e[n])}return o}var c=r.createContext({}),p=function(e){var t=r.useContext(c),n=t;return e&&(n="function"==typeof e?e(t):i(i({},t),e)),n},l=function(e){var t=p(e.components);return r.createElement(c.Provider,{value:t},e.children)},m="mdxType",d={inlineCode:"code",wrapper:function(e){var t=e.children;return r.createElement(r.Fragment,{},t)}},u=r.forwardRef((function(e,t){var n=e.components,o=e.mdxType,a=e.originalType,c=e.parentName,l=s(e,["components","mdxType","originalType","parentName"]),m=p(n),u=o,f=m["".concat(c,".").concat(u)]||m[u]||d[u]||a;return n?r.createElement(f,i(i({ref:t},l),{},{components:n})):r.createElement(f,i({ref:t},l))}));function f(e,t){var n=arguments,o=t&&t.mdxType;if("string"==typeof e||o){var a=n.length,i=new Array(a);i[0]=u;var s={};for(var c in t)hasOwnProperty.call(t,c)&&(s[c]=t[c]);s.originalType=e,s[m]="string"==typeof e?e:o,i[1]=s;for(var p=2;p<a;p++)i[p]=n[p];return r.createElement.apply(null,i)}return r.createElement.apply(null,n)}u.displayName="MDXCreateElement"},7084:(e,t,n)=>{n.r(t),n.d(t,{assets:()=>c,contentTitle:()=>i,default:()=>d,frontMatter:()=>a,metadata:()=>s,toc:()=>p});var r=n(1966),o=(n(9496),n(9613));const a={id:"index"},i="Extension",s={unversionedId:"extension/index",id:"extension/index",title:"Extension",description:"Extensions are helper methods that are not part of the class. We use Dart's",source:"@site/docs/extension/extension.md",sourceDirName:"extension",slug:"/extension/",permalink:"/moment_dart_docs/extension/",draft:!1,editUrl:"https://github.com/sadespresso/moment_dart_docs/tree/main/docs/extension/extension.md",tags:[],version:"current",frontMatter:{id:"index"},sidebar:"docs",previous:{title:"Common mishaps",permalink:"/moment_dart_docs/common-mishaps"},next:{title:"Generic extension methods",permalink:"/moment_dart_docs/extension/generic"}},c={},p=[{value:"Timezone types",id:"timezone-types",level:2}],l={toc:p},m="wrapper";function d(e){let{components:t,...n}=e;return(0,o.kt)(m,(0,r.Z)({},l,n,{components:t,mdxType:"MDXLayout"}),(0,o.kt)("h1",{id:"extension"},"Extension"),(0,o.kt)("p",null,"Extensions are helper methods that are not part of the class. We use Dart's\n",(0,o.kt)("a",{parentName:"p",href:"https://dart.dev/language/extension-methods"},"extension methods"),"."),(0,o.kt)("p",null,"These methods can be called on ",(0,o.kt)("inlineCode",{parentName:"p"},"DateTime"),", and ",(0,o.kt)("inlineCode",{parentName:"p"},"Moment")," objects. (as Moment\nis subclass of DateTime)"),(0,o.kt)("h2",{id:"timezone-types"},"Timezone types"),(0,o.kt)("p",null,"Dart's ",(0,o.kt)("a",{parentName:"p",href:"https://api.dart.dev/stable/dart-core/DateTime-class.html"},"DateTime")," have\ntwo timezone types. Local and UTC."),(0,o.kt)("blockquote",null,(0,o.kt)("p",{parentName:"blockquote"},"A DateTime object is anchored either in the UTC time zone or in the local time\nzone of the current computer when the object is created."),(0,o.kt)("p",{parentName:"blockquote"},"Source: Dart official API docs")))}d.isMDXComponent=!0}}]);