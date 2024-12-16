// mout/object/fillIn@0.11.1 downloaded from https://ga.jspm.io/npm:mout@0.11.1/object/fillIn.js

import"./hasOwn.js";import"./forIn.js";import r from"./forOwn.js";import o from"../array/slice.js";import n from"../array/forEach.js";var a={};var f=n;var i=o;var t=r;function fillIn(r,o){f(i(arguments,1),(function(o){t(o,(function(o,n){null==r[n]&&(r[n]=o)}))}));return r}a=fillIn;var l=a;export default l;

