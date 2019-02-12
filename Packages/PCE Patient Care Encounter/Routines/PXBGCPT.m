PXBGCPT ;ISL/JVS,PKR - GATHER CPT ;04/11/2018
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**73,149,124,211**;Aug 12, 1996;Build 325
 ;
CPT(VISIT) ;--Gather the entries in the V CPT file
 ;
 K PXBKY,PXBSAM,PXBSKY,PXBPRV
 I '$D(^AUPNVCPT("AD",VISIT)) S PXBCNT=0 Q
 ;
 N CPT,CPTA,DA,DR,EDATA,EVENTDT,IEN,IENS,FIELDS,GROUP,MODIFIER
 N PROVIDER,PX124,PXBC,PXSFIL,PXMOD,PXSIEN,QUANTITY,VAUGHN
A ;--Set array with CPT codes and associated modifiers
 S FIELDS=".01;.04;.05;.09;.15;.16;1*;1201;1202;1204"
 S IEN=0
 F  S IEN=$O(^AUPNVCPT("AD",VISIT,IEN)) Q:IEN'>0  D
 .K VAUGHN,EDATA
 .S IENS=IEN_","
 .D GETS^DIQ(9000010.18,IENS,FIELDS,"EI","VAUGHN")
 .S CPT=$G(VAUGHN(9000010.18,IENS,".01","I"))
 .S QUANTITY=$G(VAUGHN(9000010.18,IENS,".16","E"))
 .S EVENTDT=$G(VAUGHN(9000010.18,IENS,"1201","I"))
 .I EVENTDT="" S EVENTDT=$P(^AUPNVSIT(VISIT,0),U,1)
 .S PROVIDER=$G(VAUGHN(9000010.18,IENS,"1204","E"))
 .S NARR=$E($G(VAUGHN(9000010.18,IENS,".04","E")),1,29)
 .I NARR="" S NARR=$P($$CPT^ICPTCOD(CPT,EVENTDT),U,3)
 .S EDATA=$E($G(VAUGHN(9000010.18,IENS,1202,"E")),1,29)
 .D CASE^PXBUTL
 .S GROUP=CPT_"^"_QUANTITY_"^"_PROVIDER_"^"_NARR
 .F PX124=.05,.09,.1,.11,.12,.13,.14,.15 D
 ..S DA=$G(VAUGHN(9000010.18,IENS,PX124,"E")),DR=DA,GROUP=GROUP_U_DA
 ..I DA S DR=$$XLATE^PXBGPOV(VISIT,DA),DA=$P(DR,U,2)
 ..I DR S PXBREQ(DA,"I")=$P(DR,U,4,20)
 .K DR,DA
 .S $P(GROUP,U,22)=EDATA,CPTA(CPT,IEN)=GROUP
 .S PXSFIL=9000010.181,PXSIEN=""
 .F  S PXSIEN=$O(VAUGHN(PXSFIL,PXSIEN)) Q:PXSIEN=""  D
 ..S PXMOD=VAUGHN(PXSFIL,PXSIEN,.01,"E")
 ..S CPTA(CPT,IEN,"MOD",+PXSIEN)=PXMOD
 ;
B ;--Add line numbers
 ;
 I $D(CPTA) D
 .S PXBC=0,CPT=""
 .F  S CPT=$O(CPTA(CPT)) Q:CPT=""  D
 ..S IEN=0
 ..F  S IEN=$O(CPTA(CPT,IEN)) Q:IEN=""  S PXBC=PXBC+1 D
 ...S PXBKY(CPT,PXBC)=$G(CPTA(CPT,IEN))
 ...S PXBSAM(PXBC)=$G(CPTA(CPT,IEN))
 ...S PXBSKY(PXBC,IEN)=""
 ...S PXSIEN=0
 ...F  S PXSIEN=$O(CPTA(CPT,IEN,"MOD",PXSIEN)) Q:PXSIEN=""  D
 ....S PXBKY(CPT,PXBC,"MOD",PXSIEN)=CPTA(CPT,IEN,"MOD",PXSIEN)
 ....S PXBSAM(PXBC,"MOD",PXSIEN)=CPTA(CPT,IEN,"MOD",PXSIEN)
 ...I $P($G(CPTA(CPT,IEN)),"^",3)]"" D
 ....S PXBPRV($P($G(CPTA(CPT,IEN)),"^",3),$P($G(CPTA(CPT,IEN)),"^",1),IEN,PXBC)=QUANTITY
 S PXBCNT=+$G(PXBC)
 Q
 ;
