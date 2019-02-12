PXRMEXCO ; SLC/PKR/PJH - Exchange File component order. ;04/23/2018
 ;;2.0;CLINICAL REMINDERS;**12,47,42**;Feb 04, 2005;Build 120
 ;======================================================
CLIST(IEN,CLOK) ;Build the list of components for the repository
 ;entry IEN.
 K ^TMP($J,"PXRMEX DIALOG")
 N COMIND,COMORDR,CSTART,CSUM,END,FILENAME,FILENUM
 N IND,INDEXAT,IOKTI,ISDGRP,JND,LINE,LRDL,NCMPNT,NITEMS,NLINES,NUCMPNT
 N PT01,SELECT,START,TEMP,TAG,TYPE,UCOM,VERSN,X
 S LINE=^PXD(811.8,IEN,100,1,0)
 ;Make sure it is XML version 1.
 I LINE'["<?xml version=""1.0""" D  Q
 . S CLOK=0
 . W !,"Exchange file entry not in proper format!"
 . H 2
 S LINE=^PXD(811.8,IEN,100,2,0)
 I LINE'="<REMINDER_EXCHANGE_FILE_ENTRY>" D  Q
 . S CLOK=0
 . W !,"Not an Exchange File entry!"
 . H 2
 S LINE=^PXD(811.8,IEN,100,3,0)
 S VERSN=$$GETTAGV^PXRMEXU3(LINE,"<PACKAGE_VERSION>")
 S ISDGRP=$$PATTR^PXRMEXU2(IEN,"GROUPING DIALOG COMPONENTS")
 S LINE=^PXD(811.8,IEN,100,4,0)
 S INDEXAT=+$P(LINE,"<INDEX_AT>",2)
 S LINE=^PXD(811.8,IEN,100,INDEXAT,0)
 I LINE'="<INDEX>" D  Q
 . S CLOK=0
 . W !,"The Index is missing cannot continue, running component check to try to find the problem."
 . H 2
 . D COMPCHK^PXRMEXCC(IEN)
 S CLOK=1
 K ^PXD(811.8,IEN,119),^PXD(811.8,IEN,120)
 S JND=INDEXAT+1
 S LINE=^PXD(811.8,IEN,100,JND,0)
 S NCMPNT=+$$GETTAGV^PXRMEXU3(LINE,"<NUMBER_OF_COMPONENTS>")
 K ^TMP($J,"CMPNT")
 F IND=1:1:NCMPNT D
 . K END,START
 . F  S JND=JND+1,LINE=^PXD(811.8,IEN,100,JND,0) Q:LINE="</COMPONENT>"  D
 .. S TAG=$$GETTAG^PXRMEXU3(LINE)
 .. I TAG["START" S START(TAG)=+$$GETTAGV^PXRMEXU3(LINE,TAG)
 .. I TAG["END" S END(TAG)=+$$GETTAGV^PXRMEXU3(LINE,TAG)
 . I $D(START("<M_ROUTINE_START>")) D
 .. S CSTART=START("<M_ROUTINE_START>")
 .. S ^TMP($J,"CMPNT",IND,"TYPE")="ROUTINE"
 .. S LINE=^PXD(811.8,IEN,100,CSTART+1,0)
 .. S ^TMP($J,"CMPNT",IND,"NAME")=$$GETTAGV^PXRMEXU3(LINE,"<ROUTINE_NAME>")
 .. S ^TMP($J,"CMPNT",IND,"FILENUM")=0
 ..;Save the actual start and end of the code.
 .. S ^TMP($J,"CMPNT",IND,"START")=START("<ROUTINE_CODE_START>")
 .. S ^TMP($J,"CMPNT",IND,"END")=END("<ROUTINE_CODE_END>")
 . I $D(START("<FILE_START>")) D
 .. S CSTART=START("<FILE_START>")
 .. S LINE=^PXD(811.8,IEN,100,CSTART+1,0)
 .. S (^TMP($J,"CMPNT",IND,"TYPE"),^TMP($J,"CMPNT",IND,"FILENAME"))=$$GETTAGV^PXRMEXU3(LINE,"<FILE_NAME>",1)
 .. S LINE=^PXD(811.8,IEN,100,CSTART+2,0)
 .. S ^TMP($J,"CMPNT",IND,"FILENUM")=$$GETTAGV^PXRMEXU3(LINE,"<FILE_NUMBER>")
 .. S LINE=^PXD(811.8,IEN,100,CSTART+3,0)
 .. S (^TMP($J,"CMPNT",IND,"NAME"),^TMP($J,"CMPNT",IND,"POINT_01"))=$$GETTAGV^PXRMEXU3(LINE,"<POINT_01>",1)
 .. S LINE=^PXD(811.8,IEN,100,CSTART+6,0)
 .. S ^TMP($J,"CMPNT",IND,"SELECTED")=$$GETTAGV^PXRMEXU3(LINE,"<SELECTED>")
 ..;Save the actual start and end of the FileMan FDA.
 .. S ^TMP($J,"CMPNT",IND,"FDA_START")=START("<FDA_START>")
 .. S ^TMP($J,"CMPNT",IND,"FDA_END")=END("<FDA_END>")
 .. S ^TMP($J,"CMPNT",IND,"IEN_ROOT_START")=$G(START("<IEN_ROOT_START>"))
 .. S ^TMP($J,"CMPNT",IND,"IEN_ROOT_END")=$G(END("<IEN_ROOT_END>"))
 ;Build some indexes to order the component list.
 F IND=1:1:NCMPNT D
 . S TYPE=^TMP($J,"CMPNT",IND,"TYPE")
 . S FILENUM=^TMP($J,"CMPNT",IND,"FILENUM")
 . S COMIND(FILENUM,IND)=TYPE
 . S UCOM(FILENUM)=""
 ;Build the component order for display and install.
 D CORDER^PXRMEXCO(.UCOM,.NUCMPNT,.COMORDR)
 K ^PXD(811.8,IEN,120)
 ;Set the 0 node.
 S ^PXD(811.8,IEN,120,0)=U_"811.802A"_U_NCMPNT_U_NCMPNT
 F IND=1:1:NUCMPNT D
 . S FILENUM=$O(COMORDR(IND,""))
 . S JND="",NITEMS=0
 . F  S JND=$O(COMIND(FILENUM,JND)) Q:JND=""  D
 .. S TYPE=COMIND(FILENUM,JND)
 .. S NITEMS=NITEMS+1
 .. I TYPE="ROUTINE" D
 ... S TEMP=^TMP($J,"CMPNT",JND,"NAME")_U_^TMP($J,"CMPNT",JND,"START")_U_^TMP($J,"CMPNT",JND,"END")_U_U
 ... S IOKTI=1,SELECT=0
 .. E  D
 ... I FILENUM=811.9 D LRDCHK(IEN,JND,.LRDL)
 ... S TEMP=^TMP($J,"CMPNT",JND,"NAME")_U_^TMP($J,"CMPNT",JND,"FDA_START")_U_^TMP($J,"CMPNT",JND,"FDA_END")_U_$G(^TMP($J,"CMPNT",JND,"IEN_ROOT_START"))_U_$G(^TMP($J,"CMPNT",JND,"IEN_ROOT_END"))
 ... S IOKTI=$S(^TMP($J,"CMPNT",JND,"FDA_START")=^TMP($J,"CMPNT",JND,"FDA_END"):0,1:1)
 ... S SELECT=$S(^TMP($J,"CMPNT",JND,"SELECTED")="YES":1,1:0)
 ... I FILENUM=801.41,'SELECT S SELECT=$$ISLRD(JND,.LRDL)
 .. S TEMP=TEMP_U_IOKTI_U_SELECT
 .. I FILENUM=801.41,ISDGRP=1 D  Q
 ... S ^TMP($J,"PXRMEX DIALOG","LOC",$P(TEMP,U))=TEMP
 ... I SELECT S ^TMP($J,"PXRMEX DIALOG","SELECT",$P(TEMP,U))=0
 .. S ^PXD(811.8,IEN,120,IND,1,NITEMS,0)=TEMP
 . I FILENUM=801.41,ISDGRP=1 Q
 . S ^PXD(811.8,IEN,120,IND,0)=TYPE_U_FILENUM_U_NITEMS
 . S ^PXD(811.8,IEN,120,IND,1,0)=U_"811.8021A"_U_NITEMS_U_NITEMS
 ;
 I $D(^TMP($J,"PXRMEX DIALOG")),ISDGRP=1 D
 .S DCNT=0 D DIALOG(IEN,.DCNT)
 .S IND=$O(^PXD(811.8,IEN,120,""),-1)+1
 .S NITEMS=0
 .S ^PXD(811.8,IEN,120,IND,0)="REMINDER DIALOG^801.41^"_DCNT
 .S ^PXD(811.8,IEN,120,IND,1,0)=U_"811.8021A"_U_DCNT_U_DCNT
 .S X=0 F  S X=$O(^TMP($J,"DIALOG LIST",X)) Q:X'>0  D
 ..S NITEMS=NITEMS+1,^PXD(811.8,IEN,120,IND,1,NITEMS,0)=^TMP($J,"DIALOG LIST",X)
 ;Save the number of component types.
 S ^PXD(811.8,IEN,119)=NUCMPNT
 K ^TMP($J,"CMPNT")
 K ^TMP($J,"PXRMEX DIALOG")
 Q
 ;
 ;======================================================
CORDER(UCOM,NUCMPNT,COMORDR) ;Build the component order for
 ;display and install.
 N DOA,IND,FILENUM,RANK
 D PACKORD^PXRMEXPD(.RANK)
 D ORDER^PXRMEXPD(.UCOM,.RANK,.DOA)
 S (IND,NUCMPNT)=0
 F  S IND=+$O(DOA(IND))  Q:IND=0  D
 . S FILENUM=DOA(IND)
 . S NUCMPNT=NUCMPNT+1
 . S COMORDR(NUCMPNT,FILENUM)=""
 Q
 ;
DIALOG(IEN,DCNT) ;
 K ^TMP($J,"DIALOG LIST")
 N NAME
 S NAME="" F  S NAME=$O(^TMP($J,"PXRMEX DIALOG","SELECT",NAME)) Q:NAME=""  D
 .D DIALBLD(IEN,NAME,.DCNT)
 Q
 ;
DIALBLD(IEN,NAME,DCNT) ;
 N DATA,DARRAY,END,STRT
 S DATA=$G(^TMP($J,"PXRMEX DIALOG","LOC",NAME)) Q:DATA=""
 D CHECKCMP(IEN,NAME,DATA,.DCNT)
 Q
 ;
CHECKCMP(IEN,NAME,DATA,DCNT) ;
 N CMP,CMPARRAY,DDATA,DEND,DFILE,DFNUM,DIENS,DSTRT,DSUB,DVALUE,SEQ,SORTARR,TEMP
 S DSTRT=$P(DATA,U,2),DEND=$P(DATA,U,3)
 S DSUB=DSTRT-1
 F  S DSUB=$O(^PXD(811.8,IEN,100,DSUB)) Q:'DSUB  D  Q:DSUB>DEND
 .S DDATA=$G(^PXD(811.8,IEN,100,DSUB,0)) Q:DDATA=""
 .S DFILE=$P(DDATA,";"),DIENS=$P(DDATA,";",2),DFNUM=$P(DDATA,";",3)
 .Q:DFILE=""  Q:DIENS=""  Q:DFNUM=""
 .S DVALUE=$P(DFNUM,"~",2),DFNUM=$P(DFNUM,"~")
 .Q:DFNUM=""
 .I DFILE'=801.41 S CMPARRAY(DFILE,DIENS,DFNUM)=DVALUE
 .;check branching logic
 .I DFNUM=118 D
 ..S TEMP=$G(^TMP($J,"PXRMEX DIALOG","LOC",DVALUE))
 ..D CHECKCMP(IEN,DVALUE,TEMP,.DCNT)
 ;
 ;check result groups list
 I $D(CMPARRAY(801.41121)) D
 .S DIENS="" F  S DIENS=$O(CMPARRAY(801.41121,DIENS)) Q:DIENS=""  D
 ..S CMP=CMPARRAY(801.41121,DIENS,.01)
 ..S TEMP=$G(^TMP($J,"PXRMEX DIALOG","LOC",CMP))
 ..D CHECKCMP(IEN,CMP,TEMP,.DCNT)
 ;
 ;check components
 I $D(CMPARRAY(801.412)) D
 .S DIENS="" F  S DIENS=$O(CMPARRAY(801.412,DIENS)) Q:DIENS=""  D
 ..S SEQ=CMPARRAY(801.412,DIENS,.01),CMP=CMPARRAY(801.412,DIENS,2)
 ..S SORTARR(SEQ)=CMP
 .S SEQ=0 F  S SEQ=$O(SORTARR(SEQ)) Q:SEQ'>0  D
 ..S CMP=SORTARR(SEQ)
 ..S TEMP=$G(^TMP($J,"PXRMEX DIALOG","LOC",CMP))
 ..D CHECKCMP(IEN,CMP,TEMP,.DCNT)
 ;
 I $D(^TMP($J,"PXRMEX DIALOG","SELECT",NAME)) D
 .I ^TMP($J,"PXRMEX DIALOG","SELECT",NAME)=1 S $P(DATA,U,7)=0 Q
 .S ^TMP($J,"PXRMEX DIALOG","SELECT",NAME)=1
 S DCNT=DCNT+1,^TMP($J,"DIALOG LIST",DCNT)=DATA
 Q
 ;======================================================
ISLRD(ITEM,LRDL) ;Return true if this item is a linked reminder
 ;dialog.
 N NAME
 S NAME=^TMP($J,"CMPNT",ITEM,"NAME")
 Q $S($D(LRDL(NAME)):1,1:0)
 ;
 ;======================================================
LRDCHK(IEN,ITEM,LRDL) ;Check reminder definition for a linked reminder
 ;dialog.
 N END,DATA,DONE,FIELD,FNUM,IND,LINE,START
 S END=^TMP($J,"CMPNT",ITEM,"FDA_END")
 S START=^TMP($J,"CMPNT",ITEM,"FDA_START")
 S DONE=0
 F IND=START:1:END Q:DONE  D
 . S LINE=^PXD(811.8,IEN,100,IND,0)
 . S FNUM=$P(LINE,";",1)
 . S DATA=$P(LINE,";",3)
 . S FIELD=$P(DATA,"~",1)
 . I FIELD=51 S LRDL($P(DATA,"~",2))="",DONE=1
 Q
 ;
