"use strict";(self.webpackChunkmoment_dart_docs=self.webpackChunkmoment_dart_docs||[]).push([[844],{4732:(e,t,n)=>{n.d(t,{Iu:()=>p,yg:()=>d});var a=n(9100);function o(e,t,n){return t in e?Object.defineProperty(e,t,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[t]=n,e}function i(e,t){var n=Object.keys(e);if(Object.getOwnPropertySymbols){var a=Object.getOwnPropertySymbols(e);t&&(a=a.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),n.push.apply(n,a)}return n}function l(e){for(var t=1;t<arguments.length;t++){var n=null!=arguments[t]?arguments[t]:{};t%2?i(Object(n),!0).forEach((function(t){o(e,t,n[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(n)):i(Object(n)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(n,t))}))}return e}function r(e,t){if(null==e)return{};var n,a,o=function(e,t){if(null==e)return{};var n,a,o={},i=Object.keys(e);for(a=0;a<i.length;a++)n=i[a],t.indexOf(n)>=0||(o[n]=e[n]);return o}(e,t);if(Object.getOwnPropertySymbols){var i=Object.getOwnPropertySymbols(e);for(a=0;a<i.length;a++)n=i[a],t.indexOf(n)>=0||Object.prototype.propertyIsEnumerable.call(e,n)&&(o[n]=e[n])}return o}var c=a.createContext({}),s=function(e){var t=a.useContext(c),n=t;return e&&(n="function"==typeof e?e(t):l(l({},t),e)),n},p=function(e){var t=s(e.components);return a.createElement(c.Provider,{value:t},e.children)},m="mdxType",u={inlineCode:"code",wrapper:function(e){var t=e.children;return a.createElement(a.Fragment,{},t)}},g=a.forwardRef((function(e,t){var n=e.components,o=e.mdxType,i=e.originalType,c=e.parentName,p=r(e,["components","mdxType","originalType","parentName"]),m=s(n),g=o,d=m["".concat(c,".").concat(g)]||m[g]||u[g]||i;return n?a.createElement(d,l(l({ref:t},p),{},{components:n})):a.createElement(d,l({ref:t},p))}));function d(e,t){var n=arguments,o=t&&t.mdxType;if("string"==typeof e||o){var i=n.length,l=new Array(i);l[0]=g;var r={};for(var c in t)hasOwnProperty.call(t,c)&&(r[c]=t[c]);r.originalType=e,r[m]="string"==typeof e?e:o,l[1]=r;for(var s=2;s<i;s++)l[s]=n[s];return a.createElement.apply(null,l)}return a.createElement.apply(null,n)}g.displayName="MDXCreateElement"},4760:(e,t,n)=>{n.r(t),n.d(t,{assets:()=>c,contentTitle:()=>l,default:()=>u,frontMatter:()=>i,metadata:()=>r,toc:()=>s});var a=n(4731),o=(n(9100),n(4732));const i={sidebar_position:6,id:"global-localization"},l="Global Localization",r={unversionedId:"global-localization",id:"global-localization",title:"Global Localization",description:"By default, global localization is set to en_US. You can set the global",source:"@site/docs/global-localization.md",sourceDirName:".",slug:"/global-localization",permalink:"/moment_dart_docs/global-localization",draft:!1,editUrl:"https://github.com/sadespresso/moment_dart_docs/tree/main/docs/global-localization.md",tags:[],version:"current",sidebarPosition:6,frontMatter:{sidebar_position:6,id:"global-localization"},sidebar:"docs",previous:{title:"Localizations",permalink:"/moment_dart_docs/localizations"},next:{title:"Implementing localization",permalink:"/moment_dart_docs/creating-localization"}},c={},s=[],p={toc:s},m="wrapper";function u(e){let{components:t,...n}=e;return(0,o.yg)(m,(0,a.c)({},p,n,{components:t,mdxType:"MDXLayout"}),(0,o.yg)("h1",{id:"global-localization"},"Global Localization"),(0,o.yg)("p",null,"By default, global localization is set to ",(0,o.yg)("inlineCode",{parentName:"p"},"en_US"),". You can set the global\nlocalization by calling ",(0,o.yg)("inlineCode",{parentName:"p"},"Moment.setGlobalLocalization"),"."),(0,o.yg)("pre",null,(0,o.yg)("code",{parentName:"pre",className:"language-dart"},"Moment.setGlobalLocalization(MomentLocalizations.fr());\n")),(0,o.yg)("p",null,"After setting the global localization, every new instance, and any existing\ninstance with no explicit localization set will use the new global localization."),(0,o.yg)("admonition",{type:"warning"},(0,o.yg)("p",{parentName:"admonition"},"This instance wouldn't be affected by the global localization because it has\nlocalization set on instance-level."),(0,o.yg)("pre",{parentName:"admonition"},(0,o.yg)("code",{parentName:"pre",className:"language-dart"},"final instanceKoKr = Moment.now(localization: MomentLocalizations.koKr());\n")),(0,o.yg)("p",{parentName:"admonition"},"You can check whether an instance is using global localization with ",(0,o.yg)("inlineCode",{parentName:"p"},".hasExplicitLocalization")),(0,o.yg)("pre",{parentName:"admonition"},(0,o.yg)("code",{parentName:"pre",className:"language-dart"},"// Not using explicit localization\nassert(instanceKoKr.hasExplicitLocalization); // true\n\n// Using global localization\nassert(Moment.now().hasExplicitLocalization); // false\n"))))}u.isMDXComponent=!0}}]);