"use strict";(self.webpackChunkmoment_dart_docs=self.webpackChunkmoment_dart_docs||[]).push([[146],{4732:(t,e,a)=>{a.d(e,{Iu:()=>d,yg:()=>u});var n=a(9100);function l(t,e,a){return e in t?Object.defineProperty(t,e,{value:a,enumerable:!0,configurable:!0,writable:!0}):t[e]=a,t}function r(t,e){var a=Object.keys(t);if(Object.getOwnPropertySymbols){var n=Object.getOwnPropertySymbols(t);e&&(n=n.filter((function(e){return Object.getOwnPropertyDescriptor(t,e).enumerable}))),a.push.apply(a,n)}return a}function o(t){for(var e=1;e<arguments.length;e++){var a=null!=arguments[e]?arguments[e]:{};e%2?r(Object(a),!0).forEach((function(e){l(t,e,a[e])})):Object.getOwnPropertyDescriptors?Object.defineProperties(t,Object.getOwnPropertyDescriptors(a)):r(Object(a)).forEach((function(e){Object.defineProperty(t,e,Object.getOwnPropertyDescriptor(a,e))}))}return t}function i(t,e){if(null==t)return{};var a,n,l=function(t,e){if(null==t)return{};var a,n,l={},r=Object.keys(t);for(n=0;n<r.length;n++)a=r[n],e.indexOf(a)>=0||(l[a]=t[a]);return l}(t,e);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(t);for(n=0;n<r.length;n++)a=r[n],e.indexOf(a)>=0||Object.prototype.propertyIsEnumerable.call(t,a)&&(l[a]=t[a])}return l}var m=n.createContext({}),g=function(t){var e=n.useContext(m),a=e;return t&&(a="function"==typeof t?t(e):o(o({},e),t)),a},d=function(t){var e=g(t.components);return n.createElement(m.Provider,{value:e},t.children)},p="mdxType",c={inlineCode:"code",wrapper:function(t){var e=t.children;return n.createElement(n.Fragment,{},e)}},s=n.forwardRef((function(t,e){var a=t.components,l=t.mdxType,r=t.originalType,m=t.parentName,d=i(t,["components","mdxType","originalType","parentName"]),p=g(a),s=l,u=p["".concat(m,".").concat(s)]||p[s]||c[s]||r;return a?n.createElement(u,o(o({ref:e},d),{},{components:a})):n.createElement(u,o({ref:e},d))}));function u(t,e){var a=arguments,l=e&&e.mdxType;if("string"==typeof t||l){var r=a.length,o=new Array(r);o[0]=s;var i={};for(var m in e)hasOwnProperty.call(e,m)&&(i[m]=e[m]);i.originalType=t,i[p]="string"==typeof t?t:l,o[1]=i;for(var g=2;g<r;g++)o[g]=a[g];return n.createElement.apply(null,o)}return n.createElement.apply(null,a)}s.displayName="MDXCreateElement"},4328:(t,e,a)=>{a.r(e),a.d(e,{assets:()=>m,contentTitle:()=>o,default:()=>c,frontMatter:()=>r,metadata:()=>i,toc:()=>g});var n=a(4731),l=(a(9100),a(4732));const r={sidebar_position:5,id:"localizations"},o="Localizations",i={unversionedId:"localizations",id:"localizations",title:"Localizations",description:"MomentLocalization is responsible for the logic required to convert DateTime to",source:"@site/docs/localizations.md",sourceDirName:".",slug:"/localizations",permalink:"/moment_dart_docs/localizations",draft:!1,editUrl:"https://github.com/sadespresso/moment_dart_docs/tree/main/docs/localizations.md",tags:[],version:"current",sidebarPosition:5,frontMatter:{sidebar_position:5,id:"localizations"},sidebar:"docs",previous:{title:"Formatting",permalink:"/moment_dart_docs/formatting"},next:{title:"Global Localization",permalink:"/moment_dart_docs/global-localization"}},m={},g=[{value:"Get localization",id:"get-localization",level:2},{value:"By language code examples",id:"by-language-code-examples",level:3},{value:"By locale",id:"by-locale",level:3},{value:"Available localizations",id:"available-localizations",level:2}],d={toc:g},p="wrapper";function c(t){let{components:e,...a}=t;return(0,l.yg)(p,(0,n.c)({},d,a,{components:e,mdxType:"MDXLayout"}),(0,l.yg)("h1",{id:"localizations"},"Localizations"),(0,l.yg)("p",null,"MomentLocalization is responsible for the logic required to convert DateTime to\nhuman-readable format. Localizations are lazy-loaded ",(0,l.yg)("strong",{parentName:"p"},"singletons"),". Meaning, they're\ninstantiated only once, and only if you use the localization."),(0,l.yg)("p",null,"See also:"),(0,l.yg)("ul",null,(0,l.yg)("li",{parentName:"ul"},(0,l.yg)("a",{parentName:"li",href:"/moment_dart_docs/creating-localization"},"Implementing a localization")),(0,l.yg)("li",{parentName:"ul"},(0,l.yg)("a",{parentName:"li",href:"https://pub.dev/documentation/moment_dart/latest/moment_dart/MomentLocalization-class.html"},"MomentLocalization class definition"))),(0,l.yg)("h2",{id:"get-localization"},"Get localization"),(0,l.yg)("p",null,"There are number of ways to retreive a localization."),(0,l.yg)("h3",{id:"by-language-code-examples"},"By language code examples"),(0,l.yg)("p",null,"Retreiving ",(0,l.yg)("inlineCode",{parentName:"p"},"MomentLocalization")," by language code returns the first locale that\nmeets the criteria. You can make the criteria narrower by providing optional\n",(0,l.yg)("inlineCode",{parentName:"p"},"countryCode")," and ",(0,l.yg)("inlineCode",{parentName:"p"},"scriptCode")," arguments. By default, it will return the closest\npossible option, even if ",(0,l.yg)("inlineCode",{parentName:"p"},"countryCode")," and/or ",(0,l.yg)("inlineCode",{parentName:"p"},"scriptCode")," doesn't match.\nYou can alter this behavior by setting ",(0,l.yg)("inlineCode",{parentName:"p"},"strict")," to ",(0,l.yg)("inlineCode",{parentName:"p"},"true"),"."),(0,l.yg)("pre",null,(0,l.yg)("code",{parentName:"pre",className:"language-dart"},'MomentLocalizations.byLanguage("mn"); // Returns the instance of LocalizationMnMn\nMomentLocalizations.byLanguage("01"); // Returns null\n')),(0,l.yg)("h3",{id:"by-locale"},"By locale"),(0,l.yg)("admonition",{type:"tip"},(0,l.yg)("p",{parentName:"admonition"},(0,l.yg)("inlineCode",{parentName:"p"},"MomentLocalization.locale")," is a valid ",(0,l.yg)("a",{parentName:"p",href:"https://www.unicode.org/reports/tr35/#Unicode_language_identifier"},"Unicode Language Identifier"))),(0,l.yg)("pre",null,(0,l.yg)("code",{parentName:"pre",className:"language-dart"},'MomentLocalizations.byLocale("en"); // Returns null\nMomentLocalizations.byLanguage("es"); // Returns the instance of LocalizationEsEs\n')),(0,l.yg)("p",null,"When given language-only locale, and fails, ",(0,l.yg)("inlineCode",{parentName:"p"},".byLocale"),' tries locales with same\ncountry code. For example, when given "fr", it will try "fr_FR" in case there\nis no localization for "fr". This is why "en" returned null in the code block\nabove.'),(0,l.yg)("h2",{id:"available-localizations"},"Available localizations"),(0,l.yg)("table",null,(0,l.yg)("thead",{parentName:"table"},(0,l.yg)("tr",{parentName:"thead"},(0,l.yg)("th",{parentName:"tr",align:null},"Code"),(0,l.yg)("th",{parentName:"tr",align:null},"Language"),(0,l.yg)("th",{parentName:"tr",align:null},"Country"),(0,l.yg)("th",{parentName:"tr",align:null},"Class name"))),(0,l.yg)("tbody",{parentName:"table"},(0,l.yg)("tr",{parentName:"tbody"},(0,l.yg)("td",{parentName:"tr",align:null},"de_DE"),(0,l.yg)("td",{parentName:"tr",align:null},"German"),(0,l.yg)("td",{parentName:"tr",align:null},"Germany"),(0,l.yg)("td",{parentName:"tr",align:null},(0,l.yg)("a",{parentName:"td",href:"https://pub.dev/documentation/moment_dart/1.1.1/moment_dart/LocalizationDeDe-class.html"},"LocalizationDeDe"))),(0,l.yg)("tr",{parentName:"tbody"},(0,l.yg)("td",{parentName:"tr",align:null},"en_US"),(0,l.yg)("td",{parentName:"tr",align:null},"English"),(0,l.yg)("td",{parentName:"tr",align:null},"United States"),(0,l.yg)("td",{parentName:"tr",align:null},(0,l.yg)("a",{parentName:"td",href:"https://pub.dev/documentation/moment_dart/1.1.1/moment_dart/LocalizationEnUs-class.html"},"LocalizationEnUs"))),(0,l.yg)("tr",{parentName:"tbody"},(0,l.yg)("td",{parentName:"tr",align:null},"es_ES"),(0,l.yg)("td",{parentName:"tr",align:null},"Spanish"),(0,l.yg)("td",{parentName:"tr",align:null},"Spain"),(0,l.yg)("td",{parentName:"tr",align:null},(0,l.yg)("a",{parentName:"td",href:"https://pub.dev/documentation/moment_dart/1.1.1/moment_dart/LocalizationEsEs-class.html"},"LocalizationEsEs"))),(0,l.yg)("tr",{parentName:"tbody"},(0,l.yg)("td",{parentName:"tr",align:null},"fr_FR"),(0,l.yg)("td",{parentName:"tr",align:null},"French"),(0,l.yg)("td",{parentName:"tr",align:null},"France"),(0,l.yg)("td",{parentName:"tr",align:null},(0,l.yg)("a",{parentName:"td",href:"https://pub.dev/documentation/moment_dart/1.1.1/moment_dart/LocalizationFrFr-class.html"},"LocalizationFrFr"))),(0,l.yg)("tr",{parentName:"tbody"},(0,l.yg)("td",{parentName:"tr",align:null},"pt_PT"),(0,l.yg)("td",{parentName:"tr",align:null},"Portuguese"),(0,l.yg)("td",{parentName:"tr",align:null},"Portuguese Republic"),(0,l.yg)("td",{parentName:"tr",align:null},(0,l.yg)("a",{parentName:"td",href:"https://pub.dev/documentation/moment_dart/1.1.1/moment_dart/LocalizationFrFr-class.html"},"LocalizationPtPT"))),(0,l.yg)("tr",{parentName:"tbody"},(0,l.yg)("td",{parentName:"tr",align:null},"it_IT"),(0,l.yg)("td",{parentName:"tr",align:null},"Italian"),(0,l.yg)("td",{parentName:"tr",align:null},"Italy"),(0,l.yg)("td",{parentName:"tr",align:null},(0,l.yg)("a",{parentName:"td",href:"https://pub.dev/documentation/moment_dart/1.1.1/moment_dart/LocalizationItIt-class.html"},"LocalizationItIt"))),(0,l.yg)("tr",{parentName:"tbody"},(0,l.yg)("td",{parentName:"tr",align:null},"ko_KR"),(0,l.yg)("td",{parentName:"tr",align:null},"Korean"),(0,l.yg)("td",{parentName:"tr",align:null},"Korea, Republic of"),(0,l.yg)("td",{parentName:"tr",align:null},(0,l.yg)("a",{parentName:"td",href:"https://pub.dev/documentation/moment_dart/1.1.1/moment_dart/LocalizationKoKr-class.html"},"LocalizationKoKr"))),(0,l.yg)("tr",{parentName:"tbody"},(0,l.yg)("td",{parentName:"tr",align:null},"ja_JP"),(0,l.yg)("td",{parentName:"tr",align:null},"Japanese"),(0,l.yg)("td",{parentName:"tr",align:null},"Japan"),(0,l.yg)("td",{parentName:"tr",align:null},(0,l.yg)("a",{parentName:"td",href:"https://pub.dev/documentation/moment_dart/1.1.1/moment_dart/LocalizationJaJp-class.html"},"LocalizationJaJp"))),(0,l.yg)("tr",{parentName:"tbody"},(0,l.yg)("td",{parentName:"tr",align:null},"mn_MN"),(0,l.yg)("td",{parentName:"tr",align:null},"Mongolian"),(0,l.yg)("td",{parentName:"tr",align:null},"Mongolia"),(0,l.yg)("td",{parentName:"tr",align:null},(0,l.yg)("a",{parentName:"td",href:"https://pub.dev/documentation/moment_dart/1.1.1/moment_dart/LocalizationMnMn-class.html"},"LocalizationMnMn"))),(0,l.yg)("tr",{parentName:"tbody"},(0,l.yg)("td",{parentName:"tr",align:null},"mn_Mong_MN"),(0,l.yg)("td",{parentName:"tr",align:null},"Traditional Mongolian with Arabic numbers"),(0,l.yg)("td",{parentName:"tr",align:null},"Mongolia"),(0,l.yg)("td",{parentName:"tr",align:null},(0,l.yg)("a",{parentName:"td",href:"https://pub.dev/documentation/moment_dart/1.1.1/moment_dart/LocalizationMnMongMn-class.html"},"LocalizationMnMongMn"))),(0,l.yg)("tr",{parentName:"tbody"},(0,l.yg)("td",{parentName:"tr",align:null},"mn_Qaaq_MN"),(0,l.yg)("td",{parentName:"tr",align:null},"Traditional Mongolian with Traditional Numbers"),(0,l.yg)("td",{parentName:"tr",align:null},"Mongolia"),(0,l.yg)("td",{parentName:"tr",align:null},(0,l.yg)("a",{parentName:"td",href:"https://pub.dev/documentation/moment_dart/1.1.1/moment_dart/LocalizationMnQaaqMn-class.html"},"LocalizationMnQaaqMn"))),(0,l.yg)("tr",{parentName:"tbody"},(0,l.yg)("td",{parentName:"tr",align:null},"zh_CN"),(0,l.yg)("td",{parentName:"tr",align:null},"Simplified Chinese"),(0,l.yg)("td",{parentName:"tr",align:null},"China"),(0,l.yg)("td",{parentName:"tr",align:null},(0,l.yg)("a",{parentName:"td",href:"https://pub.dev/documentation/moment_dart/1.1.1/moment_dart/LocalizationZhCn-class.html"},"LocalizationZhCn"))))))}c.isMDXComponent=!0}}]);