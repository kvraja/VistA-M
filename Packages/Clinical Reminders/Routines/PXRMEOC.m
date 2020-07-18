PXRMEOC ;SLC/AGP - Reminder Episode of Care;08/12/2017
 ;;2.0;CLINICAL REMINDERS;**45**;Feb 04, 2005;Build 566
 Q
 ;
KILL(VALUE) ;
 I $G(VALUE(2))'="O",+$G(VALUE(1))>0,VALUE(3)'="" Q 1
 Q 0
 ;
SET(VALUE) ;
 I $G(VALUE(2))="O",+$G(VALUE(1))>0,VALUE(3)'="" Q 1
 Q 0
 ;
ADD(PAT,DATE,ITEM,START,CLOSE,NAME,ERROR) ;
 N FDA,IEN,OPEN
 S OPEN=0
 S IEN=$$ISOPEN(PAT,NAME)
 I IEN>0,CLOSE=1 S FDA(809,IEN_",",3)="CLOSED"
 I IEN'>0,START=1 D
 .S FDA(809,"+1,",.01)=DATE
 .S FDA(809,"+1,",1)=NAME
 .S FDA(809,"+1,",2)="`"_PAT
 .S FDA(809,"+1,",3)="OPEN"
 .S IEN=1,OPEN=1
 I IEN'>0 Q
 D ADDITEM(.FDA,IEN,DATE,ITEM,OPEN)
 D UPDATE(.FDA,.ERROR)
 Q
 ;
ADDITEM(FDA,IEN,DATE,ITEM,OPEN) ;
 N EXIST,IENS,ID
 ;S IENS="+"_(IEN+1)_","_$S(OPEN=1:"+",1:"")_IEN_","
 S ID=$$INTITEM(ITEM) I ID="" Q
 S EXIST=$$EXIST(IEN,ITEM,OPEN)
 I EXIST>0 S IENS=EXIST_","_IEN_","
 I EXIST=0 S IENS="+"_(IEN+1)_","_$S(OPEN=1:"+",1:"")_IEN_","
 S FDA(809.04,IENS,.01)=ID
 I EXIST=0 S FDA(809.04,IENS,1)=DATE
 S FDA(809.04,IENS,4)=DATE
 ;I +$G(VISIT)>0 S FDA(809.04,IENS,2)="`"_VISIT
 Q
 ;
CLOSE(RESULT,INPUT) ;
 N DATE,IEN,MSG,NAME,PAT,STATUS
 S NAME=$G(INPUT("NAME")) I NAME="" S RESULT(1)="-1^Cascade name not found" Q
 S STATUS="CLOSED"
 ;S STATUS=$G(INPUT("STATUS")) I STATUS="" S RESULT(1)="-1^Cascade status not found" Q
 S PAT=INPUT("DFN")
 ;I STATUS="CLOSED" S IEN=$O(^PXRM(809,"OPEN",PAT,NAME,"")) I IEN'>0 S RESULT(1)="-1^No open cascade found" Q
 S IEN=$O(^PXRM(809,"OPEN",PAT,NAME,"")) I IEN'>0 S RESULT(1)="-1^No open cascade found" Q
 S DATE=$P($G(^PXRM(809,IEN,0)),U)
 S FDA(809,IEN_",",.01)=DATE
 S FDA(809,IEN_",",3)=STATUS
 D UPDATE^DIE("E","FDA","","MSG")
 I $D(MSG) S RESULT(0)="-1^Could not update exisiting cascade entry" Q
 S RESULT(1)=1
 Q 
 ;
EXIST(IEN,ITEM,OPEN) ;
 N RESULT
 S RESULT=0
 I OPEN=1 Q RESULT
 I '$D(^PXRM(809,IEN,1,"B",ITEM)) Q RESULT
 S RESULT=+$O(^PXRM(809,IEN,1,"B",ITEM,""))
 Q RESULT
 ;
GETOLIST(RESULT,PAT,NAME) ;
 N INC,IEN,NODE
 S IEN=$$ISOPEN(PAT,NAME) I IEN'>0 Q
 S INC=0 F  S INC=$O(^PXRM(809,IEN,1,INC)) Q:INC'>0  D
 .S NODE=$G(^PXRM(809,IEN,1,INC,0)) Q:$P(NODE,U)=""
 .S RESULT($P(NODE,U))=NODE
 Q
 ;
INTITEM(ITEM) ;
 N ARRAY,ID,GBL,RESULT,SYN
 S RESULT=""
 S ID=$P(ITEM,";"),GBL=$P(ITEM,";",2)
 I ID=""!(GBL="") Q ""
 D SETARRAY(.ARRAY)
 S SYN=$G(ARRAY(GBL)) I SYN="" Q ""
 S RESULT=SYN_".`"_ID
 Q RESULT
 ;
ISOPEN(DFN,NAME) ;
 N IEN
 S IEN=+$O(^PXRM(809,"OPEN",DFN,NAME,""))
 Q IEN
 ;
SETARRAY(ARRAY) ;
 S ARRAY("OR(100,")="ORD"
 S ARRAY("WV(790.1,")="WVP"
 S ARRAY("WV(790.4,")="WVN"
 Q
 ;
UPDATE(FDA,ERROR) ;
 N MSG
 D UPDATE^DIE("E","FDA","","MSG")
 I $D(MSG) D ACOPY^PXRMUTIL("MSG","ERROR()")
 Q
