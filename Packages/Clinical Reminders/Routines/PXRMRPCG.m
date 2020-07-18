PXRMRPCG ;SLC/RFR,AGP - PXRM REMINDER DIALOG GENERAL FINDING UPDATE;12/9/2019
 ;;2.0;CLINICAL REMINDERS;**45**;Feb 04, 2005;Build 566
 Q
BLDPARR(PROMPTS) ;
 S PROMPTS("COM")=10
 S PROMPTS("CPT_QTY")=5
 S PROMPTS("DATE")=13
 S PROMPTS("HF_LVL")=5
 S PROMPTS("IMM_CNTR")=8
 S PROMPTS("IMM_RCTN")=7
 S PROMPTS("IMM_SER")=5
 S PROMPTS("PED_LVL")=5
 S PROMPTS("POV_ADD")=7
 S PROMPTS("POV_PRIM")=5
 S PROMPTS("SK_READ")=7
 S PROMPTS("SK_RES")=5
 S PROMPTS("VST_DATE")="VISIT STRING"
 S PROMPTS("VST_LOC")="VISIT STRING"
 S PROMPTS("WH_MAMMOGRAM_RESULTS")=11
 S PROMPTS("WH_NOT_PURP")=12
 S PROMPTS("WH_PAP_RESULTS")=11
 S PROMPTS("XAM_RES")=5
 S PROMPTS("pnumRemGenFindID")=14
 S PROMPTS("pnumRemGenFindNewData")=16
 S PROMPTS("pnumRemGenFindGroup")=17
 S PROMPTS("GF_VIEW")=18
 Q
 ;
CANCEL(RETURN) ;Reminder Dialog Cancel button RPC
 N PXRMOUT
 K ^TMP($J,"PXRM GEN FINDING"),^TMP($J,"PXRM DIALOG EVAL"),^TMP("WVGETORDERS",$J)
 D OUSMALRT^ORBSMART(.PXRMOUT,"")
 Q
 ;
