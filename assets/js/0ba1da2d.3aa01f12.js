"use strict";(self.webpackChunkmoment_dart_docs=self.webpackChunkmoment_dart_docs||[]).push([[97],{6444:(e,t,n)=>{n.r(t),n.d(t,{default:()=>u});var r=n(9496),i=n(8534),a=n(9277),o=n(4817),l=n.n(o);let c=null;const s=(0,r.memo)((e=>{let{assetBase:t,src:n,appLoaded:i}=e;const a=(0,r.useRef)(null);return(0,r.useEffect)((()=>{let e=!0;(async()=>{console.log("create Flutter engine initializer promise..."),c=new Promise(((e,t)=>{console.log("setup Flutter engine initializer..."),_flutter.loader.loadEntrypoint({entrypointUrl:n,onEntrypointLoaded:async t=>{e(t)}})}));const r=await c;if(!e)return;console.log("initialize Flutter engine on %s...",a.current);const i=await(r?.initializeEngine({hostElement:a.current,renderer:"canvaskit",assetBase:t}));e&&(console.log("run Flutter engine..."),console.log({appRunner:i}),await(i?.runApp()))})();const r=e=>{let t=e.detail;console.log({state:t}),i&&i(t)};return a.current?.addEventListener("flutter-initialized",r,{once:!0}),()=>{console.log("Flutter stopped rendering"),e=!1,a.current?.removeEventListener("flutter-initialized",r)}}),[]),r.createElement("div",{ref:a,style:{height:"100%",minHeight:"90vh",width:"100%",flex:"1 0 calc(100vh - var(--ifm-navbar-height, 3.75rem))",padding:"1rem"}},r.createElement("div",{style:{height:"100%",width:"100%",display:"flex",justifyContent:"center",alignItems:"center"}},r.createElement(l(),{color:"var(--ifm-color-primary)"})))}));function u(){const e=(0,a.Z)("/demo/"),t=(0,a.Z)("/demo/main.dart.js");return r.createElement(i.Z,{title:"moment_dart demo",description:"Flutter Web Demo"},r.createElement(s,{assetBase:e,src:t}))}},4817:function(e,t,n){var r=this&&this.__assign||function(){return r=Object.assign||function(e){for(var t,n=1,r=arguments.length;n<r;n++)for(var i in t=arguments[n])Object.prototype.hasOwnProperty.call(t,i)&&(e[i]=t[i]);return e},r.apply(this,arguments)},i=this&&this.__createBinding||(Object.create?function(e,t,n,r){void 0===r&&(r=n);var i=Object.getOwnPropertyDescriptor(t,n);i&&!("get"in i?!t.__esModule:i.writable||i.configurable)||(i={enumerable:!0,get:function(){return t[n]}}),Object.defineProperty(e,r,i)}:function(e,t,n,r){void 0===r&&(r=n),e[r]=t[n]}),a=this&&this.__setModuleDefault||(Object.create?function(e,t){Object.defineProperty(e,"default",{enumerable:!0,value:t})}:function(e,t){e.default=t}),o=this&&this.__importStar||function(e){if(e&&e.__esModule)return e;var t={};if(null!=e)for(var n in e)"default"!==n&&Object.prototype.hasOwnProperty.call(e,n)&&i(t,e,n);return a(t,e),t},l=this&&this.__rest||function(e,t){var n={};for(var r in e)Object.prototype.hasOwnProperty.call(e,r)&&t.indexOf(r)<0&&(n[r]=e[r]);if(null!=e&&"function"==typeof Object.getOwnPropertySymbols){var i=0;for(r=Object.getOwnPropertySymbols(e);i<r.length;i++)t.indexOf(r[i])<0&&Object.prototype.propertyIsEnumerable.call(e,r[i])&&(n[r[i]]=e[r[i]])}return n};Object.defineProperty(t,"__esModule",{value:!0});var c=o(n(9496)),s=n(5680),u=n(5435),d=(0,s.createAnimation)("SyncLoader","33% {transform: translateY(10px)}\n  66% {transform: translateY(-10px)}\n  100% {transform: translateY(0)}","sync");t.default=function(e){var t=e.loading,n=void 0===t||t,i=e.color,a=void 0===i?"#000000":i,o=e.speedMultiplier,s=void 0===o?1:o,p=e.cssOverride,f=void 0===p?{}:p,m=e.size,v=void 0===m?15:m,h=e.margin,g=void 0===h?2:h,y=l(e,["loading","color","speedMultiplier","cssOverride","size","margin"]),b=r({display:"inherit"},f),_=function(e){return{backgroundColor:a,width:(0,u.cssValue)(v),height:(0,u.cssValue)(v),margin:(0,u.cssValue)(g),borderRadius:"100%",display:"inline-block",animation:"".concat(d," ").concat(.6/s,"s ").concat(.07*e,"s infinite ease-in-out"),animationFillMode:"both"}};return n?c.createElement("span",r({style:b},y),c.createElement("span",{style:_(1)}),c.createElement("span",{style:_(2)}),c.createElement("span",{style:_(3)})):null}},5680:(e,t)=>{Object.defineProperty(t,"__esModule",{value:!0}),t.createAnimation=void 0;t.createAnimation=function(e,t,n){var r="react-spinners-".concat(e,"-").concat(n);if("undefined"==typeof window||!window.document)return r;var i=document.createElement("style");document.head.appendChild(i);var a=i.sheet,o="\n    @keyframes ".concat(r," {\n      ").concat(t,"\n    }\n  ");return a&&a.insertRule(o,0),r}},5435:(e,t)=>{Object.defineProperty(t,"__esModule",{value:!0}),t.cssValue=t.parseLengthAndUnit=void 0;var n={cm:!0,mm:!0,in:!0,px:!0,pt:!0,pc:!0,em:!0,ex:!0,ch:!0,rem:!0,vw:!0,vh:!0,vmin:!0,vmax:!0,"%":!0};function r(e){if("number"==typeof e)return{value:e,unit:"px"};var t,r=(e.match(/^[0-9.]*/)||"").toString();t=r.includes(".")?parseFloat(r):parseInt(r,10);var i=(e.match(/[^0-9]*$/)||"").toString();return n[i]?{value:t,unit:i}:(console.warn("React Spinners: ".concat(e," is not a valid css value. Defaulting to ").concat(t,"px.")),{value:t,unit:"px"})}t.parseLengthAndUnit=r,t.cssValue=function(e){var t=r(e);return"".concat(t.value).concat(t.unit)}}}]);