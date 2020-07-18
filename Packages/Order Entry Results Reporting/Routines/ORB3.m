ORB3 ;SLC/CLA,WAT,TC - MAIN ROUTINE FOR OE/RR 3 NOTIFICATIONS ;Jun 19, 2018@11:00
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**31,74,91,105,139,190,220,253,265,296,348,350,452,377**;Dec 17, 1997;Build 582
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;This routine invokes to following ICR(s):
 ;ICR 4156     ;REGISTRATION, COMBAT VETERAN STATUS
 ;ICR 5697     ;SCHEDULING, PCMM MHTC API's
 ;
EN(ORN,ORBDFN,ORNUM,ORBADUZ,ORBPMSG,ORBPDATA,ORFORCE) ;
 ;
 N ORBENT
 S ORN=+$G(ORN)
 S ORBENT=$$ENTITY^ORB31($G(ORNUM))
 ;
 Q:$$GET^XPAR(ORBENT,"ORB SYSTEM ENABLE/DISABLE",1,"I")="D"
 Q:'$L($G(^ORD(100.9,ORN,0)))
 Q:+$$ONOFF^ORB3FN(ORN)=0
 ;
 ;add hook for smart
 N ORHOOK S ORHOOK=$$HOOK^ORBSMART(ORN,$G(ORBDFN),$G(ORNUM),.ORBADUZ,$G(ORBPMSG),$G(ORBPDATA))
 Q:ORHOOK
 ;
 ;if msg from notif file or oc notif (#54), quit if dup w/in past 1 min:
 N ORBDUP,ORBN
 S ORBN=^ORD(100.9,ORN,0)
 I ($P(ORBN,U,4)="NOT")!(ORN=54) D
 .S ORBDUP=$$DUP^ORB31(ORN,$G(ORBDFN),$G(ORBPMSG),$G(ORNUM))
 Q:+$G(ORBDUP)=1
 ;
 N ORBDESC
 S ORBDESC=" Send Alert Notification ("_(+ORN)_") "_$P($G(^ORD(100.9,+ORN,0)),U,1)_"  "
 ;
 N ORQUD S ORQUD=0
 I ORN=90 D START S ORQUD=1
 I ORQUD=0 D QUEUE^ORB31(ORN,$G(ORBDFN),$G(ORNUM),.ORBADUZ,$G(ORBPMSG),$G(ORBPDATA),$H,ORBDESC,$G(DGPMA),.ORFORCE)
 Q
ZTSK ;
 D START
 S ZTREQ="@"
 Q
UTL(ORBU,ORN,ORBDFN,ORNUM,ORBADUZ,ORBPMSG,ORBPDATA,ORFORCE) ;
 Q:$G(ORBU)'=1
START Q:$G(ORN)=""!($G(ORBDFN)="")
 Q:'$L($G(^ORD(100.9,ORN,0)))
 N ORBNOW,ORBID,ORBLOCK,ORBDESC
 S ORBNOW=$$NOW^XLFDT
 S ORBLOCK=0
 ;
 ;lock to prevent concurrent processing by other resource slots:
 I '$D(ORBU) D
 .S ^XTMP("ORBLOCK",0)=$$FMADD^XLFDT(ORBNOW,1,"","","")_U_ORBNOW
 .S ORBID=$P($P($G(ORBPDATA),"|",2),"@")  ;get unique data id
 .I $L(ORBID) D
 ..LOCK +^XTMP("ORBLOCK",ORBDFN,ORN,ORBID):60 E  D  Q
 ...S ORBDESC=" Requeue Alert Notification ("_(+ORN)_") "_$P($G(^ORD(100.9,+ORN,0)),U,1)_"  "
 ...D QUEUE^ORB31(ORN,ORBDFN,$G(ORNUM),.ORBADUZ,$G(ORBPMSG),$G(ORBPDATA),$$HADD^XLFDT($H,"","",5,""),ORBDESC,$G(DGPMA),.ORFORCE) ;requeue in 5 min.
 ...S ORBLOCK=1
 .;
 .I '$L(ORBID) D
 ..LOCK +^XTMP("ORBLOCK",ORBDFN,ORN):60 E  D  Q
 ...S ORBDESC=" Requeue Alert Notification ("_(+ORN)_") "_$P($G(^ORD(100.9,+ORN,0)),U,1)_"  "
 ...D QUEUE^ORB31(ORN,ORBDFN,$G(ORNUM),.ORBADUZ,$G(ORBPMSG),$G(ORBPDATA),$$HADD^XLFDT($H,"","",5,""),ORBDESC,$G(DGPMA),.ORFORCE) ;requeue in 5 min.
 ...S ORBLOCK=1
 .;
 I ORBLOCK=1 D QUIT Q
 ;
DOALERT ; Entry point for alert logic outside of TaskMan
 N ORBDUZ,ORBN,ORBXQAID,ORPTNAM,ORBPRIM,ORBATTD,ORBDEV,ORBENT
 N ORBUI,ORBASPEC,ORBSMSG,ORBADT,ORBSDEV,ORBDEL,ORBDI,ORBTDEV,ORY
 N ORBIDX,ORBFLAGS
 S ORBUI=1,ORBADT=0
 S:'$L($G(ORBPMSG)) ORBPMSG=""
 I '$L(ORBPDATA),(+$G(ORNUM)>0) S ORBPDATA=+$G(ORNUM)_"@"
 S ORBN=^ORD(100.9,ORN,0)
 S ORBIDX=0 F  S ORBIDX=$O(^ORD(100.9,ORN,5,ORBIDX)) Q:'ORBIDX  D
 .S ORBFLAGS=$P($G(^ORD(100.9,ORN,5,ORBIDX,0)),U)
 .S:ORBFLAGS'="" ORBFLAGS(ORBFLAGS)="",ORBFLAGS=""
 ;
 S ORBENT=$$ENTITY^ORB31(ORNUM)
 ;
 N DFN S DFN=ORBDFN,VA200="" D OERR^VADPT
 I ('$L($G(VA("BID"))))!('$L($G(VADM(1)))) D QUIT Q
 I (ORN=18)!(ORN=20)!(ORN=35) S ORBADT=1 ;A/D/T notif
 ;if not an A/D/T notif, get primary & attending from OERR^VADPT:
 I ORBADT=0 S ORBPRIM=+$P(VAIN(2),U),ORBATTD=+$P(VAIN(11),U)
 I ORBADT=1 D ADT^ORB31(ORN,ORBDFN,.ORBPRIM,.ORBATTD,$G(ORDGPMA)) ;A/D/T notif
 I $D(ORBU) D  ;create debug msg
 .S ORBU(ORBUI)="Processing notification: "_$P(ORBN,U),ORBUI=ORBUI+1
 .S ORBU(ORBUI)="            for patient: "_VADM(1),ORBUI=ORBUI+1
 .I $G(ORNUM)>0 S ORBU(ORBUI)="              for order: "_ORNUM,ORBUI=ORBUI+1
 D REGULAR^ORB3REG(ORN,.XQA,.ORBU,.ORBUI,.ORBDEV,ORBDFN)
 D SPECIAL^ORB3SPEC(ORN,.ORBASPEC,.ORBU,.ORBUI,$G(ORNUM),ORBDFN,$G(ORBPDATA),.ORBSMSG,$G(ORBPMSG),.ORBSDEV,$G(ORBPRIM),$G(ORBATTD))
 I $D(ORBASPEC)>1 D SPECDUZS ;special recips
 I $D(ORBADUZ)>1 D PKGDUZS ;pkg-supplied recips
 D TITLE ;provider recips
 S ORBXQAID=$P(ORBN,U,2)_","_ORBDFN_","_ORN
 ;
 I ($D(XQA)>1)!($D(ORBDEV)>1)!($D(ORBSDEV)>1) D  ;recips found
 .S XQAFLG=$P(ORBN,U,5)
 .S XQADFN=ORBDFN
 .I XQAFLG="R" S XQAROU=$P(ORBN,U,6)_U_$P(ORBN,U,7)
 .I $G(ORBPDATA)'="" S XQADATA=ORBPDATA
 .S ORPTNAM=$E(VADM(1)_"         ",1,9)
 .I $G(ORN)=27 N CVMRKR,RSLT S RSLT=$$CVEDT^DGCV(DFN) I $P($G(RSLT),U)&($P($G(RSLT),U,3)) S CVMRKR=" CV "_$$FMTE^XLFDT($P($G(RSLT),U,2),"5DZ") ;WAT
 .S XQAMSG=ORPTNAM_" ("_$E(ORPTNAM)_$E(VA("BID"),1,4)_")"_$G(CVMRKR)_": " ;WAT
 .S XQAMSG=XQAMSG_$S(ORBPMSG'="":ORBPMSG,1:$P(ORBN,U,3))
 .S XQAARCH=$$GET^XPAR(ORBENT,"ORB ARCHIVE PERIOD",ORN,"I")
 .S XQASUPV=$$GET^XPAR(ORBENT,"ORB FORWARD SUPERVISOR",ORN,"I")
 .S XQASURO=$$GET^XPAR(ORBENT,"ORB FORWARD SURROGATES",ORN,"I")
 .S XQAREVUE=$$GET^XPAR(ORBENT,"ORB FORWARD BACKUP REVIEWER",ORN,"I")
 .S XQACNDEL=$$GET^XPAR(ORBENT,"ORB REMOVE",ORN,"I")
 .S XQACNDEL=$S(XQACNDEL=1:1,1:"")
 .I ORN=90 M XQATEXT=ORBPMSG
 .I $D(ORBDEV)>1 D REGDEV^ORB31(.ORBDEV)
 .I $D(ORBSDEV)>1 D REGDEV^ORB31(.ORBSDEV)
 .I $D(ORBTDEV)>1 D REGDEV^ORB31(.ORBTDEV)
 .S XQAID=ORBXQAID
 .I $D(ORBFLAGS("ONPP")) D COMDUP
 .I $D(XQA) D SETUP^XQALERT  ;if no [new] recips don't send alert
QUIT ;
 K VA,VA200,VADM,VAERR,VAIN,XQA,XQADATA,XQAID,XQAFLG,XQAMSG,XQAROU,XQAARCH,XQASUPV,XQASURO,XQADFN,XQACNDEL,XQAREVUE
 K ^XTMP("ORBUSER",$J)
 I '$D(ORBU),$D(ORBLOCK) D
 .I $G(ORBID)]"" LOCK -^XTMP("ORBLOCK",ORBDFN,ORN,ORBID)
 .E  LOCK -^XTMP("ORBLOCK",ORBDFN,ORN)
 Q
PKGDUZS ;get DUZs from pkg-passed ORBADUZ() array
 N ORBPDUZ
 I $D(ORBU) D
 .S ORBU(ORBUI)=" ",ORBUI=ORBUI+1
 .I ORN=68 S ORBU(ORBUI)="Recipients with Lab Threshold Exceeded:",ORBUI=ORBUI+1
 .E  S ORBU(ORBUI)="Recipients defined when notif was triggered:",ORBUI=ORBUI+1
 S ORBPDUZ=""
 F  S ORBPDUZ=$O(ORBADUZ(ORBPDUZ)) Q:ORBPDUZ=""  S ORBDUZ=ORBPDUZ D USER
 Q
SPECDUZS ;get DUZs rtn by SPECIAL^ORB3SPEC
 N ORBSDUZ
 I $D(ORBU) D
 .S ORBU(ORBUI)=" ",ORBUI=ORBUI+1
 .S ORBU(ORBUI)="Special recipients associated with the notification:",ORBUI=ORBUI+1
 S ORBSDUZ=""
 F  S ORBSDUZ=$O(ORBASPEC(ORBSDUZ)) Q:ORBSDUZ=""  S ORBDUZ=ORBSDUZ D USER
 Q
TITLE ;get provider recips
 N TITLES
 I $D(ORBU) D
 .S ORBU(ORBUI)=" ",ORBUI=ORBUI+1
 .S ORBU(ORBUI)="Recipients determined by Provider Recipient parameter:",ORBUI=ORBUI+1
 ;
 S TITLES=$$GET^XPAR(ORBENT,"ORB PROVIDER RECIPIENTS",ORN,"I")
 I TITLES["P" D PRIMARY
 I TITLES["A" D ATTEND
 I TITLES["T" D TEAMS
 I TITLES["O" D ORDERER
 I TITLES["E" D ENTERBY
 I TITLES["R" D PCMMPRIM
 I TITLES["S" D PCMMASSC
 I TITLES["M" D PCMMTEAM
 I TITLES["C" D PCMMMHTC
 Q
PRIMARY ;
 I $D(ORBU),ORBADT=0 S ORBU(ORBUI)=" Inpt primary provider:",ORBUI=ORBUI+1
 I $D(ORBU),ORBADT=1 S ORBU(ORBUI)=" Inpt primary provider: option cannot determine without A/D/T event data.",ORBUI=ORBUI+1
 I +$G(ORBPRIM)>0 S ORBDUZ=ORBPRIM D USER
 Q
ATTEND ;
 I $D(ORBU),ORBADT=0 S ORBU(ORBUI)=" Attending physician:",ORBUI=ORBUI+1
 I $D(ORBU),ORBADT=1 S ORBU(ORBUI)=" Attending physician: option cannot determine without A/D/T event data.",ORBUI=ORBUI+1
 I +$G(ORBATTD)>0 S ORBDUZ=ORBATTD D USER
 Q
TEAMS ;
 I $D(ORBU) S ORBU(ORBUI)=" Teams/Personal Lists related to patient:",ORBUI=ORBUI+1
 N ORBLST,ORBI,ORBJ,ORBTM,ORBTNAME,ORBTTYPE,ORBTD
 D TMSPT^ORQPTQ1(.ORBLST,ORBDFN)
 Q:+$G(ORBLST(1))<1
 S ORBI="" F  S ORBI=$O(ORBLST(ORBI)) Q:ORBI=""  D
 .S ORBTM=$P(ORBLST(ORBI),U),ORBTNAME=$P(ORBLST(ORBI),U,2)
 .S ORBTTYPE=$P(ORBLST(ORBI),U,3)
 .I $D(ORBU) D
 ..S ORBU(ORBUI)="  Patient list "_ORBTNAME_" ["_ORBTTYPE_"]:",ORBUI=ORBUI+1
 .N ORBLST2 D TEAMPROV^ORQPTQ1(.ORBLST2,ORBTM)
 .Q:+$G(ORBLST2(1))<1
 .S ORBJ="" F  S ORBJ=$O(ORBLST2(ORBJ)) Q:ORBJ=""  D
 ..S ORBDUZ=$P(ORBLST2(ORBJ),U)_U_ORBTM I +$G(ORBDUZ)>0 D USER
 .;
 .S ORBTD=$P($$TMDEV^ORB31(ORBTM),U,2)  ;Team's device
 .I $L(ORBTD) D
 ..S ORBTDEV(ORBTD)=""
 ..I $D(ORBU) D
 ...S ORBU(ORBUI)="   Team's Device "_ORBTD_" is a recipient",ORBUI=ORBUI+1
 Q
ORDERER ;
 Q:+$G(ORNUM)<1
 I $D(ORBU) S ORBU(ORBUI)=" Ordering provider:",ORBUI=ORBUI+1
 N ORBLST,ORBI,ORBTM,ORBJ,ORBTNAME,ORBPLST,ORBPI,ORBPTM,ORBTTYPE
 S ORBDUZ=$S(ORN=12:+$$UNSIGNOR^ORQOR2(ORNUM),1:$$ORDERER^ORQOR2(ORNUM))
 I +$G(ORBDUZ)>0 D
 .D USER
 .;if notif = Order Req E/S (#12) or Order Req Co-sign (#37) and
 .;user doesn't have ES authority, send to fellow team members w/ES:
 .I ((ORN=12)!(ORN=37)),('$D(^XUSEC("ORES",ORBDUZ))) D
 ..I $D(ORBU) S ORBU(ORBUI)=" Orderer can't elec sign, getting teams orderer belongs to:",ORBUI=ORBUI+1
 ..D TEAMPR^ORQPTQ1(.ORBLST,ORBDUZ)  ;get orderer's tms
 ..Q:+$G(ORBLST(1))<1
 ..D TMSPT^ORQPTQ1(.ORBPLST,ORBDFN)  ;get pt's tms
 ..Q:+$G(ORBPLST(1))<1
 ..S ORBI="" F  S ORBI=$O(ORBLST(ORBI)) Q:ORBI=""  D
 ...S ORBPI="" F  S ORBPI=$O(ORBPLST(ORBPI)) Q:ORBPI=""  D
 ....S ORBTM=$P(ORBLST(ORBI),U),ORBPTM=$P(ORBPLST(ORBPI),U)
 ....I ORBTM=ORBPTM D  ;if pt is on provider's team
 .....I +$G(ORBPTM)>0 D
 ......S ORBTNAME=$P(ORBPLST(ORBPI),U,2)
 ......S ORBTTYPE=$P(ORBPLST(ORBPI),U,3)
 ......I $D(ORBU) S ORBU(ORBUI)="  Orderer's pt list "_ORBTNAME_" ["_ORBTTYPE_"] recipients: ",ORBUI=ORBUI+1
 ......N ORBLST2 D TEAMPROV^ORQPTQ1(.ORBLST2,ORBPTM)
 ......Q:+$G(ORBLST2(1))<1
 ......S ORBJ="" F  S ORBJ=$O(ORBLST2(ORBJ)) Q:ORBJ=""  D
 .......S ORBDUZ=$P(ORBLST2(ORBJ),U)_U_ORBPTM I +$G(ORBDUZ)>0,($D(^XUSEC("ORES",+ORBDUZ))) D USER
 Q
ENTERBY ;
 I $D(ORBU) S ORBU(ORBUI)=" User entering order's most recent activity:",ORBUI=ORBUI+1
 Q:+$G(ORNUM)<1
 I $D(^OR(100,ORNUM,8,0)) D
 .S ORBDUZ=$P(^OR(100,ORNUM,8,$P(^OR(100,ORNUM,8,0),U,3),0),U,13)
 I +$G(ORBDUZ)>0 D USER
 Q
PCMMPRIM ;
 I $D(ORBU) S ORBU(ORBUI)=" PCMM Primary Care Practitioner:",ORBUI=ORBUI+1
 S ORBDUZ=+$$OUTPTPR^SDUTL3(ORBDFN,$$NOW^XLFDT,1)  ;DBIA #1252
 I +$G(ORBDUZ)>0 D USER
 Q
PCMMASSC ;
 I $D(ORBU) S ORBU(ORBUI)=" PCMM Associate Provider:",ORBUI=ORBUI+1
 S ORBDUZ=+$$OUTPTAP^SDUTL3(ORBDFN,$$NOW^XLFDT)  ;DBIA #1252
 I +$G(ORBDUZ)>0 D USER
 Q
PCMMTEAM ;
 N ORPCMM,ORPCMMDZ
 I $D(ORBU) S ORBU(ORBUI)=" PCMM Team Position Assignments:",ORBUI=ORBUI+1
 S ORPCMM=$$PRPT^SCAPMC(ORBDFN,,,,,,"^TMP(""ORPCMM"",$J)",)  ;DBIA #1916
 S ORPCMMDZ=0
 F  S ORPCMMDZ=$O(^TMP("ORPCMM",$J,"SCPR",ORPCMMDZ)) Q:'ORPCMMDZ  D
 .S ORBDUZ=ORPCMMDZ D USER
 K ^TMP("ORPCMM",$J)
 Q
PCMMMHTC ;
 I $D(ORBU) S ORBU(ORBUI)=" PCMM Mental Health Treatment Coordinator:",ORBUI=ORBUI+1
 S ORBDUZ=+$$START^SCMCMHTC(ORBDFN)  ;DBIA #5697
 I +$G(ORBDUZ)>0 D USER
 Q
USER ;should USER (ORBDUZ) be a recip
 D USER^ORB3USER(.XQA,ORBDUZ,ORN,.ORBU,.ORBUI,ORBDFN,+$G(ORNUM))
 I $D(ORFORCE(ORBDUZ)) S XQA(ORBDUZ)=""
 Q
COMDUP ; Combine XQADATA from existing alert(s) with new alert, delete existing alert
 ;and then generate the new alert for the current individual user
 N ORVAR,ORDUZ,ORAID,ORODATA
 F ORVAR="XQA","XQADATA","XQAID","XQAFLG","XQAMSG","XQAROU","XQAARCH","XQASUPV","XQASURO","XQADFN","XQACNDEL","XQAREVUE","XQAOPT","XQAEXIT","XQAUSER"  D
 .Q:'$D(@ORVAR)
 .I $D(@ORVAR)<10 S ORVAR(ORVAR)=$G(@ORVAR)
 .I $D(@ORVAR)>9 M ORVAR(ORVAR)=@ORVAR
 .S ORVAR(0,ORVAR)=""
 S ORDUZ=0 F  S ORDUZ=$O(XQA(ORDUZ)) Q:'+ORDUZ  D
 .N ORDATA,ORGEN
 .K ^TMP($J,"ORB3DATA")
 .D USER^XQALERT($NA(^TMP($J,"ORB3DATA")),ORDUZ)
 .S ORAID=0 F  S ORAID=$O(^TMP($J,"ORB3DATA",ORAID)) Q:'+ORAID  D
 ..Q:$P($P(^TMP($J,"ORB3DATA",ORAID),U,2),";")'=($P(ORBN,U,2)_","_ORBDFN_","_ORN)
 ..I $P(ORBN,U,4)="PKG",$P(^TMP($J,"ORB3DATA",ORAID),U)'[ORVAR("XQAMSG") Q
 ..N XQAID,XQADATA,XQAOPT,XQAROU,XQAUSER,XQAKILL
 ..N XQADFN,XQAMSG,XQAFLG,XQADFN,XQAARCH,XQASUPV,XQASURO,XQAREVUE,XQACNDEL
 ..K ^TMP($J,"ORB3ADATA")
 ..D ALERTDAT^XQALBUTL($P(^TMP($J,"ORB3DATA",ORAID),U,2),$NA(^TMP($J,"ORB3ADATA")))
 ..S XQADATA=$G(^TMP($J,"ORB3ADATA",2))
 ..K ^TMP($J,"ORB3ADATA")
 ..I XQADATA'="" D  Q:'$G(ORGEN)
 ...I $D(ORBFLAGS("CD")) D
 ....N OROLD,ORNEW,ORSPEC,ORIDX
 ....S OROLD=U_$S(XQADATA[";":$P(XQADATA,";",2),1:XQADATA)_U,ORNEW=U_$S(ORVAR("XQADATA")[";":$P(ORVAR("XQADATA"),";",2),1:ORVAR("XQADATA"))_U
 ....S ORSPEC(U)=""
 ....F ORIDX=2:1:$L(ORNEW,U) I OROLD[(U_$P(ORNEW,U,ORIDX)_U) S $P(ORNEW,U,ORIDX)=""
 ....S ORNEW=$$REPLACE^XLFSTR(ORNEW,.ORSPEC)
 ....I ORNEW="" K ORVAR("XQA",ORDUZ) Q
 ....S ORDATA=$S(XQADATA[";":$P(XQADATA,";",2),1:XQADATA)_$S($G(ORDATA)'="":U_ORDATA,1:"")
 ....S ORGEN=1
 ...I '$D(ORBFLAGS("CD")),XQADATA=$G(ORVAR("XQADATA")) S ORGEN=2
 ..S XQAUSER=ORDUZ,XQAID=$P(^TMP($J,"ORB3DATA",ORAID),U,2),XQAKILL=1
 ..D DELETE^XQALERT
 .Q:$G(ORGEN)'=1
 .I $G(XQADATA)'=""!($G(ORDATA)'="") S ORODATA=$G(XQADATA)_$S($G(ORDATA)'="":U_ORDATA,1:"")
 .K ORVAR("XQA",ORDUZ)
 .D XQRESTOR
 .N XQA,XQADATA
 .S XQA(ORDUZ)="",XQADATA=ORODATA D SETUP^XQALERT
 K ^TMP($J,"ORB3DATA")
 D XQRESTOR
 Q
XQRESTOR ; Restore XQA* variables saved off in COMDUP
 S ORVAR="" F  S ORVAR=$O(ORVAR(0,ORVAR)) Q:$G(ORVAR)=""  K @ORVAR
 S ORVAR="?" F  S ORVAR=$O(ORVAR(ORVAR)) Q:$G(ORVAR)=""  D
 .I $D(ORVAR(ORVAR))<10 S @ORVAR=ORVAR(ORVAR)
 .I $D(ORVAR(ORVAR))>9 M @ORVAR=ORVAR(ORVAR)
 Q