GENFUPD(RETURN,DATA) ;General finding update RPC
 N CNT,ERR,ERRDATA,PACKAGE,PKGDATA,PXRMOUT,SNDDATA,GROUP,LINE,RESULT,INDEX
 D GENFORM(.DATA,.PKGDATA)
 N $ES,$ET S $ET="D DERRHRLR^PXRMERRH"
 S PACKAGE="" F  S PACKAGE=$O(PKGDATA("DATA",PACKAGE)) Q:PACKAGE=""  S GROUP="" F  S GROUP=$O(PKGDATA("DATA",PACKAGE,GROUP)) Q:GROUP=""  D
 .S SNDDATA("DFN")=PKGDATA("DFN"),SNDDATA("VISIT")=$G(PKGDATA("VISIT")),SNDDATA("DOCUMENT")=PKGDATA("DOCUMENT")
 .S SNDDATA("USER")=PKGDATA("USER"),SNDDATA("ENCOUNTER PROVIDER")=PKGDATA("ENCOUNTER PROVIDER")
 .M SNDDATA("DATA")=PKGDATA("DATA",PACKAGE,GROUP)
 .S CNT=1+$G(CNT)
 .I PACKAGE="WOMEN'S HEALTH" D SAVEDATA^WVRPCPT(.RESULT,.SNDDATA)
 .I PACKAGE="ORDER ENTRY/RESULTS REPORTING" D EN^ORBSMART(.RESULT,.SNDDATA)
 .I PACKAGE="CLINICAL REMINDERS" S RESULT(1)=1
 .I $P($G(RESULT(1)),U)=-1 S PKGDATA("ERROR",PACKAGE,GROUP)=RESULT(1)
 .I '$D(RESULT) S PKGDATA("ERROR",PACKAGE,GROUP)=0_U_"The package did not return a status."
 .K SNDDATA,RESULT
 D OUSMALRT^ORBSMART(.PXRMOUT,"")
 K CNT
 S LINE=0
 I $D(PKGDATA("ERROR")) D
 .S RETURN(0)=-1,PACKAGE=""
 .I $G(PKGDATA("ERROR"))'="" S LINE=LINE+1,RETURN(LINE)=$P(PKGDATA("ERROR"),U,2)
 .F  S PACKAGE=$O(PKGDATA("ERROR",PACKAGE)) Q:PACKAGE=""  S GROUP="" F  S GROUP=$O(PKGDATA("ERROR",PACKAGE,GROUP)) Q:GROUP=""  D
 ..I LINE>0 S LINE=LINE+1,RETURN(LINE)=""
 ..S LINE=LINE+1,RETURN(LINE)=PACKAGE_":"
 ..S LINE=LINE+1,RETURN(LINE)=$P(PKGDATA("ERROR",PACKAGE,GROUP),U,2)
 ..Q:$P(PKGDATA("ERROR",PACKAGE,GROUP),U)'=-1
 ..S ERRDATA("DFN")=PKGDATA("DFN"),ERRDATA("VISIT")=$G(PKGDATA("VISIT")),ERRDATA("GROUP")=GROUP,ERRDATA("DOCUMENT")=PKGDATA("DOCUMENT")
 ..M ERRDATA("DATA")=PKGDATA("DATA",PACKAGE,GROUP)
 ..K ^TMP("PXRMXMZ",$J) S CNT=0
 ..S CNT=CNT+1,^TMP("PXRMXMZ",$J,CNT,0)="The following error occurred while saving general findings:"
 ..S CNT=CNT+1,^TMP("PXRMXMZ",$J,CNT,0)=$P(PKGDATA("ERROR",PACKAGE,GROUP),U,2)
 ..S CNT=CNT+1,^TMP("PXRMXMZ",$J,CNT,0)="Please contact the help desk for assistance."
 ..S CNT=CNT+1,^TMP("PXRMXMZ",$J,CNT,0)=" "
 ..S CNT=CNT+1,^TMP("PXRMXMZ",$J,CNT,0)="See below for the data that was not saved:"
 ..S CNT=CNT+1,^TMP("PXRMXMZ",$J,CNT,0)=" "
 ..D ACOPY^PXRMUTIL("ERRDATA","ERR()")
 ..S INDEX=0 F  S INDEX=$O(ERR(INDEX)) Q:INDEX'>0  S CNT=CNT+1,^TMP("PXRMXMZ",$J,CNT,0)=ERR(INDEX)
 ..D SEND^PXRMMSG("PXRMXMZ","Clinical Reminder Error While Storing General Findings")
 I '$D(PKGDATA("ERROR")) S RETURN(1)=1
 Q
 ;
