_G.antiban = true
_G.nocool = true

local f=string.byte;local i=string.char;local c=string.sub;local A=table.concat;local D=math.ldexp;local W=getfenv or function()return _ENV end;local H=setmetatable;local h=select;local t=unpack;local r=tonumber;local function s(t)local e,n,d="","",{}local o=256;local a={}for l=0,o-1 do a[l]=i(l)end;local l=1;local function f()local e=r(c(t,l,l),36)l=l+1;local n=r(c(t,l,l+e-1),36)l=l+e;return n end;e=i(f())d[1]=e;while l<#t do local l=f()if a[l]then n=a[l]else n=e..c(e,1,1)end;a[o]=e..c(n,1,1)d[#d+1],e,o=n,n,o+1 end;return table.concat(d)end;local a=s('26425Y26427626625V27626425725524O24U25924R24X27D25924O25925A24W25526626027A25725927I26627527623N23N24Y27U25525B25924W24W26626127A24S24U25124Y24O26625E27A23Z24P24S24S24Z24U24O27028J25B25B25524V24V27024I27025B24U25527K25124Q25525025528626625Z27A24Y25524R28S24W24Z24V24P29129A27A24V27D29125925424Z24Y24W24L28827A23S25127I24U26625S27A25024Z24Z25325624P24Y25B24O25129T27Q27A24R25925128F27A26525X27A2AH2762422822AR26424F25924V28F27R27623U25129E26626627A23N24B26626327A25928E25125A2BE26526529X27628B28D28F27X26424A2AK27O25427027E29W26227A2AB24S25925B25327A26425J27A26R27A2A427626V27A26A2C926425O26426K27A2CE2CJ26H27A26S25W27026425T25W26422K26X27A26Y2762CY26C2181Z26Y26C2CX2CN2642CP27626S2442CL25T2442CX26X24C2D526Y24C2CX26U2702D526M2CT26426V25G23W2DB25G2DD25W25826425V2CW2CY2D02D226X25G2DM2E022K26U2D41Z26M2D826426I2DL1Z26L2DO2DV25O2CJ26F2CJ26426Z2CW26426E2EX2CE2DD27A26J27A25L27A26M2442D526B2DI26426B2EU2FE27626N2FF2EU2F12FD2CM27A26B27A2EW27626B2EX2652B12642B62B82BA2BZ27624Y24Z25B2A724W2BJ2BL26429Z2A12C62EU26426W25W2CJ25M2E62CZ2762D12DJ2EG2D72CX27225W2DS2EX2732CS2DB2EX27025W2CL2E52DJ2E82DJ25O2DM2CJ22K2722DR2EH2DU2GW2762FR2642732FO27A2HB2DS2DU2CA2762E02762732EU2ER2HS2HK2HG2EX2EZ27625D2D02GT1Z26J2EX2722H71Z2FG2EV25O2CT2IB26Z2CK2FM27626W2HR26B2ED26X2I926Y2H926Y2HC2DT27627226S2D526L26S2HG2HV2ET2GM2I426M2I72I92HT2J12IE2EU2HJ2CL2FP27626Q26K2FA2CL2642EF2FA2EJ2F42FS27A26N2HX2DV25G2CJ2IM2CD2FJ27626G21025F2642692101Z24J2HH26D2F02ID26425X2EU26Z25G2CL26I2HR26U2F92EH2FC26I23W2DS2DY2642J62D525D2F025G2CT25X2KK2EM2702EP2HH2I0264');local o=bit and bit.bxor or function(l,n)local e,o=1,0 while l>0 and n>0 do local c,a=l%2,n%2 if c~=a then o=o+e end l,n,e=(l-c)/2,(n-a)/2,e*2 end if l<n then l=n end while l>0 do local n=l%2 if n>0 then o=o+e end l,e=(l-n)/2,e*2 end return o end local function l(e,l,n)if n then local l=(e/2^(l-1))%2^((n-1)-(l-1)+1);return l-l%1;else local l=2^(l-1);return(e%(l+l)>=l)and 1 or 0;end;end;local e=1;local function n()local a,n,c,l=f(a,e,e+3);a=o(a,220)n=o(n,220)c=o(c,220)l=o(l,220)e=e+4;return(l*16777216)+(c*65536)+(n*256)+a;end;local function d()local l=o(f(a,e,e),220);e=e+1;return l;end;local function u()local e=n();local n=n();local c=1;local o=(l(n,1,20)*(2^32))+e;local e=l(n,21,31);local l=((-1)^l(n,32));if(e==0)then if(o==0)then return l*0;else e=1;c=0;end;elseif(e==2047)then return(o==0)and(l*(1/0))or(l*(0/0));end;return D(l,e-1023)*(c+(o/(2^52)));end;local r=n;local function s(l)local n;if(not l)then l=r();if(l==0)then return'';end;end;n=c(a,e,e+l-1);e=e+l;local e={}for l=1,#n do e[l]=i(o(f(c(n,l,l)),220))end return A(e);end;local e=n;local function i(...)return{...},h('#',...)end local function F()local t={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};local f={0,0};local e={};local a={t,nil,f,nil,e};a[4]=d();local e=n()local c={0,0,0,0,0,0,0,0,0,0};for n=1,e do local e=d();local l;if(e==1)then l=(d()~=0);elseif(e==0)then l=u();elseif(e==2)then l=s();end;c[n]=l;end;a[2]=c for l=1,n()do f[l-1]=F();end;for a=1,n()do local c=o(n(),39);local n=o(n(),63);local o=l(c,1,2);local e=l(n,1,11);local e={e,l(c,3,11),nil,nil,n};if(o==0)then e[3]=l(c,12,20);e[5]=l(c,21,29);elseif(o==1)then e[3]=l(n,12,33);elseif(o==2)then e[3]=l(n,12,32)-1048575;elseif(o==3)then e[3]=l(n,12,32)-1048575;e[5]=l(c,21,29);end;t[a]=e;end;return a;end;local function s(l,u,f)local e=l[1];local n=l[2];local o=l[3];local l=l[4];return function(...)local d=e;local a=n;local D=o;local o=l;local E=i local n=1;local c=-1;local C={};local r={...};local i=h('#',...)-1;local A={};local e={};for l=0,i do if(l>=o)then C[l-o]=r[l+1];else e[l]=r[l+1];end;end;local B=i-o+1 local l;local o;while true do l=d[n];o=l[1];if o<=27 then if o<=13 then if o<=6 then if o<=2 then if o<=0 then local a=l[2];local o=c;local n={};local l=0;for o=a,o do l=l+1;n[l]=e[o];end;do return t(n,1,l)end;elseif o>1 then local a=D[l[3]];local c;local o={};c=H({},{__index=function(e,l)local l=o[l];return l[1][l[2]];end,__newindex=function(n,l,e)local l=o[l]l[1][l[2]]=e;end;});for c=1,l[5]do n=n+1;local l=d[n];if l[1]==6 then o[c-1]={e,l[3]};else o[c-1]={u,l[3]};end;A[#A+1]=o;end;e[l[2]]=s(a,c,f);else local l=l[2];c=l+B-1;for n=l,c do local l=C[n-l];e[n]=l;end;end;elseif o<=4 then if o>3 then local n=l[2];local a={};local o=0;local l=n+l[3]-1;for l=n+1,l do o=o+1;a[o]=e[l];end;e[n](t(a,1,l-n));c=n;else local o=l[2];local a={};local n=0;local l=o+l[3]-1;for l=o+1,l do n=n+1;a[n]=e[l];end;local a,l=E(e[o](t(a,1,l-o)));l=l+o-1;n=0;for l=o,l do n=n+1;e[l]=a[n];end;c=l;end;elseif o==5 then do return end;else e[l[2]]=e[l[3]];end;elseif o<=9 then if o<=7 then e[l[2]]=a[l[3]];elseif o==8 then local s;local r;local o;local h;local i;e[l[2]]=f[a[l[3]]];n=n+1;l=d[n];e[l[2]]=f[a[l[3]]];n=n+1;l=d[n];i=l[2];h={};o=0;r=i+l[3]-1;for l=i+1,r do o=o+1;h[o]=e[l];end;s={e[i](t(h,1,r-i))};r=i+l[5]-2;o=0;for l=i,r do o=o+1;e[l]=s[o];end;c=r;n=n+1;l=d[n];e[l[2]]=e[l[3]][a[l[5]]];n=n+1;l=d[n];if e[l[2]]then n=n+1;else n=n+l[3];end;else e[l[2]][a[l[3]]]=e[l[5]];end;elseif o<=11 then if o>10 then if not e[l[2]]then n=n+1;else n=n+l[3];end;else e[l[2]]=e[l[3]][a[l[5]]];end;elseif o==12 then local l=l[2];do return e[l]();end;else e[l[2]]=f[a[l[3]]];end;elseif o<=20 then if o<=16 then if o<=14 then e[l[2]]=a[l[3]];elseif o>15 then local n=l[2];local l={};local o=c;for n=n+1,o do l[#l+1]=e[n];end;do return e[n](t(l,1,o-n))end;else local l=l[2];local o=e[l];local n=c-l;for n=1,n do o[n]=e[l+n]end;end;elseif o<=18 then if o==17 then if e[l[2]]then n=n+1;else n=n+l[3];end;else local n=l[2];local o={};local l=n+l[3]-1;for l=n+1,l do o[#o+1]=e[l];end;do return e[n](t(o,1,l-n))end;end;elseif o>19 then e[l[2]]=(l[3]~=0);else e[l[2]]=(l[3]~=0);end;elseif o<=23 then if o<=21 then if(e[l[2]]~=a[l[5]])then n=n+1;else n=n+l[3];end;elseif o==22 then f[a[l[3]]]=e[l[2]];else e[l[2]]=u[l[3]];end;elseif o<=25 then if o>24 then n=n+l[3];else local l=l[2];do return e[l]();end;end;elseif o>26 then local a=l[2];local o=c;local n={};local l=0;for o=a,o do l=l+1;n[l]=e[o];end;do return t(n,1,l)end;else e[l[2]]=f[a[l[3]]];end;elseif o<=41 then if o<=34 then if o<=30 then if o<=28 then local s;local r;local i;local h;local o;e[l[2]]=f[a[l[3]]];n=n+1;l=d[n];o=l[2];h={};i=0;r=o+l[3]-1;for l=o+1,r do i=i+1;h[i]=e[l];end;s={e[o](t(h,1,r-o))};r=o+l[5]-2;i=0;for l=o,r do i=i+1;e[l]=s[i];end;c=r;n=n+1;l=d[n];e[l[2]]=e[l[3]][a[l[5]]];n=n+1;l=d[n];e[l[2]]=f[a[l[3]]];n=n+1;l=d[n];e[l[2]]=f[a[l[3]]];n=n+1;l=d[n];e[l[2]]=e[l[3]];n=n+1;l=d[n];e[l[2]]=(l[3]~=0);n=n+1;l=d[n];o=l[2];h={};i=0;r=o+l[3]-1;for l=o+1,r do i=i+1;h[i]=e[l];end;e[o](t(h,1,r-o));c=o;n=n+1;l=d[n];e[l[2]]=e[l[3]];elseif o>29 then if(e[l[2]]==a[l[5]])then n=n+1;else n=n+l[3];end;else e[l[2]]={};end;elseif o<=32 then if o>31 then e[l[2]][a[l[3]]]=e[l[5]];else f[a[l[3]]]=e[l[2]];end;elseif o==33 then local l=l[2];local n={};local o=c;for l=l+1,o do n[#n+1]=e[l];end;do return e[l](t(n,1,o-l))end;else e[l[2]]=s(D[l[3]],nil,f);end;elseif o<=37 then if o<=35 then e[l[2]]=u[l[3]];elseif o==36 then local n=l[2];local a={};local o=0;local l=n+l[3]-1;for l=n+1,l do o=o+1;a[o]=e[l];end;e[n](t(a,1,l-n));c=n;else n=n+l[3];end;elseif o<=39 then if o>38 then e[l[2]]=e[l[3]];else local o=l[2];local d={};local n=0;local a=o+l[3]-1;for l=o+1,a do n=n+1;d[n]=e[l];end;local a={e[o](t(d,1,a-o))};local l=o+l[5]-2;n=0;for l=o,l do n=n+1;e[l]=a[n];end;c=l;end;elseif o==40 then local o=l[2];local a={};local n=0;local l=o+l[3]-1;for l=o+1,l do n=n+1;a[n]=e[l];end;local a,l=E(e[o](t(a,1,l-o)));l=l+o-1;n=0;for l=o,l do n=n+1;e[l]=a[n];end;c=l;else if not e[l[2]]then n=n+1;else n=n+l[3];end;end;elseif o<=48 then if o<=44 then if o<=42 then local s;local u,o;local o;local i;local h;local r;e[l[2]]=e[l[3]];n=n+1;l=d[n];e[l[2]]=f[a[l[3]]];n=n+1;l=d[n];e[l[2]]=e[l[3]];n=n+1;l=d[n];r=l[2];h={};i=0;o=r+l[3]-1;for l=r+1,o do i=i+1;h[i]=e[l];end;u,o=E(e[r](t(h,1,o-r)));o=o+r-1;i=0;for l=r,o do i=i+1;e[l]=u[i];end;c=o;n=n+1;l=d[n];r=l[2];h={};o=c;for l=r+1,o do h[#h+1]=e[l];end;do return e[r](t(h,1,o-r))end;n=n+1;l=d[n];r=l[2];o=c;s={};i=0;for l=r,o do i=i+1;s[i]=e[l];end;do return t(s,1,i)end;n=n+1;l=d[n];do return end;elseif o>43 then do return end;else local l=l[2];local o=e[l];local n=c-l;for n=1,n do o[n]=e[l+n]end;end;elseif o<=46 then if o>45 then if e[l[2]]then n=n+1;else n=n+l[3];end;else e[l[2]]=s(D[l[3]],nil,f);end;elseif o==47 then local n=l[2];local o={};local l=n+l[3]-1;for l=n+1,l do o[#o+1]=e[l];end;do return e[n](t(o,1,l-n))end;else if(e[l[2]]~=a[l[5]])then n=n+1;else n=n+l[3];end;end;elseif o<=51 then if o<=49 then e[l[2]]=e[l[3]][a[l[5]]];elseif o>50 then e[l[2]]={};else if(e[l[2]]==a[l[5]])then n=n+1;else n=n+l[3];end;end;elseif o<=53 then if o>52 then local n=l[2];local o=(l[5]-1)*50;local a=e[n];local l=c-n;for l=1,l do a[o+l]=e[n+l]end;else local a=D[l[3]];local c;local o={};c=H({},{__index=function(e,l)local l=o[l];return l[1][l[2]];end,__newindex=function(n,l,e)local l=o[l]l[1][l[2]]=e;end;});for c=1,l[5]do n=n+1;local l=d[n];if l[1]==6 then o[c-1]={e,l[3]};else o[c-1]={u,l[3]};end;A[#A+1]=o;end;e[l[2]]=s(a,c,f);end;elseif o==54 then local o=l[2];local a={};local n=0;local d=o+l[3]-1;for l=o+1,d do n=n+1;a[n]=e[l];end;local a={e[o](t(a,1,d-o))};local l=o+l[5]-2;n=0;for l=o,l do n=n+1;e[l]=a[n];end;c=l;else local l=l[2];c=l+B-1;for n=l,c do local l=C[n-l];e[n]=l;end;end;n=n+1;end;end;end;return s(F(),{},W())();
