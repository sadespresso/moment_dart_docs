"use strict";(self.webpackChunkmoment_dart_docs=self.webpackChunkmoment_dart_docs||[]).push([[790],{9613:(e,t,n)=>{n.d(t,{Zo:()=>s,kt:()=>k});var a=n(9496);function r(e,t,n){return t in e?Object.defineProperty(e,t,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[t]=n,e}function i(e,t){var n=Object.keys(e);if(Object.getOwnPropertySymbols){var a=Object.getOwnPropertySymbols(e);t&&(a=a.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),n.push.apply(n,a)}return n}function o(e){for(var t=1;t<arguments.length;t++){var n=null!=arguments[t]?arguments[t]:{};t%2?i(Object(n),!0).forEach((function(t){r(e,t,n[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(n)):i(Object(n)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(n,t))}))}return e}function l(e,t){if(null==e)return{};var n,a,r=function(e,t){if(null==e)return{};var n,a,r={},i=Object.keys(e);for(a=0;a<i.length;a++)n=i[a],t.indexOf(n)>=0||(r[n]=e[n]);return r}(e,t);if(Object.getOwnPropertySymbols){var i=Object.getOwnPropertySymbols(e);for(a=0;a<i.length;a++)n=i[a],t.indexOf(n)>=0||Object.prototype.propertyIsEnumerable.call(e,n)&&(r[n]=e[n])}return r}var p=a.createContext({}),m=function(e){var t=a.useContext(p),n=t;return e&&(n="function"==typeof e?e(t):o(o({},t),e)),n},s=function(e){var t=m(e.components);return a.createElement(p.Provider,{value:t},e.children)},c="mdxType",u={inlineCode:"code",wrapper:function(e){var t=e.children;return a.createElement(a.Fragment,{},t)}},d=a.forwardRef((function(e,t){var n=e.components,r=e.mdxType,i=e.originalType,p=e.parentName,s=l(e,["components","mdxType","originalType","parentName"]),c=m(n),d=r,k=c["".concat(p,".").concat(d)]||c[d]||u[d]||i;return n?a.createElement(k,o(o({ref:t},s),{},{components:n})):a.createElement(k,o({ref:t},s))}));function k(e,t){var n=arguments,r=t&&t.mdxType;if("string"==typeof e||r){var i=n.length,o=new Array(i);o[0]=d;var l={};for(var p in t)hasOwnProperty.call(t,p)&&(l[p]=t[p]);l.originalType=e,l[c]="string"==typeof e?e:r,o[1]=l;for(var m=2;m<i;m++)o[m]=n[m];return a.createElement.apply(null,o)}return a.createElement.apply(null,n)}d.displayName="MDXCreateElement"},9121:(e,t,n)=>{n.r(t),n.d(t,{assets:()=>p,contentTitle:()=>o,default:()=>u,frontMatter:()=>i,metadata:()=>l,toc:()=>m});var a=n(7622),r=(n(9496),n(9613));const i={sidebar_position:1,id:"generic"},o="Generic extension methods",l={unversionedId:"extension/generic",id:"version-0.18.1/extension/generic",title:"Generic extension methods",description:"Usage",source:"@site/versioned_docs/version-0.18.1/extension/generic.md",sourceDirName:"extension",slug:"/extension/generic",permalink:"/moment_dart_docs/0.18.1/extension/generic",draft:!1,editUrl:"https://github.com/sadespresso/moment_dart_docs/tree/main/versioned_docs/version-0.18.1/extension/generic.md",tags:[],version:"0.18.1",sidebarPosition:1,frontMatter:{sidebar_position:1,id:"generic"},sidebar:"docs",previous:{title:"Extension",permalink:"/moment_dart_docs/0.18.1/extension/"},next:{title:"Start of year/month/.../second",permalink:"/moment_dart_docs/0.18.1/extension/startOf"}},p={},m=[{value:"Usage",id:"usage",level:2},{value:"List of extensions",id:"list-of-extensions",level:2},{value:"Getters",id:"getters",level:3},{value:"Methods",id:"methods",level:3},{value:"Operators",id:"operators",level:3}],s={toc:m},c="wrapper";function u(e){let{components:t,...n}=e;return(0,r.kt)(c,(0,a.Z)({},s,n,{components:t,mdxType:"MDXLayout"}),(0,r.kt)("h1",{id:"generic-extension-methods"},"Generic extension methods"),(0,r.kt)("h2",{id:"usage"},"Usage"),(0,r.kt)("pre",null,(0,r.kt)("code",{parentName:"pre",className:"language-dart"},"DateTime(1900).isLeapYear; // false\n\nDateTime(2023, DateTime.july, 14).week; // \n")),(0,r.kt)("p",null,"Operators"),(0,r.kt)("pre",null,(0,r.kt)("code",{parentName:"pre",className:"language-dart"},"// Moon landing happened before present time\nDateTime(1969, DateTime.july, 20) < now; // true\n\nDateTime.utc(1970) == DateTime.fromMillisecondsSinceEpoch(0, isUtc: true); // true\n")),(0,r.kt)("h2",{id:"list-of-extensions"},"List of extensions"),(0,r.kt)("h3",{id:"getters"},"Getters"),(0,r.kt)("ul",null,(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("p",{parentName:"li"},"date"),(0,r.kt)("p",{parentName:"li"},"Returns new object with hours, minutes, ..., microseconds omitted")),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("p",{parentName:"li"},"isLeapYear")),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("p",{parentName:"li"},"hour12")),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("p",{parentName:"li"},"isAm")),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("p",{parentName:"li"},"isPm")),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("p",{parentName:"li"},"quarter")),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("p",{parentName:"li"},"week"),(0,r.kt)("p",{parentName:"li"},(0,r.kt)("a",{parentName:"p",href:"https://en.wikipedia.org/wiki/ISO_week_date"},"ISO Week")," number")),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("p",{parentName:"li"},"weekYear"),(0,r.kt)("p",{parentName:"li"},"Year according to ",(0,r.kt)("a",{parentName:"p",href:"https://en.wikipedia.org/wiki/ISO_week_date"},"ISO Week"))),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("p",{parentName:"li"},"dayOfYear"),(0,r.kt)("p",{parentName:"li"},"  Ordinal day of the year"),(0,r.kt)("ul",{parentName:"li"},(0,r.kt)("li",{parentName:"ul"},"January 1st => 1"),(0,r.kt)("li",{parentName:"ul"},"December 31st => 365 (or 366 if ",(0,r.kt)("inlineCode",{parentName:"li"},"isLeapYear"),")")))),(0,r.kt)("h3",{id:"methods"},"Methods"),(0,r.kt)("ul",null,(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("p",{parentName:"li"},"differenceInDays")),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("p",{parentName:"li"},"timeZoneFormatted")),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("p",{parentName:"li"},"clone()"),(0,r.kt)("p",{parentName:"li"},"Returns object of same type as the original."),(0,r.kt)("pre",{parentName:"li"},(0,r.kt)("code",{parentName:"pre",className:"language-dart"},"Moment().clone(); // A new Moment instance\nDateTime().clone(); // A new DateTime instance\n"))),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("p",{parentName:"li"},"toMoment({MomentLocalization? localization})")),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("p",{parentName:"li"},"format({\nString payload = MomentLocalization.localizationDefaultDateFormat,\nbool forceLocal = false,\nMomentLocalization? localization,\n})"),(0,r.kt)("p",{parentName:"li"},"Format ",(0,r.kt)("inlineCode",{parentName:"p"},"DateTime")," objects without need of creating ",(0,r.kt)("inlineCode",{parentName:"p"},"Moment"),". (Not really\nrecommended, no point in avoiding Moment)"))),(0,r.kt)("h3",{id:"operators"},"Operators"),(0,r.kt)("p",null,"Now you can use operators on ",(0,r.kt)("inlineCode",{parentName:"p"},"DateTime")," (and ",(0,r.kt)("inlineCode",{parentName:"p"},"Moment"),") objects"),(0,r.kt)("ul",null,(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("p",{parentName:"li"},(0,r.kt)("inlineCode",{parentName:"p"},"+(other)")),(0,r.kt)("p",{parentName:"li"},"is equivalent to ",(0,r.kt)("inlineCode",{parentName:"p"},"add(other)"))),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("p",{parentName:"li"},(0,r.kt)("inlineCode",{parentName:"p"},"-(other)")),(0,r.kt)("p",{parentName:"li"},"is equivalent to ",(0,r.kt)("inlineCode",{parentName:"p"},"subtract(other)"))),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("p",{parentName:"li"},(0,r.kt)("inlineCode",{parentName:"p"},">(other)")),(0,r.kt)("p",{parentName:"li"},"is equivalent to ",(0,r.kt)("inlineCode",{parentName:"p"},"isAfter(other)"))),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("p",{parentName:"li"},(0,r.kt)("inlineCode",{parentName:"p"},"<(other)")),(0,r.kt)("p",{parentName:"li"},"is equivalent to ",(0,r.kt)("inlineCode",{parentName:"p"},"isBefore(other)"))),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("p",{parentName:"li"},(0,r.kt)("inlineCode",{parentName:"p"},">=(other)")),(0,r.kt)("p",{parentName:"li"},"is equivalent to ",(0,r.kt)("inlineCode",{parentName:"p"},"isAfter(other) || isAtSameMomentAs(other)"))),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("p",{parentName:"li"},(0,r.kt)("inlineCode",{parentName:"p"},"<=(other)")),(0,r.kt)("p",{parentName:"li"},"is equivalent to ",(0,r.kt)("inlineCode",{parentName:"p"},"isBefore(other) || isAtSameMomentAs(other)")))))}u.isMDXComponent=!0}}]);