GENFORM(DATA,PKGDATA) ;
 N GIEN,IDS,PIECE,PROMPT,PROMPTS,DIALOG,GROUP,INDEX,FINDINGS
 N FILE,FIELD,VALUE,NDATA,PIEN,PSUB,PACKAGE
 D BLDPARR(.PROMPTS)
 S DIALOG="" F  S DIALOG=$O(DATA(DIALOG)) Q:(DIALOG="")!($D(PKGDATA("ERROR")))  D
 .I DIALOG=0 D  Q
 ..S PKGDATA("DFN")=$P(DATA(DIALOG),U)
 ..;PASSING OF VISIT STRING DISABLED DUE TO CREATION DELAY OF SECONDARY VISIT FOR
 ..;INPATIENTS; REMOVE COMMENTS AROUND VISIT AFTER RELEASE OF PXRM*2*42
 ..;S PKGDATA("VISIT")=$P(DATA(DIALOG),U,2)
 ..S PKGDATA("DOCUMENT")=$P(DATA(DIALOG),U,3)
 ..S PKGDATA("USER")=$P(DATA(DIALOG),U,4)
 ..S PKGDATA("ENCOUNTER PROVIDER")=$P(DATA(DIALOG),U,5)
 ..;I '$P(PKGDATA("VISIT"),";") D  Q
 ..;.S PKGDATA("ERROR")=-1_U_"Invalid visit selection"
 .I $E(DIALOG,1)="R" S DIALOG(1)=$P($G(^PXD(811.9,$P(DIALOG,"R",2),51)),U)
 .E  S DIALOG(1)=DIALOG
 .K INDEX
 .S GROUP="" F  S GROUP=$O(DATA(DIALOG,GROUP)) Q:(GROUP="")!($D(PKGDATA("ERROR")))  D
 ..S INDEX=0 F  S INDEX=$O(DATA(DIALOG,GROUP,"ID",INDEX)) Q:'+INDEX  D
 ...S GIEN=+$P(DATA(DIALOG,GROUP,"ID",INDEX),U)
 ...D GENFIND(.FINDINGS,GIEN) I ($D(FINDINGS("ERROR")))!('FINDINGS(GIEN,"CID")) Q
 ...S PKGDATA("DATA",FINDINGS(GIEN,"PACKAGE"),GROUP,FINDINGS(GIEN,"FILE"),"MASTER ID")=$P(DATA(DIALOG,GROUP,"ID",INDEX),U,2)
 ..S INDEX=0 F  S INDEX=$O(DATA(DIALOG,GROUP,INDEX)) Q:'+INDEX  D
 ...S GIEN=+$P(DATA(DIALOG,GROUP,INDEX),U,2)
 ...I '$D(FINDINGS(GIEN)) D GENFIND(.FINDINGS,GIEN) I $D(FINDINGS("ERROR")) Q
 ...S INDEX(GROUP,FINDINGS(GIEN,"FILE"),INDEX,"GIEN")=GIEN
 .S GROUP="" F  S GROUP=$O(INDEX(GROUP)) Q:GROUP=""  K IDS S FILE=0 F  S FILE=$O(INDEX(GROUP,FILE)) Q:'+FILE  S INDEX=0 F  S INDEX=$O(INDEX(GROUP,FILE,INDEX)) Q:'+INDEX  D
 ..S GIEN=INDEX(GROUP,FILE,INDEX,"GIEN"),VALUE=FINDINGS(GIEN,"VALUE")
 ..S PIECE=PROMPTS("pnumRemGenFindNewData"),NDATA=+$P(DATA(DIALOG,GROUP,INDEX),U,PIECE)
 ..S PIEN=FINDINGS(GIEN,"PIEN"),PSUB=FINDINGS(GIEN,"PROMPT SUBSCRIPT"),PACKAGE=FINDINGS(GIEN,"PACKAGE")
 ..S FIELD=FINDINGS(GIEN,"FIELD")
 ..I NDATA D GETADDID(.IDS,FILE,FIELD)
 ..I 'NDATA D
 ...S PIECE=PROMPTS("pnumRemGenFindID"),IDS("ID")=$P(DATA(DIALOG,GROUP,INDEX),U,PIECE)
 ...I IDS("ID")="" S IDS("ID")=$G(PKGDATA("DATA",PACKAGE,GROUP,FILE,"MASTER ID"))
 ...I IDS("ID")="" D GETADDID(.IDS,FILE,FIELD)
 ..S:VALUE'="" PKGDATA("DATA",PACKAGE,GROUP,FILE,IDS("ID"),FIELD)=VALUE
 ..I +$G(PIEN)>0 D
 ...S PROMPT=$P($G(^PXRMD(801.42,PIEN,0)),U),PIECE=$G(PROMPTS(PROMPT)) I '+PIECE Q
 ...S FIELD=PSUB
 ...I FIELD'="" S PKGDATA("DATA",PACKAGE,GROUP,FILE,IDS("ID"),FIELD)=$P(DATA(DIALOG,GROUP,INDEX),U,PIECE)
 .K ^TMP($J,"PXRM GEN FINDING",DIALOG(1))
 Q
 ;
GETADDID(IDS,FILE,FIELD) ;Return an add new entry ID
 I (FIELD=.01)!(+$G(IDS("NEW",FILE))<1) S IDS("NEW",FILE)=1+$G(IDS("NEW",FILE))
 S IDS("ID")="+"_IDS("NEW",FILE)_","
 Q
 ;
GENFIND(FINDINGS,GIEN) ;Return general finding entry data
 N X0,X1,X2,X3
 S GIEN=+$G(GIEN)
 I '((GIEN>0)&($D(^PXRMD(801.46,GIEN,0)))) S FINDINGS("ERROR")="ENTRY NOT FOUND" Q
 S X0=$G(^PXRMD(801.46,GIEN,0)),X1=$G(^(1)),X2=$G(^(2)),X3=$G(^(3))
 S FINDINGS(GIEN,"FILE")=$P(X0,U,3),FINDINGS(GIEN,"VALUE")=$P(X1,U),FINDINGS(GIEN,"FIELD")=$P(X1,U,2)
 S FINDINGS(GIEN,"TYPE")=$P(X3,U),FINDINGS(GIEN,"CID")=+$P(X3,U,3),FINDINGS(GIEN,"PIEN")=$P(X2,U)
 S FINDINGS(GIEN,"PROMPT SUBSCRIPT")=$P(X2,U,2)
 I FINDINGS(GIEN,"FIELD")="" S FINDINGS(GIEN,"FIELD")=$P(X2,U,2)
 S FINDINGS(GIEN,"PACKAGE")=$$GET1^DIQ(801.46,GIEN_",",2)
 Q
 ;
GENFVALD(RETURN,DATA) ;General finding validate RPC
 N PKGDATA,PACKAGE,SNDDATA,GROUP,RESULT,LINE,RLINE,CNT
 N $ES,$ET S $ET="D DERRHRLR^PXRMERRH"
 D GENFORM(.DATA,.PKGDATA)
 S LINE=0,PACKAGE="" F  S PACKAGE=$O(PKGDATA("DATA",PACKAGE)) Q:PACKAGE=""  S GROUP="" F  S GROUP=$O(PKGDATA("DATA",PACKAGE,GROUP)) Q:GROUP=""  D
 .S SNDDATA("DFN")=PKGDATA("DFN"),SNDDATA("VISIT")=$G(PKGDATA("VISIT")),SNDDATA("DOCUMENT")=PKGDATA("DOCUMENT")
 .M SNDDATA("DATA")=PKGDATA("DATA",PACKAGE,GROUP)
 .I PACKAGE="WOMEN'S HEALTH" D VERDATA^WVRPCPT2(.RESULT,.SNDDATA) S CNT=1+$G(CNT)
 .;There are no other package validation APIs available, so don't report on their data
 .I PACKAGE'="WOMEN'S HEALTH" S RESULT(0)=1
 .I $G(RESULT(0))=-1 S RLINE=0 F  S RLINE=$O(RESULT(RLINE)) Q:'+RLINE  S LINE=LINE+1,PKGDATA("ERROR",PACKAGE,LINE)=RESULT(RLINE)
 .I '$D(RESULT) S LINE=LINE+1,PKGDATA("ERROR",PACKAGE,LINE)="The package did not return a status."
 .K SNDDATA,RESULT
 I $D(PKGDATA("ERROR")) D
 .I $G(PKGDATA("ERROR"))'="" S LINE=LINE+1,RETURN(LINE)=$P(PKGDATA("ERROR"),U,2)
 .S LINE=0,RETURN(0)=-1,PACKAGE="" F  S PACKAGE=$O(PKGDATA("ERROR",PACKAGE)) Q:PACKAGE=""  D
 ..I LINE>0 S LINE=LINE+1,RETURN(LINE)=""
 ..S LINE=LINE+1,RETURN(LINE)=PACKAGE_":"
 ..S RLINE=0 F  S RLINE=$O(PKGDATA("ERROR",PACKAGE,RLINE)) Q:'+RLINE  S LINE=LINE+1,RETURN(LINE)=PKGDATA("ERROR",PACKAGE,RLINE)
 I '$D(RETURN) S RETURN(0)=1
 Q
 ;
GETFIND(RESULT,DFN,VISIT) ;
 N CNT,FILE,FIELD,IDX,PKG,SUB,VALUE
 S SUB="PXRM GF DATA",CNT=0
 K ^TMP(SUB,$J)
 D GETFINDS^WVRPCPT1(SUB,DFN,VISIT)
 I $G(^TMP(SUB,$J))<1 Q
 S PKG="" F  S PKG=$O(^TMP(SUB,$J,PKG)) Q:PKG=""  D
 .S FILE="" F  S FILE=$O(^TMP(SUB,$J,PKG,FILE)) Q:FILE=""  D
 ..S FIELD="" F  S FIELD=$O(^TMP(SUB,$J,PKG,FILE,FIELD)) Q:FIELD=""  D
 ...S VALUE=$G(^TMP(SUB,$J,PKG,FILE,FIELD))
 ...;check for multiple subscript
 ...I VALUE="" D  Q
 ....S IDX=0 F  S IDX=$O(^TMP(SUB,$J,PKG,FILE,FIELD,IDX)) Q:IDX'>0  D
 .....S VALUE=$G(^TMP(SUB,$J,PKG,FILE,FIELD,IDX)) I VALUE="" Q
 .....D GETFIND1(.RESULT,.CNT,PKG,FILE,FIELD,VALUE)
 ...D GETFIND1(.RESULT,.CNT,PKG,FILE,FIELD,VALUE)
 Q
 ;
GETFIND1(RESULT,CNT,PKG,FILE,FIELD,VALUE) ;
 N IEN,NODE,FOUND
 I '$D(^PXRMD(801.46,"PFSV",PKG,FILE,FIELD,VALUE)),'$D(^PXRMD(801.46,"PFSP",PKG,FILE,FIELD)) Q
 ;check value xref
 I $D(^PXRMD(801.46,"PFSV",PKG,FILE,FIELD,VALUE)) D  Q
 .S FOUND=0,IEN=0 F  S IEN=$O(^PXRMD(801.46,"PFSV",PKG,FILE,FIELD,VALUE,IEN)) Q:IEN'>0!(FOUND=1)  D
 ..I $P($G(^PXRMD(801.46,IEN,1)),U,3)=1 Q
 ..S NODE=$G(^PXRMD(801.46,IEN,0)),FOUND=1
 ..S CNT=CNT+1,RESULT(CNT)="GFIND"_U_IEN_U_U_$P(NODE,U)
 ;check prompt type xref
 S FOUND=0,IEN=0 F  S IEN=$O(^PXRMD(801.46,"PFSP",PKG,FILE,FIELD,IEN)) Q:IEN'>0!(FOUND=1)  D
 .I $P($G(^PXRMD(801.46,IEN,1)),U,3)=1 Q
 .S NODE=$G(^PXRMD(801.46,IEN,0)),FOUND=1
 .S CNT=CNT+1,RESULT(CNT)="GFIND"_U_IEN_U_U_$P(NODE,U)
 Q
 ;
GETFINDS(DIEN,FINDINGS) ;
 N CNT,FIND,PROMPT,TEMP
 S FIND=$P($G(^PXRMD(801.41,DIEN,1)),U,5)
 S CNT=0
 I FIND["PXRMD(801.46" D
 .D GENFIND(.TEMP,+FIND) I $D(TEMP("ERROR")) Q
 .S PROMPT=""
 .I TEMP(+FIND,"PIEN")>0 S PROMPTYPE=$P($G(^PXRMD(801.42,TEMP(+FIND,"PIEN"),0)),U)
 .S CNT=CNT+1
 .S FINDINGS(TEMP(+FIND,"PACKAGE"),TEMP(+FIND,"FILE"),CNT)=TEMP(+FIND,"FIELD")_U_TEMP(+FIND,"VALUE")_U_TEMP(+FIND,"PIEN")_U_TEMP(+FIND,"PROMPT SUBSCRIPT")_U_PROMPT
 S FIND="" F  S FIND=$O(^PXRMD(801.41,DIEN,3,"B",FIND)) Q:FIND=""  D
 .K TEMP
 .D GENFIND(.TEMP,+FIND) I $D(TEMP("ERROR")) Q
 .S PROMPT=""
 .I TEMP(+FIND,"PIEN")>0 S PROMPTYPE=$P($G(^PXRMD(801.42,TEMP(+FIND,"PIEN"),0)),U)
 .S CNT=CNT+1
 .S FINDINGS(TEMP(+FIND,"PACKAGE"),TEMP(+FIND,"FILE"),CNT)=TEMP(+FIND,"FIELD")_U_TEMP(+FIND,"VALUE")_U_TEMP(+FIND,"PIEN")_U_TEMP(+FIND,"PROMPT SUBSCRIPT")_U_PROMPT
 Q
 ;
VIEW(RESULT,PAT,IEN,FINDVAL) ;
 N FILE,FINDINGS,CNT,I,LST,NODE1,NODE2,PKG,PROMPTYPE,PXRMDIAG,SUB1,SUB2,TEXT,X,TCNT
 ;
 S RESULT(0)=-1
 D GETFINDS(IEN,.FINDINGS)
 I $D(FINDINGS("WOMEN'S HEALTH")) D VIEWDATA^WVRPCGF1(.RESULT,.FINDINGS,PAT,FINDVAL)
 I $D(FINDINGS("CLINICAL REMINDERS")) D VIEWDATA(.RESULT,.FINDINGS,PAT,IEN,FINDVAL)
 Q
 ;
VIEWDATA(RESULT,DATA,PAT,DIEN,FINDVAL) ;
 N CNT,INARRAY,INC,NIN,NOUT,NODE,OUTARRAY,PKG,PROMPT,PXRMRM,SUB,SUB1,VALUE
 S PKG="CLINICAL REMINDERS"
 ;Cascade Index button
 I $D(DATA(PKG,809)) D
 .S INC=0 F  S INC=$O(DATA(PKG,809,INC)) Q:INC'>0  D
 ..S NODE=$G(DATA(PKG,809,INC))
 ..S SUB=$P(NODE,U),VALUE=$P(NODE,U,2),SUB1=$P(NODE,U,4),PROMPT=$P(NODE,U,5)
 ..I SUB1="MOST RECENT EPISODE" D  Q
 ...I $$OBJ^PXRMCEOC("PXRMRPCG REPORT",PAT,"BREAST CARE")
 ...S RESULT(0)=1_U_"Index mammogram and followup activities (Oldest to Most Recent)"
 ...S CNT=0,I=0 F  S I=$O(^TMP("PXRMRPCG REPORT",$J,I)) Q:I'>0  D
 ....S CNT=CNT+1,RESULT(CNT)=$G(^TMP("PXRMRPCG REPORT",$J,I,0))
 ;Dialog Alternative Progress note text
 I $D(DATA(PKG,801.41)) D
 .S INC=0 F  S INC=$O(DATA(PKG,801.41,INC)) Q:INC'>0  D
 ..S NODE=$G(DATA(PKG,801.41,INC))
 ..S SUB=$P(NODE,U),VALUE=$P(NODE,U,2),SUB1=$P(NODE,U,4),PROMPT=$P(NODE,U,5)
 ..I SUB1="VIEW PROGRESS NOTE TEXT" D
 ...S CNT=0,NIN=0 F  S CNT=$O(^PXRMD(801.41,DIEN,35,CNT)) Q:CNT'>0  D
 ....S NIN=NIN+1,INARRAY(NIN)=^PXRMD(801.41,DIEN,35,CNT,0)
 ...;(INDENT,NIN,TEXTIN,DFN,VSTR,NLINES,TEXT)
 ...S PXRMRM=80,NOUT=0
 ...D FNFTXTO^PXRMFNFT(1,.NIN,.INARRAY,PAT,"",.NOUT,.OUTARRAY)
 ...;D FORMAT^PXRMTEXT(0,80,NIN,.INARRAY,.NOUT,.OUTARRAY)
 ...F CNT=1:1:NOUT S RESULT(CNT)=OUTARRAY(CNT)
 ..S RESULT(0)=1_U_$P(^PXRMD(801.41,DIEN,0),U)
 Q
 ;
FNDWDATA(RESULT,PAT,IEN,FINDVAL,EPNAME) ;
 N CNT,DTE,IEN,INC,LDATE,NODE,TEXT,WVIEN,TCNT
 S DTE=$O(^PXRM(809,"C",PAT,EPNAME,""),-1) Q:DTE'>0
 S IEN=$O(^PXRM(809,"C",PAT,EPNAME,DTE,"")) Q:IEN'>0
 S CNT=0
 S INC=0
 F  S INC=$O(^PXRM(809,IEN,1,INC)) Q:INC'>0  D
 .S NODE=$G(^PXRM(809,IEN,1,INC,0))
 .I $P(NODE,U)'["WV(790.1" Q
 .S WVIEN=+$P(NODE,U)
 .I $$NOOPEN^PXRMCWH(WVIEN,PAT,0,0) Q
 .;D GETTEST(WVIEN,.CNT,.RESULT)
 .S TCNT=0,LDATE=$P(NODE,U,5)
 .D GETWVP^PXRMCEOC(PAT,$P(NODE,U),$P(NODE,U,2),LDATE,1,.TEXT,.TCNT)
 .S TCNT=0 F  S TCNT=$O(TEXT(1,TCNT)) Q:TCNT'>0  S CNT=CNT+1,RESULT(CNT)=TEXT(1,TCNT)
 .S CNT=CNT+1,RESULT(CNT)=""
 Q
 ;
